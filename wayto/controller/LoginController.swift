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
import RxSwift
import Alamofire
import SwiftyJSON

/// 登录界面
class LoginController: BaseViewController {

    /// 登录成功后的启动界面
    static var MAIN_CONTROLLER: AnyClass? = nil

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

    var loginButton: UIView? = nil

    var usernameField: UITextField? = nil
    var passwordField: UITextField? = nil
    var verifyCodeField: UITextField? = nil

    var verifyCodeImage: UIImageView? = nil

    var verifyCodeWidth = 70
    var verifyCodeHeight = 35

    //验证码
    var verifyCodeWrapView: UIView? = nil

    let viewOffset = 20
    let fieldHeight = 50

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "登录"

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
                stack.render(img(R.image.launchLogo())) { image in
                    image.makeWidthHeight(67, 67)
                }
                stack.render(labelView(Bundle.displayName(), size: Res.text.big.size, color: UIColor.white)) { label in
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

            footerView.render(labelView("欢迎登录")) { label in
                label.bold()
                label.setTextSize(20)
                label.setTextColor("#070822")
                label.makeGravityTop(offset: 30)
                label.makeGravityHorizontal(offset: self.viewOffset)
            }

            let secureTextField = secureTextField("请输入密码", borderStyle: .none)
            self.passwordField = secureTextField
            self.usernameField = footerView.render(textFieldView("请输入账号", borderStyle: .none)) { text in
                text.makeTopToBottomOf(offset: self.viewOffset)
                text.makeGravityHorizontal(offset: self.viewOffset)
                text.makeHeight(minHeight: self.fieldHeight)
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
                text.makeTopToBottomOf(offset: self.viewOffset)
                text.makeGravityHorizontal(offset: self.viewOffset)
                text.makeHeight(minHeight: self.fieldHeight)
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

            //验证码
            self.verifyCodeWrapView = footerView.render(v()) { (verifyCodeWrapView: UIView) in
                verifyCodeWrapView.makeHeight(minHeight: self.fieldHeight)
                verifyCodeWrapView.makeTopToBottomOf(offset: self.viewOffset)
                verifyCodeWrapView.makeGravityHorizontal(offset: self.viewOffset)

                self.verifyCodeField = verifyCodeWrapView.render(textFieldView("请输入验证码", borderStyle: .none)) { verifyCodeField in
                    verifyCodeField.keyboardType = .emailAddress
                    verifyCodeField.makeFullWidth(rightOffset: -(self.verifyCodeWidth + 10))
                    verifyCodeField.makeFullHeight(self.fieldHeight)
                    self.holdObj(verifyCodeField.doReturnAction(.go) { textField in
                        textField.resignFirstResponder()
                        self.login()
                        return true
                    })

                    //线
                    verifyCodeWrapView.render(hLine()) { line in
                        line.makeGravityBottom(offset: -2)
                        line.makeLeftToLeftOf(nil)
                        line.makeRightToRightOf(nil)
                    }

                    //验证码图片
                    self.verifyCodeImage = verifyCodeWrapView.render(img()) { image in
                        //image.backgroundColor = UIColor.red
                        image.contentMode = .scaleAspectFit
                        image.makeWidthHeight(self.verifyCodeWidth, self.verifyCodeHeight)
                        image.makeGravityRight()
                        image.makeCenterY()

                        image.rx.tapGesture()
                                .when(.recognized)
                                .subscribe(onNext: { _ in
                                    self.showVerifyCode()
                                })
                                .disposed(by: self.disposeBag)
                    }
                }
            }

            self.loginButton = footerView.render(button("登      录")) { button in
                button.makeHeight(minHeight: self.fieldHeight)
                button.makeTopToBottomOf(secureTextField, offset: self.viewOffset * 2)
                button.makeGravityHorizontal(offset: self.viewOffset)
                button.onClick { _ in
                    self.login()
                }
            }

            footerView.render(borderButton("注      册")) { button in
                button.makeHeight(minHeight: self.fieldHeight)
                button.makeTopToBottomOf(offset: self.viewOffset)
                button.makeGravityHorizontal(offset: self.viewOffset)
                button.onClick { _ in
                    self.register()
                }
            }

            //圆角
            footerView.setRoundTop(8)
        }

        if D.isDebug {
            usernameField?.text = "admin"
            passwordField?.text = "admin"
        }

        //默认不需要验证码
        verifyCodeWrapView?.isHidden = true
    }

    /// 开始登录
    func login() {
        let username = usernameField?.text
        if nilOrEmpty(username) {
            usernameField?.becomeFirstResponder()
            toast("请输入账号", position: .top)
            return
        }

        let password = passwordField?.text
        if nilOrEmpty(password) {
            passwordField?.becomeFirstResponder()
            toast("请输入密码", position: .top)
            return
        }

        hideKeyboard()
        showLoading()

        vm(UserModel.self).loginRequest(username!, password!,
                        verifyCode: verifyCodeField?.text,
                        verifyCodeId: uuid,
                        isVerifyCode: verifyCodeWrapView?.isHidden == false)
                .requestDecodableRes({ (response: Alamofire.AFDataResponse<LoginBean>, error: Error?) in
                    hideLoading()

                    //
                    vm(UserModel.self).apply { (vm: UserModel) in
                        if let bean = response.value {
                            vm.loginBeanData.onNext(bean)
                            vm.initAuthCredential(bean)
                        }
                    }

                    let json = JSON(response.data)
                    if error == nil {
                        toast("登录成功")
                        self.showMain()
                    } else if let error = error {
                        let needVerifyCode = response.response?.headers.value(for: "needVerifyCode")
                        toast((json["msg"].rawStringOrNil() ?? error.message).ifEmpty("登录失败"))
                        if needVerifyCode == "true" {
                            // 需要验证码登录
                            self.showVerifyCode()
                        } else {
                            // 不需要验证码登录
                        }
                    }
                })
    }

    /// 跳转注册
    func register() {
        toast("注册")
        var json = JSON()
        var path = ["p", "p1", "p2"]
        json.ensurePath(path)

        var obj = JSON()
        obj["a"] = 1
        obj["b"] = "b"
        json.add(path, value: obj)
        json.add(path, value: obj)
        //json[path]
        //json["d2"] = ["dd2_1", "dd2_2"]

        try! json.merge(with: obj)

        print(json)
        print(json.dictionaryObject)
    }

    var uuid: String = ""

    /// 显示验证码
    func showVerifyCode() {
        uuid = Util.uuid()
        animate {
            self.verifyCodeWrapView?.isHidden = false
            let param = "verifyCodeId=\(self.uuid)&now=\(nowTime)&width=\(self.verifyCodeWidth)&height=\(self.verifyCodeHeight)"
            self.verifyCodeImage?.setImageUrl(connectUrl(url: "/auth2server/free/getVerifyImg?\(param)"))

            if let button = self.loginButton {
                button.remake { maker in
                    button.makeHeight(minHeight: self.fieldHeight)
                    button.makeTopToBottomOf(self.verifyCodeWrapView, offset: self.viewOffset * 2)
                    button.makeGravityHorizontal(offset: self.viewOffset)
                }
            }

            self.verifyCodeField?.becomeFirstResponder()

            // 必须, 否则没有动画
            self.view.layoutIfNeeded()
        }
    }

    /// 显示主页
    func showMain() {
        if let main = LoginController.MAIN_CONTROLLER {
            let rootVc: UIViewController = toViewController(main)
            UIApplication.mainWindow?.rootViewController = rootVc
        } else {
            toast("请配置[MAIN_CONTROLLER]", position: .center)
        }
    }
}
