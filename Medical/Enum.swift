//
//  Enum.swift
//  Medical
//
//  Created by 于争光 on 2021/10/4.
//

import Foundation

// TabViewBar
enum Tab: String,CaseIterable {
    case Home = "house.fill"
    case Search = "magnifyingglass"
    case Notifications = "bell.fill"
    case Account = "person.fill"
}

// 注册/登录
enum EntryType: String {
    case Register = "Register"
    case Login = "Login"
}
