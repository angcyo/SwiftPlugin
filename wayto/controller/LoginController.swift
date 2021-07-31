//
//  LoginController.swift
//  Wayto.GBSecurity.iOS
//
//  Created by wayto on 2021/7/28.
//

import Foundation
import UIKit
import RxKeyboard
import Toast_Swift
import ProgressHUD
import RxGesture

/// 登录界面
class LoginController: BaseUIViewController {

    /// 状态栏样式
    override var preferredStatusBarStyle: UIStatusBarStyle {
        /// 白色字体的状态栏
        .lightContent
    }

    /// 点击空白处隐藏键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

    var usernameField: UITextField? = nil
    var passwordField: UITextField? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        let headerHeight = UIScreen.height / 3
        let footerHeight = UIScreen.height - headerHeight + 20
        var safeTop = view.safeAreaInsets.top

        print("安全区域mainWindow:\(UIApplication.mainWindow?.safeAreaInsets):\(UIApplication.mainWindow?.layoutMargins)")

        //键盘监听
        RxKeyboard.instance.visibleHeight.drive(onNext: { height in
            print("键盘可见高度:\(height)")
            print("安全区域:\(safeTop):\(self.view.safeAreaInsets):\(self.view.layoutMargins)")
            print("安全区域:\(self.view.safeAreaLayoutGuide)")
            if height > 0 {
                // 键盘显示
                safeTop = max(safeTop, self.view.safeAreaInsets.top)
                self.view.frame.origin.y = -(UIScreen.height - footerHeight - safeTop)
            } else {
                // 键盘隐藏
                self.view.frame.origin.y = 0
            }
        }).disposed(by: disposeBag)

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

            let offset = 20

            footerView.render(labelView("欢迎登录")) { label in
                label.bold()
                label.setTextSize(20)
                label.setTextColor("#070822")
                label.makeGravityTop(offset: 30)
                label.makeGravityHorizontal(offset: offset)
            }

            let secureTextField = secureTextField("请输入密码", borderStyle: .none)
            self.passwordField = secureTextField
            self.usernameField = footerView.render(textFieldView("请输入账号", borderStyle: .none)) { text in
                text.makeTopToBottomOf(offset: offset)
                text.makeGravityHorizontal(offset: offset)
                text.makeHeight(minHeight: 50)
                self.holdObj(text.doReturnAction(.next) { textField in
                    secureTextField.becomeFirstResponder()
                    return true
                })
            }
            footerView.render(hLine()) { line in
                line.makeBottomToBottomOf()
                line.makeLeftToLeftOf()
                line.makeRightToRightOf()
            }

            footerView.render(secureTextField) { text in
                //text.text = "qqqq22222"
                text.makeTopToBottomOf(offset: offset)
                text.makeGravityHorizontal(offset: offset)
                text.makeHeight(minHeight: 50)
                self.holdObj(text.doReturnAction(.go) { textField in
                    textField.resignFirstResponder()
                    self.login()
                    return true
                })
            }
            footerView.render(hLine()) { line in
                line.makeBottomToBottomOf()
                line.makeLeftToLeftOf()
                line.makeRightToRightOf()
            }
            footerView.render(button("登      录")) { button in
                button.makeHeight(minHeight: 50)
                button.makeTopToBottomOf(offset: offset * 2)
                button.makeGravityHorizontal(offset: offset)
                self.holdObj(button.onClick {
                    self.login()
                })
            }

            //圆角
            footerView.setRoundTop(8)
        }

        if D.isBeingDebugged {
            usernameField?.text = "admin"
            passwordField?.text = "admin"
        }
    }

    /// 开始登录
    func login() {
        let username = usernameField?.text
        if username?.isEmpty == true {
            usernameField?.becomeFirstResponder()
            toast("请输入账号", position: .top)
            return
        }

        let password = passwordField?.text
        if password?.isEmpty == true {
            passwordField?.becomeFirstResponder()
            toast("请输入密码", position: .top)
            return
        }

        hideKeyboard()
        showLoading()
        vm(UserModel.self).login(username!, password!) { data, error in
            hideLoading()
            if data != nil, error == nil {
                toast("登录成功")
            } else {
                toast("登录失败")
            }
        }
    }
}

import Alamofire