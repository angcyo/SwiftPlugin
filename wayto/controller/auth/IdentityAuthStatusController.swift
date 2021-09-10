//
// Created by angcyo on 21/09/01.
//

import Foundation
import UIKit

/// 个人实名验证 认证状态界面

class IdentityAuthStatusController: BaseTableViewController {

    //个人认证状态,0未认证,1认证信息已提交,2实名认证成功,3实名认证失败
    var personalAuth: Int? = nil

    var personInfo: AuthPersonInfo? = nil

    override func createTableView() -> DslTableView {
        DslTableView(style: .insetGrouped)
    }

    override func initController() {
        super.initController()
        title = "实名认证"
    }

    override func initControllerView() {
        super.initControllerView()
        renderTable()

        if let personalAuth = personalAuth, personalAuth == 1 || personalAuth == 2 {
            //授权状态
            dslTableView.waitBounds {
                let authStatus: UIView
                if personalAuth == 2 {
                    authStatus = scaleImageView(R.image.img_auth_ed())
                } else {
                    authStatus = scaleImageView(R.image.img_auth_ing())
                }
                let size: CGFloat = 114
                self.dslTableView.render(authStatus) {
                    $0.makeWidthHeight(size: size)
                    $0.makeGravityTop(offset: Res.size.leftMargin)
                    $0.makeGravityLeft(offset: self.dslTableView.width - Res.size.leftMargin - Res.size.leftMargin - size)
                }
            }
        }
    }

    let itemLabelMinWidth: CGFloat = 70

    func renderTable() {
        dslTableView.recyclerDataSource.clearAllItems()
        dslTableView.load(FormTextFieldTableItem()) {
            $0.itemLabel = "姓名"
            $0.itemLabelMinWidth = self.itemLabelMinWidth
            $0.textFieldItemConfig.itemEditEnable = false
            $0.textFieldItemConfig.itemEditText = self.personInfo?.name
        }
        dslTableView.load(FormTextFieldTableItem()) {
            $0.itemLabel = "性别"
            $0.itemLabelMinWidth = self.itemLabelMinWidth
            $0.textFieldItemConfig.itemEditEnable = false
            $0.textFieldItemConfig.itemEditText = self.personInfo?.sex
        }
        dslTableView.load(FormTextFieldTableItem()) {
            $0.itemLabel = "年龄"
            $0.itemLabelMinWidth = self.itemLabelMinWidth
            $0.textFieldItemConfig.itemEditEnable = false
            $0.textFieldItemConfig.itemEditText = self.personInfo?.age?.toString()
        }
        dslTableView.load(FormTextFieldTableItem()) {
            $0.itemLabel = "身份证号"
            $0.itemLabelMinWidth = self.itemLabelMinWidth
            $0.textFieldItemConfig.itemEditEnable = false
            $0.textFieldItemConfig.itemEditText = self.personInfo?.num
        }
        dslTableView.load(FormTextViewTableItem()) {
            $0.itemLabel = "通讯地址"
            $0.itemLabelMinWidth = self.itemLabelMinWidth
            $0.textViewItemConfig.itemEditEnable = false
            $0.textViewItemConfig.itemEditText = self.personInfo?.address ?? Core.DEF_NIL_STRING
        }
        dslTableView.load(FormTextViewTableItem()) {
            $0.itemLabel = "有效期"
            $0.itemLabelMinWidth = self.itemLabelMinWidth
            $0.textViewItemConfig.itemEditEnable = false
            $0.textViewItemConfig.itemEditText = "\(self.personInfo?.startDate ?? "") ~ \(self.personInfo?.endDate ?? "")"
        }
        /*dslTableView.load(FormTextViewTableItem()) {
            $0.itemLabel = "test"
            $0.itemLabelMinWidth = self.itemLabelMinWidth
            $0.textViewItemConfig.itemEditEnable = false
            $0.textViewItemConfig.itemEditText = " self.personInfo?.startDate ~ self.personInfo?.endDate  self.personInfo?.startDate ~ self.personInfo?.endDate  self.personInfo?.startDate ~ self.personInfo?.endDate "
        }*/
        /*dslTableView.load(FormTextViewTableItem()) {
            $0.itemLabel = "test"
            $0.itemLabelMinWidth = self.itemLabelMinWidth
            $0.textViewItemConfig.itemEditEnable = false
            $0.textViewItemConfig.itemEditText = " self.personInfo?.startDate ~ self.personInfo?.endDate  self.personInfo?.startDate ~ self.personInfo?.endDate  self.personInfo?.startDate ~ self.personInfo?.endDate "
        }
        dslTableView.load(FormTextViewTableItem()) {
            $0.itemLabel = "test2"
            $0.itemLabelMinWidth = self.itemLabelMinWidth
            $0.itemRightTitle = "test2"
            $0.textViewItemConfig.itemEditEnable = true
            $0.textViewItemConfig.itemEditText = " self.personInfo?.startDate ~ self.personInfo?.endDate  self.personInfo?.startDate ~ self.personInfo?.endDate  self.personInfo?.startDate ~ self.personInfo?.endDate "
        }
        dslTableView.load(FormTextViewTableItem()) {
            $0.itemLabel = "test2"
            $0.itemLabelMinWidth = self.itemLabelMinWidth
            $0.itemRightTitle = "test2"
            $0.itemTextViewHeight = 80
            $0.textViewItemConfig.itemEditEnable = true
            $0.textViewItemConfig.itemEditText = " self.personInfo?.startDate ~ self.personInfo?.endDate  self.personInfo?.startDate ~ self.personInfo?.endDate  self.personInfo?.startDate ~ self.personInfo?.endDate "
        }*/
    }
}
