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

    override func initController() {
        super.initController()
        title = "实名认证"
    }

    override func createTableView() -> DslTableView {
        DslTableView(style: .insetGrouped)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        dslTableView.load(DslLabelTableItem()) {
            $0.labelItemConfig.itemLabelText = "一个账户只能进行一次实名认证，认证成功后不可修改!"
            $0.labelItemConfig.itemLabelTextAlignment = .center
            $0.labelItemConfig.itemLabelColor = "#FC532E".toColor()
        }
        dslTableView.load(AuthCameraTableItem()) {
            $0.itemAuthPlaceholderImage = R.image.png_identity_front()
            $0.itemAuthLabel = "请上传身份证人像面"
            $0.formItemConfig.formVerifyErrorTip = $0.itemAuthLabel!
        }
        dslTableView.load(AuthCameraTableItem()) {
            $0.itemAuthPlaceholderImage = R.image.png_identity_back()
            $0.itemAuthLabel = "请上传身份证国徽面"
            $0.formItemConfig.formVerifyErrorTip = $0.itemAuthLabel!
        }

        dslTableView.load(DslButtonTableItem()) {
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
        formHelper.checkAndObtain(dslTableView) { params, error in
            print("表单数据:", params.params())

            if let error = error {
                toast(error.message, position: .center)
            } else if params.isEmpty() {
                messageSuccess("未编辑内容")
                pop(self)
            } else {
                params.put("param.id", vm(LoginModel.self).loginUserId())

                /*hideKeyboard()
                showLoading()

                params.uploadFile { error in
                    if let error = error {
                        hideLoading()
                        toast(error.message)
                    } else {
                        vm(UserModel.self).putUserDetail(param: params.params()) { json, error in
                            hideLoading()
                            if let error = error {
                                messageError(error.message)
                            } else {
                                messageSuccess("修改成功")
                                pop(self)
                            }
                        }
                    }
                }*/
            }
        }
    }
}