//
// Created by angcyo on 21/08/11.
//

import Foundation
import SwiftyJSON

class UserModel: ViewModel {

    /// 用户详细信息
    let userDetailData = liveData(UserDetailBean.self)

    /// 登录的用户id
    func loginUserId() -> Int? {
        return vm(LoginModel.self).loginUserId()
    }

    func getUserDetailEx(_ onEnd: ((HttpBean<UserDetailBean>?, Error?) -> Void)? = nil) {
        getUserDetailEx(id: loginUserId() ?? 0, onEnd)
    }

    /// 获取人员扩展信息
    /// http://test.kaiyang.wayto.com.cn/kaiyangSystem/doc.html#/default/%E5%BC%80%E9%98%B3-%E4%BA%BA%E5%91%98%E6%89%A9%E5%B1%95%E4%BF%A1%E6%81%AF/getDetailByIdUsingGET_11
    func getUserDetailEx(id: Int, _ onEnd: ((HttpBean<UserDetailBean>?, Error?) -> Void)? = nil) {
        let mainId = loginUserId()
        let url = "\(App.SystemSchema)/userExt/getDetailById"

        Api.bean(url, query: ["id": id], method: .get) { (bean: HttpBean<UserDetailBean>?, error: Error?) in
            if error == nil, let bean = bean {
                if mainId == id {
                    self.userDetailData.setValue(bean.data!)
                }
            }
            onEnd?(bean, error)
        }.disposed(by: disposeBag)
    }

    /// 修改人员扩展信息
    /// http://test.kaiyang.wayto.com.cn/kaiyangSystem/doc.html#/default/%E5%BC%80%E9%98%B3-%E4%BA%BA%E5%91%98%E6%89%A9%E5%B1%95%E4%BF%A1%E6%81%AF/updateByIdUsingPUT_11
    func putUserDetail(param: [String: Any]?, _ onEnd: ((JSON?, Error?) -> Void)? = nil) {
        let url = "\(App.SystemSchema)/userExt/updateById"
        Api.json(url, param, method: .put) { data, error in
            onEnd?(data, error)
        }.disposed(by: disposeBag)
    }

    /// 获取指定类型的图片url
    func getUserFileUrl(_ type: Int) -> String? {
        guard let bean: UserDetailBean = userDetailData.data() else {
            return nil
        }
        let file = bean.userFileList?.find {
            $0.fileType == type
        }
        return file?.filePath?.toSchemaUrl()
    }

    /// 保存家庭成员
    /// http://test.kaiyang.wayto.com.cn/kaiyangSystem/doc.html#/default/%E5%BC%80%E9%98%B3-%E4%BA%BA%E5%91%98%E5%AE%B6%E5%BA%AD%E6%88%90%E5%91%98%E4%BF%A1%E6%81%AF/saveUsingPOST_12
    func saveFamily(param: [String: Any]?, _ onEnd: ((JSON?, Error?) -> Void)? = nil) {
        let url = "\(App.SystemSchema)/userFamily/save"
        Api.json(url, param, method: .post) { data, error in
            onEnd?(data, error)
        }.disposed(by: disposeBag)
    }

    /// 修改家庭成员
    /// http://test.kaiyang.wayto.com.cn/kaiyangSystem/doc.html#/default/%E5%BC%80%E9%98%B3-%E4%BA%BA%E5%91%98%E5%AE%B6%E5%BA%AD%E6%88%90%E5%91%98%E4%BF%A1%E6%81%AF/saveUsingPOST_12
    func putFamily(param: [String: Any]?, _ onEnd: ((JSON?, Error?) -> Void)? = nil) {
        let url = "\(App.SystemSchema)/userFamily/updateById"
        Api.json(url, param, method: .put) { data, error in
            onEnd?(data, error)
        }.disposed(by: disposeBag)
    }

    /// 删除家庭成员
    /// http://test.kaiyang.wayto.com.cn/kaiyangSystem/doc.html#/default/%E5%BC%80%E9%98%B3-%E4%BA%BA%E5%91%98%E5%AE%B6%E5%BA%AD%E6%88%90%E5%91%98%E4%BF%A1%E6%81%AF/virtualRemoveByIdUsingPUT_12
    func removeFamily(id: Int, _ onEnd: ((JSON?, Error?) -> Void)? = nil) {
        let url = "\(App.SystemSchema)/userFamily/virtualRemoveById"
        Api.json(url, query: ["id": id], method: .put) { data, error in
            onEnd?(data, error)
        }.disposed(by: disposeBag)
    }
}