//
//  MedicalApp.swift
//  Medical
//
//  Created by 于争光 on 2021/10/3.
//

import SwiftUI

@main
struct MedicalApp: App {
    
    @StateObject var login = LoginModel()
    @StateObject var users = UsersModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(login)
                .environmentObject(users)
        }
    }
}
