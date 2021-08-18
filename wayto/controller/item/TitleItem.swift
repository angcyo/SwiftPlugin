//
// Created by angcyo on 21/08/16.
//

import Foundation
import UIKit

class TitleItem: DslTableItem {

    var itemTitle: String? = nil
    var itemIcon: UIImage? = nil

    override func initItem() {
        super.initItem()
        itemCell = TitleCell.self
    }

    override func bindCell(_ cell: DslCell, _ indexPath: IndexPath) {
        super.bindCell(cell, indexPath)

        guard let cell = cell as? TitleCell else {
            return
        }

        cell.title.text = itemTitle
        cell.icon.image = itemIcon
    }
}

class TitleCell: DslTableCell {

    let root = frameLayout()
    let title = titleView()
    let icon = iconView()

    override func initCell() {
        super.initCell()

        root.tg_cacheEstimatedRect = true

        root.setPaddingHorizontal(Res.size.leftMargin)
        root.mWwH(minHeight: Res.size.minHeight)
        root.render(title) {
            $0.wrap_content()
            $0.frameGravityLC()
        }
        root.render(icon) {
            $0.wrap_content()
            $0.frameGravityRC()
        }

        renderCell(root)
    }

    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        //super.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: horizontalFittingPriority, verticalFittingPriority: verticalFittingPriority)
        root.sizeThatFits(CGSize(width: targetSize.width - safeAreaInsets.left - safeAreaInsets.right, height: targetSize.height))
    }
}