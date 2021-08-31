// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let userDetailBean = try? newJSONDecoder().decode(UserDetailBean.self, from: jsonData)

import Foundation

/// http://test.kaiyang.wayto.com.cn/kaiyangSystem/doc.html#/default/%E5%BC%80%E9%98%B3-%E4%BA%BA%E5%91%98%E6%89%A9%E5%B1%95%E4%BF%A1%E6%81%AF/getDetailByIdUsingGET_8
// MARK: - UserDetailBean
struct UserDetailBean: Codable {
    var id: Int?
    var updateTime: String?
    var updateUserId: Int?
    var qualification: Int?
    var politicalStatus: Int?
    var securityCardNumber: String?
    var securityDigitalReceipt: String?
    var height: Int?
    var bloodType: Int?
    var veteransAble: Bool?
    var veteransCardNo: String?
    var userDetailBeanDescription: String?
    var specialty: String?
    var fireControlNo: String?
    var extendData: String?
    var health: Int?
    var signCommitmentAble: Bool?
    var fireControlNoExist: Bool?
    var securityCardNoExist: Bool?
    var user: User?
    var userFamilyList: [UserFamily]?
    var contract: Contract?
    var userFileList: [FileBean]?
    var nation: Int?
    var personalAuth: Int? //个人认证状态,0未认证,1认证信息已提交,2实名认证成功,3实名认证失败
    var nationName: String?
    var qualificationName: String?
    var politicalStatusName: String?
    var bloodTypeName: String?
    var healthName: String?

    enum CodingKeys: String, CodingKey {
        case id
        case updateTime
        case updateUserId
        case nation
        case qualification
        case politicalStatus
        case securityCardNumber
        case securityDigitalReceipt
        case height
        case bloodType
        case veteransAble
        case veteransCardNo
        case userDetailBeanDescription
        case specialty
        case fireControlNo
        case extendData
        case health
        case signCommitmentAble
        case fireControlNoExist
        case securityCardNoExist
        case user
        case userFamilyList
        case contract
        case userFileList
        case nationName
        case personalAuth
        case qualificationName
        case politicalStatusName
        case bloodTypeName
        case healthName
    }
}

// MARK: - Contract
struct Contract: Codable {
    var id: Int?
    var createTime: String?
    var createUserId: Int?
    var updateTime: String?
    var updateUserId: Int?
    var userGroupId: Int?
    var userId: Int?
    var contractNo: String?
    var contractType: Int?
    var contractStartDate: String?
    var contractEndDate: String?

    //var contractFileList: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id
        case createTime
        case createUserId
        case updateTime
        case updateUserId
        case userGroupId
        case userId
        case contractNo
        case contractType
        case contractStartDate
        case contractEndDate
        //case contractFileList
    }
}

// MARK: - User
struct User: Codable {
    var id: Int?
    var password: String?
    var name: String?
    var code: String?
    var sex: String?
    var address: String?
    var mobile: String?
    var email: String?
    var lastLoginTime: String?
    var enable: Bool?
    var status: Int?
    var createTime: String?
    var createUserId: Int?
    var updateTime: String?
    var updateUserId: Int?
    var headImgUrl: String?
    var headImgId: Int?
    var maritalStatus: Int?
    var birthday: String?
    var entryDate: String?
    var areaId: Int?
    var positionId: Int?
    var accountList: [AccountList]?
    var userGroup: UserGroup?
    var userGroupId: Int?
    //var roleIdList: JSONNull?
    var sexName: String?
    var age: Int?
    var statusName: String?
    var maritalStatusName: String?
    var positionName: String?

    var idCardAddress: String? //	身份证地址	string
    var idCardEndDate: String? //	身份证有效期结束时间	string
    var idCardNum: String? // 	身份证号	string
    var idCardSignOrg: String?  //	身份证签发机关	string
    var idCardStartAndEndDate: String? //	身份证开始时间和结束时间融合字段	string
    var idCardStartDate: String?  //	身份证有效期开始时间	string

    //var allRoleIdList: [JSONAny]?

    enum CodingKeys: String, CodingKey {
        case id
        case password
        case name
        case code
        case sex
        case address
        case mobile
        case email
        case lastLoginTime
        case enable
        case status
        case createTime
        case createUserId
        case updateTime
        case updateUserId
        case headImgUrl
        case headImgId
        case maritalStatus
        case birthday
        case entryDate
        case areaId
        case positionId
        case accountList
        case userGroup
        case userGroupId
        //case roleIdList
        case sexName
        case age
        case statusName
        case maritalStatusName
        case positionName
        //case allRoleIdList

        case idCardAddress
        case idCardEndDate
        case idCardNum
        case idCardSignOrg
        case idCardStartAndEndDate
        case idCardStartDate
    }
}

// MARK: - AccountList
struct AccountList: Codable {
    var id: Int?
    var userId: Int?
    var username: String?
    var category: Int?
    var createTime: String?
    var createUserId: Int?
    var updateTime: String?
    var updateUserId: Int?
    var categoryDesc: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userId
        case username
        case category
        case createTime
        case createUserId
        case updateTime
        case updateUserId
        case categoryDesc
    }
}

// MARK: - UserGroup
struct UserGroup: Codable {
    var id: Int?
    var parentId: Int?
    var parentIds: String?
    var name: String?
    var code: String?
    var userGroupDescription: String?
    var createTime: String?
    var createUserId: Int?
    var updateTime: String?
    var updateUserId: Int?
    var enable: Bool?
    var groupType: Int?
    //var children: JSONNull?
    //var parents: JSONNull?
    //var roleIdList: JSONNull?
    var label: String?

    enum CodingKeys: String, CodingKey {
        case id
        case parentId
        case parentIds
        case name
        case code
        case userGroupDescription
        case createTime
        case createUserId
        case updateTime
        case updateUserId
        case enable
        case groupType
        //case children
        //case parents
        //case roleIdList
        case label
    }
}

// MARK: - UserFamilyList
struct UserFamily: Codable {
    var id: Int?
    var createTime: String?
    var createUserId: Int?
    var updateTime: String?
    var updateUserId: Int?
    var userGroupId: Int?
    var userId: Int?
    var name: String?
    var mobile: String?
    var address: String?
    var relation: Int?
    var idCardNum: String?
    var relationName: String?

    enum CodingKeys: String, CodingKey {
        case id
        case createTime
        case createUserId
        case updateTime
        case updateUserId
        case userGroupId
        case userId
        case name
        case mobile
        case address
        case relation
        case idCardNum
        case relationName
    }
}
