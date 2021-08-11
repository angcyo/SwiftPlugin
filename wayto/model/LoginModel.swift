//
// Created by wayto on 2021/7/31.
//

import Foundation
import Alamofire
import SwiftyJSON
import RxSwift

class LoginModel: ViewModel {

    /// 登录成功之后的数据结构
    let loginBeanData = liveData(LoginBean())

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
            debugPrint("登录返回:\(loginBean):\(error)")
            if let data = loginBean {
                self.loginSucceed(data)
            }
            onResult(loginBean, error)
        }
    }

    func updatePassword(_ param: [String: Any]?, _ onResult: @escaping (JSON?, Error?) -> Void) {
        Api.put("\(App.SystemSchema)/user/updatePassword", query: param).requestJson(onResult)
    }

    //MARK: 操作

    /// 登录成功
    func loginSucceed(_ loginBean: LoginBean) {
        Http.credential = OAuthCredential(
                accessToken: loginBean.access_token!,
                refreshToken: loginBean.refresh_token!,
                userId: loginBean.user!.userId!,
                expiration: Date(timeIntervalSince1970: nowTime + TimeInterval(loginBean.expires_in!)))
        loginBeanData.onNext(loginBean)

        /// 获取用户详情资料
        vm(UserModel.self).getUserDetailEx()
    }

    // 退出登录
    func logout() {

    }

}