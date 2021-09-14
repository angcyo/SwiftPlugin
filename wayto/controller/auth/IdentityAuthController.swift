//
// Created by angcyo on 21/08/31.
//

import Foundation

/// 1.上传身份证正反面, 拿到数据结果id
/// 2.通过数据id, 获取认证的url和识别到的身份证信息并展示
/// 3.跳转认证的url, 进行认证
/// 4.根据认证状态, 通知后端

/// 个人实名验证界面

class IdentityAuthController: BaseTableViewController {

    static let FACE = "face"

    static let BACK = "back"

    override func createTableView() -> DslTableView {
        DslTableView(style: .insetGrouped)
    }

    override func initControllerView() {
        super.initControllerView()
        title = "实名认证"

        recyclerView.load(DslLabelTableItem()) {
            $0.labelItemConfig.itemLabelText = "一个账户只能进行一次实名认证，认证成功后不可修改!"
            $0.labelItemConfig.itemLabelTextAlignment = .center
            $0.labelItemConfig.itemLabelColor = "#FC532E".toColor()
        }
        recyclerView.load(AuthCameraTableItem()) {
            $0.itemAuthPlaceholderImage = R.image.png_identity_front()
            $0.itemAuthLabel = "请上传身份证人像面"
            $0.formItemConfig.formVerifyErrorTip = $0.itemAuthLabel!
            $0.formItemConfig.formKey = IdentityAuthController.FACE
        }
        recyclerView.load(AuthCameraTableItem()) {
            $0.itemAuthPlaceholderImage = R.image.png_identity_back()
            $0.itemAuthLabel = "请上传身份证国徽面"
            $0.formItemConfig.formVerifyErrorTip = $0.itemAuthLabel!
            $0.formItemConfig.formKey = IdentityAuthController.BACK
        }

        recyclerView.load(DslButtonTableItem()) {
            $0.itemSectionName = "button"
            $0.itemButtonText = "提交"
            $0.onItemClick = {
                self.submit()
            }
        }
    }

    let userModel = vm(UserModel.self)

    /// 提交表单数据
    func submit() {
        formHelper.checkAndObtain(recyclerView) { params, error in
            L.w("表单数据:\(params.params())")

            if let error = error {
                toast(error.message, position: .center)
            } else if params.isEmpty() {
                messageSuccess("未编辑内容")
                pop(self)
            } else {
                params.put("param.id", vm(LoginModel.self).loginUserId())

                hideKeyboard()
                showLoading()

                let helper = params.uploadFile(url: "/ocr/ocr/idCardNum") { error in
                    if let error = error {
                        hideLoading()
                        messageError(error.message)
                    } else {
                        //获取认证链接
                        let faceOcrResultId = params.params()![IdentityAuthController.FACE]!
                        let backOcrResultId = params.params()![IdentityAuthController.BACK]!
                        Api.bean("/kaiyangQys/kyQys/getAuth", query: ["faceOcrResultId": faceOcrResultId, "backOcrResultId": backOcrResultId], method: .get) { (bean: HttpBean<AuthBean>?, error: Error?) in
                            hideLoading()
                            if error == nil, let bean = bean {
                                let vc = IdentityAuthNextController()
                                vc.authBean = bean.data
                                push(vc)
                            } else {
                                messageError(error?.message ?? Api.DEF_ERROR_TIP)
                            }
                        }.disposed(by: self.disposeBag)
                    }
                }
                helper.checkMd5 = false
                helper.onConfigQueryParameters = { _ in
                    if helper._uploadIndex == 0 {
                        return ["side": IdentityAuthController.FACE]
                    } else {
                        return ["side": IdentityAuthController.BACK]
                    }
                }
            }
        }
    }
}