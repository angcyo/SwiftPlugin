//
// Created by angcyo on 21/08/11.
//

import Foundation

class UserModel: ViewModel {

    /// 用户详细信息
    let userDetailData = liveData(UserDetailBean())

    /// 获取人员扩展信息
    func getUserDetailEx(id: Int = vm(LoginModel.self).loginBeanData.valueOrNil()?.user?.userId ?? 0,
                         _ onEnd: ((HttpBean<UserDetailBean>?, Error?) -> Void)? = nil) {
        let mainId = vm(LoginModel.self).loginBeanData.valueOrNil()?.user?.userId
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
}