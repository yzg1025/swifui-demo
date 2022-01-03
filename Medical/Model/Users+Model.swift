//
//  Users+Model.swift
//  Medical
//
//  Created by 于争光 on 2021/12/17.
//

import Foundation


struct UserLogin: Codable {
    var userinfo: Userinfo
    var token: String
}

// MARK: - DataData
struct Userinfo: Codable {
    var uid: Int
    var nickname: String
    var phone: String
    var password: String
    var login_method: String
    var register_time: String
    var header: String
}
