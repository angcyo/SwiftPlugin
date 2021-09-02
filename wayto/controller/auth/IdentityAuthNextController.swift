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
        dslTableView.load(DslButtonTableItem()) {
            $0.itemSectionName = "button"
            $0.itemButtonText = "下一步"
            $0.onItemClick = {
                showUrl(self.authBean?.authUrl)
            }
        }
    }
}