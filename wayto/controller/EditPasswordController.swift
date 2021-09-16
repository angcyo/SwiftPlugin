//
// Created by angcyo on 21/08/06.
//

import Foundation
import UIKit

/// 修改密码
class EditPasswordController: BaseTableViewController {

    override func initControllerView() {
        super.initControllerView()
        title = "修改密码"
    }

    override func createTableView() -> DslTableView {
        DslTableView(style: .insetGrouped)
    }

    override func initTableView(recyclerView: DslTableView) {
        super.initTableView(recyclerView: recyclerView)

        recyclerView.load(EditPasswordTableItem()) { item in
            item.formItemConfig.formKey = "oldPassword"
            item.textFieldItemConfig.itemEditMaxLength = Res.size.passwordMaxLength
            item.formItemConfig.formCheck = { params, closure in
                if nilOrEmpty(item.textFieldItemConfig.itemEditText) {
                    closure(error("请输入旧密码"))
                } else {
                    closure(nil)
                }
            }
            item.onBindCellOverride = { cell, path in
                if let cell = cell as? EditPasswordTableCell {
                    cell.label.text = "旧密码"
                    cell.textField.placeholder = "请输入"
                }
            }
        }
        recyclerView.load(EditPasswordTableItem()) { item in
            item.formItemConfig.formKey = "newPassword"
            item.textFieldItemConfig.itemEditMaxLength = Res.size.passwordMaxLength
            item.formItemConfig.formCheck = { params, closure in
                if nilOrEmpty(item.textFieldItemConfig.itemEditText) {
                    closure(error("请输入新密码"))
                } else {
                    closure(nil)
                }
            }
            item.onBindCellOverride = { cell, path in
                if let cell = cell as? EditPasswordTableCell {
                    cell.label.text = "新密码"
                    cell.textField.placeholder = "请输入"
                }
            }
        }
        recyclerView.load(EditPasswordTableItem()) { item in
            item.textFieldItemConfig.itemEditMaxLength = Res.size.passwordMaxLength
            item.formItemConfig.formCheck = { params, closure in
                if nilOrEmpty(item.textFieldItemConfig.itemEditText) {
                    closure(error("请输入新密码"))
                } else if (params.jsonData["newPassword"].rawString() != item.textFieldItemConfig.itemEditText) {
                    closure(error("两次密码,不一致"))
                } else {
                    closure(nil)
                }
            }
            item.onBindCellOverride = { cell, path in
                if let cell = cell as? EditPasswordTableCell {
                    cell.label.text = "重复新密码"
                    cell.textField.placeholder = "请输入"

                    cell.line.isHidden = true
                }
            }
        }

        recyclerView.load(DslButtonTableItem()) {
            $0.itemSectionName = "submit"
            $0.itemButtonText = "保存"
            $0.onItemClick = {
                self.submit()
            }
        }
    }

    /// 提交
    func submit() {
        formHelper.checkAndObtain(recyclerView) { params, error in
            debugPrint(params.jsonData)
            if let error = error {
                toast(error.message, position: .center)
            } else {
                hideKeyboard()
                showLoading()
                vm(LoginModel.self).updatePassword(params.params()) { json, error in
                    hideLoading()
                    if let error = error {
                        messageError(error.message)
                    } else {
                        messageSuccess("修改成功")
                        pop(self)
                    }
                }
            }
        }
    }

}