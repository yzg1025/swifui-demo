//
//  NetWorkConfig.swift
//  Medical
//
//  Created by 于争光 on 2021/10/4.
//

import Foundation

struct NetWorkConfig{
    static var baseURL: String {
        #if DEBUG
        return "http://localhost:8866/"
        #else
        return "http://localhost:8866/"
        #endif
    }
}
