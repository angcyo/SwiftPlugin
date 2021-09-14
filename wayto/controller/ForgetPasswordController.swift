//
// Created by angcyo on 21/08/28.
//

import Foundation
import UIKit

/// 忘记密码
class ForgetPasswordController: BaseTableViewController {

    override func initControllerView() {
        super.initControllerView()
        title = "忘记密码"
    }

    override func createTableView() -> DslTableView {
        DslTableView(style: .insetGrouped)
    }

    let userModel = vm(UserModel.self)

    override func initTableView(recyclerView: DslTableView) {
        super.initTableView(recyclerView: recyclerView)

        recyclerView.load(FormTextFieldTableItem()) {
            $0.itemLabel = "手机号码"
            $0.itemTag = "mobile"
            $0.textFieldItemConfig.itemEditMaxLength = 11
            $0.textFieldItemConfig.itemEditKeyboardType = .numberPad
            $0.formItemConfig.formKey = $0.itemTag
            $0.formItemConfig.formVerify = true
            $0.formItemConfig.formVerifyErrorTip = "请输入手机号码"
        }
        recyclerView.load(FormTextFieldVerifyTableItem()) {
            $0.itemLabel = "验证码"
            $0.textFieldItemConfig.itemEditMaxLength = Res.size.codeMaxLength
            $0.textFieldItemConfig.itemEditKeyboardType = .numberPad
            $0.formItemConfig.formKey = "code"
            $0.formItemConfig.formVerify = true
            $0.formItemConfig.formVerifyErrorTip = "请输入验证码"
            $0.onRequestCode = { verifyButton in
                formHelper.checkAndObtain(self.recyclerView, itemTags: ["mobile"]) { params, error in
                    if error == nil {
                        verifyButton.startCountDown()
                        let mobile = params.jsonData["mobile"].string
                        self.userModel.getSimMsg(mobile: mobile!, simCode: .ResetPassword) { json, error in
                            if let error = error {
                                verifyButton.stopCountDown()
                                messageWarn(error.message)
                            }
                        }
                    }
                }
            }
        }
        recyclerView.load(FormTextFieldTableItem()) {
            $0.itemLabel = "密码"
            $0.textFieldItemConfig.itemEditMaxLength = Res.size.passwordMaxLength
            $0.textFieldItemConfig.itemSecureTextEntry = true
            $0.textFieldItemConfig.itemEditKeyboardType = .emailAddress
            $0.formItemConfig.formKey = "password"
            $0.formItemConfig.formVerify = true
            $0.formItemConfig.formVerifyErrorTip = "请输入密码"
        }
        recyclerView.load(FormTextFieldTableItem()) {
            $0.itemLabel = "确认密码"
            $0.textFieldItemConfig.itemEditMaxLength = Res.size.passwordMaxLength
            $0.textFieldItemConfig.itemSecureTextEntry = true
            $0.textFieldItemConfig.itemEditKeyboardType = .emailAddress
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

        recyclerView.load(DslButtonTableItem()) {
            $0.itemSectionName = "button"
            $0.itemButtonText = "提 交"
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
                vm(LoginModel.self).updatePasswordByCode(params.params()) { json, error in
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