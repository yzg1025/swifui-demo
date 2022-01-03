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
    case Account = "person.fill"
}

// 注册/登录
enum EntryType: String {
    case Register = "Register"
    case Login = "Login"
}

enum CustomTabs: String,CaseIterable{
    case home = "Home"
    case mine = "我的"
    
    var iconName: String{
        switch self{
        case .home:
            return "home"
        case .mine:
            return "mine"
        }
    }
    
    var iconNameNor: String{
        return iconName
    }
    
    var iconNameAct: String{
        return iconName + "_act"
    }
}
