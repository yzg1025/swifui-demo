//
//  BaseApiProtocal.swift
//  Medical
//
//  Created by 于争光 on 2021/10/4.
//

import Foundation
import Alamofire

protocol BaseApiProtocol{
    var method: HTTPMethod { get }
    
    var baseURL: URL { get }
    
    var path: String { get }
    
    var headers: [String: String]? { get }
}


extension BaseApiProtocol{
    var baseURL: URL {
        return try! NetWorkConfig.baseURL.asURL()
    }
    var headers: [String: String]? {
        return nil
    }
}
