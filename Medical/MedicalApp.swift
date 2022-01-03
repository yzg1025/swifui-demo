//
//  MedicalApp.swift
//  Medical
//
//  Created by 于争光 on 2021/10/3.
//

import SwiftUI

@main
struct MedicalApp: App {
    @AppStorage("colorIndex") var colorIndex: String = "默认"
    var body: some Scene {
        WindowGroup {
            MainView().preferredColorScheme(getTheme())
        }
    }
    
    // 切换主题
    func getTheme() -> ColorScheme {
        if colorIndex == "白天" {
            return .light
        } else if colorIndex == "黑夜" {
            return .dark
        }
        return .light
    }
}
