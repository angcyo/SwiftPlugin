//
// Created by angcyo on 21/09/01.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let authBean = try? newJSONDecoder().decode(AuthBean.self, from: jsonData)

import Foundation

// MARK: - AuthBean
struct AuthBean: Codable {
    var authId: String?
    var authUrl: String?
    var callbackPage: String?
    var mobile: String?
    var personInfo: AuthPersonInfo?
    var ticket: String?

    enum CodingKeys: String, CodingKey {
        case authId
        case authUrl
        case callbackPage
        case mobile
        case personInfo
        case ticket
    }
}

// MARK: - PersonInfo
struct AuthPersonInfo: Codable {
    var address: String?
    var age: Int?
    var backFileId: Int?
    var backOcrResultId: Int?
    var birth: String?
    var endDate: String?
    var faceFileId: Int?
    var faceOcrResultId: Int?
    var issue: String?
    var name: String?
    var nationality: String?
    var num: String?
    var sex: String?
    var startDate: String?

    enum CodingKeys: String, CodingKey {
        case address
        case age
        case backFileId
        case backOcrResultId
        case birth
        case endDate
        case faceFileId
        case faceOcrResultId
        case issue
        case name
        case nationality
        case num
        case sex
        case startDate
    }
}

extension UserDetailBean {

    func toAuthPersonInfo() -> AuthPersonInfo {
        var bean = AuthPersonInfo()
        bean.name = user?.name
        bean.sex = user?.sexName
        bean.age = user?.age
        bean.num = user?.idCardNum
        bean.address = user?.idCardAddress
        bean.startDate = user?.idCardStartDate
        bean.endDate = user?.idCardEndDate
        return bean
    }
}
