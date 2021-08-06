//
// Created by wayto on 2021/8/3.
//

import Foundation

struct LoginBean: Codable, NilObject {

    var isNil: Bool {
        get {
            user == nil
        }
    }

    var access_token: String? = nil
    var refresh_token: String? = nil
    var token_type: String? = nil
    var scope: String? = nil
    var jti: String? = nil
    var expires_in: Int? = nil
    var user: LoginUserBean? = nil
}

struct LoginUserBean: Codable {
    var userId: Int? = nil
    var accountId: Int? = nil
    var username: String? = nil
    var name: String? = nil
    var sex: Int? = nil
    var address: String? = nil
    var mobile: String? = nil
    var email: String? = nil
    var category: Int? = nil
    var headImgUrl: String? = nil
    //var userType: Any? = nil
    //var sourceOfRequest: Any? = nil
}