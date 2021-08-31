//
// Created by angcyo on 21/08/31.
//

import Foundation
import UIKit

/// 授权界面, 上传身份证正反面的item

class AuthCameraItem: DslTableItem, IFormItem {

    var formItemConfig = FormItemConfig()

    /// label文本
    var itemAuthLabel: String? = nil

    /// 占位图片
    var itemAuthPlaceholderImage: UIImage? = nil

    /// 选择的图片
    var itemAuthImage: Any? = nil {
        didSet {
            updateFormItemValue(itemAuthImage)
        }
    }

    override func initItem() {
        super.initItem()
        formItemConfig.formVerify = true
        formItemConfig.formVerifyErrorTip = "请上传身份证"

        onItemClick = {
            pickerPhoto(crop: false) {
                self.itemAuthImage = $0.image
                self.itemUpdate = true
            }
        }
    }

    override func bindCell(_ cell: DslCell, _ indexPath: IndexPath) {
        super.bindCell(cell, indexPath)

        guard let cell = cell as? AuthCameraCell else {
            return
        }

        cell.cellConfig.image.setImage(itemAuthImage ?? itemAuthPlaceholderImage)
        cell.cellConfig.label.setText(itemAuthLabel)
        cell.cellConfig.icon.setVisible(itemAuthImage == nil)
    }

}

class AuthCameraCell: DslTableCell {

    fileprivate let cellConfig: AuthCameraCellConfig = AuthCameraCellConfig()

    override func getCellConfig() -> IDslCellConfig? {
        cellConfig
    }

}

//MARK: cell 界面声明, 用于兼容UITableView和UICollectionView

class AuthCameraCellConfig: IDslCellConfig {

    let borderView = view()
    let image = img()
    let icon = img(R.image.icon_camera())
    let label = labelView()

    func getRootView(_ cell: UIView) -> UIView {
        cell.cellContentView
    }

    func initCellConfig(_ cell: UIView) {
        cell.cellContentView.render(borderView)
        cell.cellContentView.render(image)
        cell.cellContentView.render(icon)
        cell.cellContentView.render(label)

        borderView.setBorder(UIColor.parse("#E0E1EB"), radii: Res.size.roundMin)
        with(borderView) {
            $0.makeGravityTop(offset: Res.size.x)
            $0.makeGravityHorizontal(offset: Res.size.x)
            $0.makeHeight(minHeight: 160)
            //$0.makeBottomToTopOf(label, offset: Res.size.x)
        }

        with(label) {
            $0.sizeToFit()
            $0.makeTopToBottomOf(borderView, offset: Res.size.x)
            $0.makeCenterX(borderView)
            $0.makeGravityBottom(offset: Res.size.xx)
        }

        image.contentMode = .scaleAspectFit
        with(image) {
            $0.makeEdge(borderView, inset: insets(left: 45, top: 18, right: 45, bottom: 18))
            $0.makeHeight(130)
        }

        icon.contentMode = .scaleAspectFit
        with(icon) {
            $0.makeWidthHeight(size: 48)
            $0.makeCenter(borderView)
        }
    }
}