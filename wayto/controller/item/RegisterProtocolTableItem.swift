//
// Created by angcyo on 21/08/30.
//

import Foundation
import UIKit
import SwiftRichString

/// 注册协议item

class RegisterProtocolTableItem: DslTableItem {

    override func bindCell(_ cell: DslCell, _ indexPath: IndexPath) {
        super.bindCell(cell, indexPath)

        guard let cell = cell as? RegisterProtocolTableCell else {
            return
        }

        //去掉group的背景
        cell.backgroundColor = UIColor.clear

        cell.cellConfig.checkButton.setTextSize(Res.text.body.size)
        cell.cellConfig.checkButton.setText("我已阅读并同意")

        cell.cellConfig.linkLabel.setTextSize(Res.text.body.size)
        cell.cellConfig.linkLabel.setText("《注册协议》")

        cell.cellConfig.linkLabel.onClick { _ in
            message("click")
        }
    }
}

class RegisterProtocolTableCell: DslTableCell {

    fileprivate let cellConfig: RegisterProtocolTableCellConfig = RegisterProtocolTableCellConfig()

    override func getCellConfig() -> IDslCellConfig? {
        cellConfig
    }
}

//MARK: cell 界面声明, 用于兼容UITableView和UICollectionView

class RegisterProtocolTableCellConfig: IDslCellConfig {

    /// 打底的布局
    let formRoot = flowLayout(space: 0)

    let checkButton = mbCheckboxButton()
    let linkLabel = labelView(color: Res.color.colorPrimary)

    func getRootView() -> UIView {
        formRoot
    }

    func initCellConfig(_ cell: UIView) {
        formRoot.mWwH()
        formRoot.setPaddingVertical(Res.size.leftMargin)
        //formRoot.backgroundColor = UIColor.red

        formRoot.render(checkButton) {
            $0.wrap_content()
        }
        formRoot.render(linkLabel) {
            $0.wrap_content()
        }
    }
}