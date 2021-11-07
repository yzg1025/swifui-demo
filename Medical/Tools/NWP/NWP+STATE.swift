//
//  NWP+STATE.swift
//  Medical
//
//  Created by 于争光 on 2021/10/3.
//

import Foundation
import SwiftUI

final class NWPState: ObservableObject {
    // 显示等待
    @Published var showWait: Bool = false
    // 其他提示例如错误信息,接口返回的msg
    @Published var isPresent: Bool = false
    
    // 要显示的消息
    private(set) var message: String = ""
    
    // icon名称
    private(set) var systemImage: String = ""
    
    func showWaits(message: String) {
        self.message = message
        withAnimation {
            showWait.toggle()
        }
    }
    
    func alertMsg(message: String,systemImage: String) {
        self.message = message
        self.systemImage = systemImage
        withAnimation {
            isPresent.toggle()
        }
    }
}
