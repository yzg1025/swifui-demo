//
//  Login.swift
//  Medical
//
//  Created by 于争光 on 2021/10/30.
//

import Foundation

class LoginModel: NSObject,ObservableObject{
    @Published var msg:NWPState = NWPState()
    @Published var user:UsersModel = UsersModel()
    @Published var https:HttpManager = HttpManager.share
    @Published var showLoginPage: Bool = false
    @Published var enterType: String = "Login"
    @Published var isPresented: Bool = false
    
    func loginPhone(phone: String,password: String){
        let path = "api/hs_base/login"
        let params = ["phone":phone,"password": password]
        self.https.Post(path:path, params: params){res in
            switch res{
            case let .success(data):
                let result: TypeLogin = self.https.parseData(data)
                switch result{
                case let .success(list):
                    DispatchQueue.main.async {
                        self.user.setNormalDefault(key: "token", val: list.data.token)
                        self.user.setNormalDefault(key: "nickname", val: list.data.userinfo.nickname)
                        self.user.setNormalDefault(key: "hearder", val: list.data.userinfo.header)
                        self.user.setNormalDefault(key: "uid", val: list.data.userinfo.uid)
                        self.user.setNormalDefault(key: "phone", val: list.data.userinfo.phone)
                        self.msg.alertMsg(message: "登录成功", systemImage: "checkmark.circle")
                        print("88888",list.data.userinfo)
                    }
                case let .failure(err):
                    self.msg.alertMsg(message: err.localizedDescription, systemImage: "multiply.circle")
                }
            case .failure(_): print("请求失败")
            }
        }
    }
}
