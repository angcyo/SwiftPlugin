//
// Created by wayto on 2021/7/31.
//

import Foundation
import Alamofire
import SwiftyJSON

class UserModel: ViewModel {

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
                Http.credential = OAuthCredential(
                        accessToken: data.access_token!,
                        refreshToken: data.refresh_token!,
                        userId: data.user!.userId!,
                        expiration: Date(timeIntervalSince1970: nowTime + TimeInterval(data.expires_in!)))
            }
            onResult(loginBean, error)
        }
    }
}