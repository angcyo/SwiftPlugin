//
//  LoginController.swift
//  Wayto.GBSecurity.iOS
//
//  Created by wayto on 2021/7/28.
//

import Foundation
import UIKit

/// 登录界面
class LoginController: UIViewController {

    /// 状态栏样式
    override var preferredStatusBarStyle: UIStatusBarStyle {
        /// 白色字体的状态栏
        .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        let headerHeight = UIScreen.height / 3
        let footerHeight = UIScreen.height - headerHeight + 20

        //上部分
        view.render(v()) { headerView in
            headerView.setBackground(R.image.loginHeaderBg())

            headerView.makeGravityTop()
            headerView.makeFullWidth()
            headerView.makeHeight(headerHeight)

            headerView.render(vStackView(spacing: 13)) { stack in
                stack.render(imageView(R.image.launchLogo())) { image in
                    image.makeWidthHeight(67, 67)
                }
                stack.render(labelView(Bundle.displayName(), size: Res.Text.big.size, color: UIColor.white)) { label in
                    label.bold()
                    //view.sizeToFit()
                }
                stack.makeCenter()
            }
        }

        //下部分
        view.render(v()) { footerView in
            footerView.setBackground(UIColor.white)
            footerView.makeGravityBottom()
            footerView.makeFullWidth()
            footerView.makeHeight(footerHeight)

            footerView.render(vStackView(.leading, spacing: 10)) { stack in
                stack.makeGravityTop(offset: 30)
                stack.makeGravityLeft(offset: 30)
                stack.makeGravityRight(offset: -30)
                //stack.makeGravityBottom(-30)
                //stack.setBackground(UIColor.brown)

                stack.render(labelView("欢迎登录")) { label in
                    label.bold()
                    label.setTextSize(20)
                    label.setTextColor("#070822")
                }
                stack.render(textField()) { text in
                    text.text = "qqqq"
//                    text.setBackground(UIColor.red)
                    text.makeFullWidth()
                }
               let last =  stack.render(textField()) { text in
                    text.text = "qqqq22222"
//                    text.setBackground(UIColor.blue)
                }
                stack.render(button()) { button in
                    //button. = "qqqq22222"
                    button.makeHeight(minHeight: 100)
                    button.setTitle("登      录", for: .normal)
                    button.makeFullWidth()
                    button.setBackground(UIColor.green)
                    //button.makeGravityTop(ConstraintTarget.LAST, offset: 30)
                    //button.makeTopToBottomOf(offset: 50)
                    //button.layoutMargins = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
                }
            }

            doMain {
                footerView.setRoundTop(8)
            }
        }
    }
}
