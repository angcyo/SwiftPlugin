//
// Created by angcyo on 21/09/01.
//

import Foundation

/// 个人实名验证 下一步界面

class IdentityAuthNextController: BaseTableViewController {

    var authBean: AuthBean? = nil {
        didSet {
            renderTable()
        }
    }

    override func initController() {
        super.initController()
        title = "实名认证"
    }

    override func createTableView() -> DslTableView {
        DslTableView(style: .insetGrouped)
    }

    func renderTable() {
        dslTableView.clearAllItems()
        dslTableView.load(FormEditTableItem()) {
            $0.itemLabel = "姓名"
            $0.editItemConfig.itemEditEnable = false
            $0.editItemConfig.itemEditText = self.authBean?.personInfo?.name
        }
        dslTableView.load(FormEditTableItem()) {
            $0.itemLabel = "性别"
            $0.editItemConfig.itemEditEnable = false
            $0.editItemConfig.itemEditText = self.authBean?.personInfo?.sex
        }
        dslTableView.load(FormEditTableItem()) {
            $0.itemLabel = "年龄"
            $0.editItemConfig.itemEditEnable = false
            $0.editItemConfig.itemEditText = self.authBean?.personInfo?.age?.toString()
        }
        dslTableView.load(FormEditTableItem()) {
            $0.itemLabel = "身份证号"
            $0.editItemConfig.itemEditEnable = false
            $0.editItemConfig.itemEditText = self.authBean?.personInfo?.num
        }
        dslTableView.load(FormEditTableItem()) {
            $0.itemLabel = "通讯地址"
            $0.editItemConfig.itemEditEnable = false
            $0.editItemConfig.itemEditText = self.authBean?.personInfo?.address
        }
        dslTableView.load(FormEditTableItem()) {
            $0.itemLabel = "有效期"
            $0.editItemConfig.itemEditEnable = false
            $0.editItemConfig.itemEditText = "\(self.authBean?.personInfo?.startDate ?? "") ~ \(self.authBean?.personInfo?.endDate ?? "")"
        }

        dslTableView.load(DslButtonTableItem()) {
            $0.itemSectionName = "button"
            $0.itemButtonText = "下一步"
            $0.onItemClick = {
                showUrl(self.authBean?.authUrl)
            }
        }
    }
}