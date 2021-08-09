//
// Created by angcyo on 21/08/06.
//

import Foundation
import UIKit

class EditPasswordCell: DslTableCell {

    let label = labelView(color: Res.text.body.color)

    let textField = secureTextField()

    let line = hLine()

    override func initCell() {
        super.initCell()

        let offset = Res.size.leftMargin

        contentView.render(label) { view in
            //view.sizeToFit()
            view.makeWidth(80)
            view.makeGravityLeft(offset: offset)
            view.makeCenterY()
        }

        textField.borderStyle = .none //去掉边框
        contentView.render(textField) { view in
            //view.sizeToFit()
            view.makeHeight(50)
            view.makeLeftToRightOf(self.label)
            view.makeGravityRight(offset: -offset)
            view.makeCenterY()
        }

        //横线
        contentView.render(line) { line in
            line.makeGravityLeft(offset: offset)
            line.makeGravityRight(offset: -offset)
            line.makeBottomToBottomOf(self.contentView)
        }
    }
}

extension DslItem {
    static var editPasswordCell: DslTableItem {
        let item = DslTableItem(EditPasswordCell.self)
        item.itemHeight = 50
//        item.itemHeaderHeight = 0.01
//        item.itemFooterHeight = 0.01
//        item.itemHeaderEstimatedHeight = 0.01
//        item.itemFooterEstimatedHeight = 0.01

        item.itemCanHighlight = false
        item.itemCanSelect = false
        return item
    }
}