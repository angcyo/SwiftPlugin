//
// Created by angcyo on 21/08/06.
//

import Foundation
import UIKit

class EditPasswordTableItem: DslTableItem, ITextFieldItem, IFormItem {

    var textFieldItemConfig: TextFieldItemConfig = TextFieldItemConfig()

    var formItemConfig: FormItemConfig = FormItemConfig()

    override func initItem() {
        itemCell = EditPasswordTableCell.self

        itemHeight = 50
//        item.itemHeaderHeight = 0.01
//        item.itemFooterHeight = 0.01
//        item.itemHeaderEstimatedHeight = 0.01
//        item.itemFooterEstimatedHeight = 0.01

        itemCanHighlight = false
        itemCanSelect = false
    }

    override func bindCell(_ cell: DslCell, _ indexPath: IndexPath) {
        super.bindCell(cell, indexPath)
        guard let cell = cell as? EditPasswordTableCell else {
            return
        }
        initEditItem(cell.textField)
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        textFieldItemConfig.itemEditText = textField.text
        formItemConfig.formValue = textField.text
        itemChange = true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

class EditPasswordTableCell: DslTableCell {

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
            view.makeGravityRight(offset: offset)
            view.makeCenterY()
        }

        //横线
        contentView.render(line) { line in
            line.makeGravityLeft(offset: offset)
            line.makeGravityRight(offset: offset)
            line.makeBottomToBottomOf(self.contentView)
        }
    }
}