//
// Created by angcyo on 21/08/28.
//

import Foundation
import UIKit

/// 忘记密码
class ForgetPasswordController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "忘记密码"
    }

    override func createTableView() -> DslTableView {
        DslTableView(style: .insetGrouped)
    }

    override func initTableView(tableView: DslTableView) {
        super.initTableView(tableView: tableView)

        dslTableView.load(FormEditTableItem()) {
            $0.itemLabel = "手机号码"
            $0.editItemConfig.itemEditMaxLength = 11
            $0.editItemConfig.itemEditKeyboardType = .numberPad
            $0.formItemConfig.formKey = "mobile"
            $0.formItemConfig.formVerify = true
            $0.formItemConfig.formVerifyErrorTip = "请输入手机号码"
        }
        dslTableView.load(FormEditTableItem()) {
            $0.itemLabel = "验证码"
            $0.editItemConfig.itemEditMaxLength = 6
            $0.editItemConfig.itemEditKeyboardType = .emailAddress
            $0.formItemConfig.formKey = "code"
            $0.formItemConfig.formVerify = true
            $0.formItemConfig.formVerifyErrorTip = "请输入验证码"
        }
        dslTableView.load(FormEditTableItem()) {
            $0.itemLabel = "密码"
            $0.editItemConfig.itemEditMaxLength = Res.size.passwordMaxLength
            $0.editItemConfig.itemSecureTextEntry = true
            $0.editItemConfig.itemEditKeyboardType = .emailAddress
            $0.formItemConfig.formKey = "password"
            $0.formItemConfig.formVerify = true
            $0.formItemConfig.formVerifyErrorTip = "请输入密码"
        }
        dslTableView.load(FormEditTableItem()) {
            $0.itemLabel = "确认密码"
            $0.editItemConfig.itemEditMaxLength = Res.size.passwordMaxLength
            $0.editItemConfig.itemSecureTextEntry = true
            $0.editItemConfig.itemEditKeyboardType = .emailAddress
            $0.formItemConfig.formVerify = true
            $0.formItemConfig.formVerifyErrorTip = "请输入确认密码"
        }
        /*dslTableView.load(EditPasswordTableItem()) {
            $0.formItemConfig.formKey = "newPassword"
            let item = $0
            $0.formItemConfig.formCheck = { params, end in
                if nilOrEmpty(item.editItemConfig.itemEditText) {
                    end(error("请输入新密码"))
                } else {
                    end(nil)
                }
            }
            $0.onBindCellOverride = { cell, path in
                if let cell = cell as? EditPasswordTableCell {
                    cell.label.text = "新密码"
                    cell.textField.placeholder = "请输入"
                }
            }
        }
        dslTableView.load(EditPasswordTableItem()) {
            let item = $0
            $0.formItemConfig.formCheck = { params, end in
                if nilOrEmpty(item.editItemConfig.itemEditText) {
                    end(error("请输入新密码"))
                } else if (params.jsonData["newPassword"].rawString() != item.editItemConfig.itemEditText) {
                    end(error("两次密码,不一致"))
                } else {
                    end(nil)
                }
            }
            $0.onBindCellOverride = { cell, path in
                if let cell = cell as? EditPasswordTableCell {
                    cell.label.text = "重复新密码"
                    cell.textField.placeholder = "请输入"

                    cell.line.isHidden = true
                }
            }
        }*/

        dslTableView.load(DslButtonTableItem()) {
            $0.itemSectionName = "button"
            $0.itemButtonText = "提 交"
            $0.onItemClick = {
                self.submit()
            }
        }
    }

    /// 提交
    func submit() {
        formHelper.checkAndObtain(dslTableView) { params, error in
            debugPrint(params.jsonData)
            if let error = error {
                toast(error.message, position: .center)
            } else {
                hideKeyboard()
                showLoading()
                vm(LoginModel.self).updatePasswordByCode(params.params()) { json, error in
                    hideLoading()
                    if let error = error {
                        messageWarn(error.message)
                    } else {
                        messageSuccess("修改成功")
                        pop(self)
                    }
                }
            }
        }
    }

}