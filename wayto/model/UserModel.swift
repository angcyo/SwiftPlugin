//
// Created by angcyo on 21/08/11.
//

import Foundation

class UserModel: ViewModel {

    /// 获取人员扩展信息
    func getUserDetailEx(id: Int = vm(LoginModel.self).loginBeanData.valueOrNil()?.user?.userId ?? 0) {
        let url = "\(App.SystemSchema)/userExt/getDetailById"

        Api.json(url, query: ["id": id], method: .get) { json, error in
            debugPrint(json)
            debugPrint(error)
        }.disposed(by: disposeBag)
    }
}