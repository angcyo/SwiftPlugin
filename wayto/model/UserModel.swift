//
// Created by wayto on 2021/7/31.
//

import Foundation

class UserModel: ViewModel {

    func login(_ username: String, _ password: String,
               _ onResult: @escaping (Dictionary<String, Any>?, Error?) -> Void) {
        Api.post("/auth2server/oauth/token", query: [
            "client_secret": "oauth-client-secret",
            "client_id": "oauth-client-id",
            "grant_type": "password",
            "username": username,
            "password": password,
        ]) { dictionary, error in
            if let data = dictionary {
                Http.credential = OAuthCredential(
                        accessToken: data["access_token"] as! String,
                        refreshToken: data["refresh_token"] as! String,
                        userId: (data["user"] as! Dictionary<String, Any>)["userId"] as! Int,
                        expiration: Date(timeIntervalSince1970: data["expires_in"] as! Double))
            }
            onResult(dictionary, error)
        }
    }
}