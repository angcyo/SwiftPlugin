//
// Created by wayto on 2021/7/31.
//

import Foundation
import Alamofire
import SwiftyJSON
import RxSwift

class LoginModel: ViewModel {

    /// 登录成功之后的数据结构
    let loginBeanData = liveData(LoginBean.self)

    /// 是否自动登录
    static var isAutoLogin: Bool {
        get {
            "KEY_AUTO_LOGIN".defGet() ?? false
        }
        set {
            "KEY_AUTO_LOGIN".defSet(newValue)
        }
    }

    /// 最后一次登录成功的用户名
    static var lastUserName: String? {
        get {
            "KEY_LAST_USER_NAME".defGet()
        }
        set {
            "KEY_LAST_USER_NAME".defSet(newValue)
        }
    }

    /// 登录的用户id
    func loginUserId() -> Int? {
        let bean: LoginBean? = loginBeanData.beanOrNil()
        return bean?.user?.userId
    }

    /// 开始自动登录
    func autoLogin(_ onResult: @escaping (Error?) -> Void) {
        if LoginModel.isAutoLogin {
            if let bean: LoginBean = "KEY_LoginBean".defGet() {
                refreshToken(bean.refresh_token) { loginBean, error in
                    if let loginBean = loginBean, error == nil {
                        self.loginSucceed(loginBean)
                        onResult(nil)
                    } else {
                        onResult(error)
                    }
                }
            } else {
                onResult(error("请先登录"))
            }
        } else {
            onResult(error("请手动登录"))
        }
    }

    /// 刷新token自动登录
    func refreshToken(_ refreshToken: String?, _ onResult: @escaping (LoginBean?, Error?) -> Void) {
        let param: [String: Any] = [
            "client_secret": "oauth-client-secret",
            "client_id": "oauth-client-id",
            "grant_type": "refresh_token",
            "refresh_token": refreshToken ?? ""
        ]
        Api.post("/auth2server/oauth/token", query: param).requestBean { (loginBean: LoginBean?, error: Error?) in
            onResult(loginBean, error)
        }
    }

    //MARK: 请求

    // 登录请求
    func loginRequest(_ username: String,
                      _ password: String,
                      verifyCode: String? = nil, //验证码信息，区分大小写
                      verifyCodeId: String? = nil, //验证码id
                      isVerifyCode: Bool = false
    ) -> DataRequest {
        var param: [String: Any] = [
            "client_secret": "oauth-client-secret",
            "client_id": "oauth-client-id",
            "grant_type": "password",
            "username": username,
            "password": password,
        ]

        if isVerifyCode {
            param["verifyCode"] = verifyCode!
            param["verifyCodeId"] = verifyCodeId!
            param["isVerifyCode"] = isVerifyCode
        }

        return Api.post("/auth2server/oauth/token", query: param)
    }

    // 登录
    func login(_ username: String, _ password: String,
               _ onResult: @escaping (LoginBean?, Error?) -> Void) {
        loginRequest(username, password).requestDecodable { (loginBean: LoginBean?, error: Error?) in
            print("登录返回:\(loginBean):\(error)")
            if let data = loginBean {
                self.loginSucceed(data)
            }
            onResult(loginBean, error)
        }
    }

    ///http://test.kaiyang.wayto.com.cn/kaiyangSystem/doc.html#/default/%E7%94%A8%E6%88%B7%E4%BF%A1%E6%81%AF/updatePasswordUsingPUT
    func updatePassword(_ param: [String: Any]?, _ onResult: @escaping (JSON?, Error?) -> Void) {
        Api.put("\(App.SystemSchema)/user/updatePassword", query: param).requestJson(onResult)
    }

    ///http://test.kaiyang.wayto.com.cn/kaiyangSystem/doc.html#/default/%E7%94%A8%E6%88%B7%E4%BF%A1%E6%81%AF/updatePasswordByCodeUsingPUT
    func updatePasswordByCode(_ param: [String: Any]?, _ onResult: @escaping (JSON?, Error?) -> Void) {
        Api.put("\(App.SystemSchema)/user/updatePasswordByCode", param).requestJson(onResult)
    }

    //MARK: 操作

    /// 登录成功
    func loginSucceed(_ loginBean: LoginBean) {
        //保存token, 方便下次自动登录
        "KEY_LoginBean".defSet(loginBean)

        Http.credential = OAuthCredential(
                accessToken: loginBean.access_token!,
                refreshToken: loginBean.refresh_token!,
                userId: loginBean.user!.userId!,
                expiration: Date(timeIntervalSince1970: nowTime + TimeInterval(loginBean.expires_in!)))
        loginBeanData.setValue(loginBean)

        /// 获取用户详情资料
        vm(UserModel.self).getUserDetailEx()
    }

    // 退出登录
    func logout() {
        LoginModel.isAutoLogin = false
        Api.post("/auth2server/logout").requestString { data, error in
            print("退出登录:\(data):\(error)")
        }
    }

    // 登出, 页面到登录页
    func toLogout() {
        logout()
        //showRootViewController(LoginController())
        push(navWrap(LoginController()), animated: false, root: true)
    }
}