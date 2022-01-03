//
//  Common.swift
//  Medical
//
//  Created by 于争光 on 2021/12/5.
//

import Foundation

// MARK: - Result 公共的
struct CommonResult<T: Codable>: Codable {
    let code: Int
    let data: T
    let msg: String
}
