//
//  Login.swift
//  Medical
//
//  Created by 于争光 on 2021/10/30.
//

import Foundation

class LoginModel: NSObject,ObservableObject{
    
    @Published var showLoginPage: Bool = false
    @Published var enterType: String = "Login"
    @Published var isPresented: Bool = false
}
