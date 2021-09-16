//
// Created by angcyo on 21/09/01.
//

import Foundation

/// 个人实名验证 下一步界面

class IdentityAuthNextController: IdentityAuthStatusController {

    var authBean: AuthBean? = nil {
        didSet {
            personInfo = authBean?.personInfo
        }
    }

    override func renderTable() {
        super.renderTable()
        recyclerView.load(DslButtonTableItem()) {
            $0.itemSectionName = "submit"
            $0.itemButtonText = "下一步"
            $0.onItemClick = {
                with(showUrl(self.authBean?.authUrl)) {
                    $0.toolbarItemTypes = [.back, .forward, .reload]

                    $0.onWebViewDidFinish = { vc, url in

                        self.updateAuthStatus()

                        if url.absoluteString == self.authBean?.callbackPage {
                            //认证成功
                            vm(UserModel.self).getUserDetailEx()
                            popTo(LoginController.MAIN_CONTROLLER)
                        } else {
                            //认证中
                        }
                    }
                }
            }
        }
    }

    func updateAuthStatus() {
        let url = "\(App.SystemSchema)/userExt/updateAuthStatusHandle"
        Api.json(url, method: .put) { data, error in
            //no op
        }.disposed(by: disposeBag)
    }
}