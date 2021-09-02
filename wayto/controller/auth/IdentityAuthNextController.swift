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
        dslTableView.load(FormTextFieldTableItem()) {
            $0.itemLabel = "姓名"
            $0.textFieldItemConfig.itemEditEnable = false
            $0.textFieldItemConfig.itemEditText = self.authBean?.personInfo?.name
        }
        dslTableView.load(FormTextFieldTableItem()) {
            $0.itemLabel = "性别"
            $0.textFieldItemConfig.itemEditEnable = false
            $0.textFieldItemConfig.itemEditText = self.authBean?.personInfo?.sex
        }
        dslTableView.load(FormTextFieldTableItem()) {
            $0.itemLabel = "年龄"
            $0.textFieldItemConfig.itemEditEnable = false
            $0.textFieldItemConfig.itemEditText = self.authBean?.personInfo?.age?.toString()
        }
        dslTableView.load(FormTextFieldTableItem()) {
            $0.itemLabel = "身份证号"
            $0.textFieldItemConfig.itemEditEnable = false
            $0.textFieldItemConfig.itemEditText = self.authBean?.personInfo?.num
        }
        dslTableView.load(FormTextViewTableItem()) {
            $0.itemLabel = "通讯地址"
            $0.textViewItemConfig.itemEditEnable = false
            $0.textViewItemConfig.itemEditText = self.authBean?.personInfo?.address
        }
        dslTableView.load(FormTextViewTableItem()) {
            $0.itemLabel = "有效期"
            $0.textViewItemConfig.itemEditEnable = false
            $0.textViewItemConfig.itemEditText = "\(self.authBean?.personInfo?.startDate ?? "") ~ \(self.authBean?.personInfo?.endDate ?? "")"
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