//
// Created by angcyo on 21/08/06.
//

import Foundation
import UIKit

/// 修改密码
class ModifyPasswordController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "修改密码"
    }

    override func createTableView() -> DslTableView {
        DslTableView(frame: view.bounds, style: .insetGrouped)
    }

    override func initTableView(tableView: DslTableView) {
        super.initTableView(tableView: tableView)

        tableView.tableHeaderView = emptyView(height: Res.size.leftMargin)
        tableView.tableFooterView = emptyView(height: Res.size.leftMargin)

        tableView.load(.editPasswordCell) { item in
            item.onBindTableCell = { cell, index in
                if let cell = cell as? EditPasswordCell {
                    cell.label.text = "旧密码"
                    cell.textField.placeholder = "请输入"
                }
            }
        }
        tableView.load(.editPasswordCell) { item in
            item.onBindTableCell = { cell, index in
                if let cell = cell as? EditPasswordCell {
                    cell.label.text = "新密码"
                    cell.textField.placeholder = "请输入"
                }
            }
        }
        tableView.load(.editPasswordCell) { item in
            item.onBindTableCell = { cell, index in
                if let cell = cell as? EditPasswordCell {
                    cell.label.text = "重复新密码"
                    cell.textField.placeholder = "请输入"

                    cell.line.isHidden = true
                }
            }
        }

        tableView.load(.buttonCell) { (item: DslTableItem) in
            item.itemSectionName = "button"
            item.itemHeaderEstimatedHeight = 50
            item.onBindTableCell = { cell, index in
                if let cell = cell as? DslButtonCell {
                    cell.button.setText("保存")
                    cell.button.onClick(bag: self.disposeBag) { recognizer in
                        toast("保存")
                        showViewController(HomeController())
                    }
                }
            }
        }
    }
}