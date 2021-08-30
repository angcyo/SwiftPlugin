//
// Created by angcyo on 21/08/30.
//

import Foundation
import UIKit

/// 注册界面
class RegisterController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "注册"
    }

    override func createTableView() -> DslTableView {
        DslTableView(style: .insetGrouped)
    }

    let userModel = vm(UserModel.self)

    override func initTableView(tableView: DslTableView) {
        super.initTableView(tableView: tableView)

        dslTableView.load(FormEditTableItem()) {
            $0.itemLabel = "手机号码"
            $0.itemTag = "mobile"
            $0.editItemConfig.itemEditMaxLength = 11
            $0.editItemConfig.itemEditKeyboardType = .numberPad
            $0.formItemConfig.formKey = $0.itemTag
            $0.formItemConfig.formVerify = true
            $0.formItemConfig.formVerifyErrorTip = "请输入手机号码"
        }
        dslTableView.load(FormEditVerifyTableItem()) {
            $0.itemLabel = "验证码"
            $0.editItemConfig.itemEditMaxLength = Res.size.codeMaxLength
            $0.editItemConfig.itemEditKeyboardType = .numberPad
            $0.formItemConfig.formKey = "code"
            $0.formItemConfig.formVerify = true
            $0.formItemConfig.formVerifyErrorTip = "请输入验证码"
            $0.onRequestCode = { verifyButton in
                formHelper.checkAndObtain(self.dslTableView, itemTags: ["mobile"]) { params, error in
                    if error == nil {
                        verifyButton.startCountDown()
                        let mobile = params.jsonData["mobile"].string
                        self.userModel.getSimMsg(mobile: mobile!, simCode: .Register) { json, error in
                            if let error = error {
                                verifyButton.stopCountDown()
                                messageWarn(error.message)
                            }
                        }
                    }
                }
            }
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
            let item = $0
            $0.formItemConfig.formCheck = { params, end in
                if item.formItemConfig.formValue == nil {
                    end(error("请输入确认密码"))
                } else if (params.jsonData["password"].rawString() != item.formItemConfig.formValue as! String) {
                    end(error("两次密码,不一致"))
                } else {
                    end(nil)
                }
            }
        }

        dslTableView.load(DslButtonTableItem()) {
            $0.itemSectionName = "button"
            $0.itemButtonText = "注 册"
            $0.onItemClick = {
                self.submit()
            }
        }
        dslTableView.load(RegisterProtocolTableItem()) {
            $0.itemSectionName = "button"
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
                userModel.register(param: params.params()) { json, error in
                    hideLoading()
                    if let error = error {
                        messageError(error.message)
                    } else {
                        messageSuccess("注册成功")
                        pop(self)
                    }
                }
            }
        }
    }

}