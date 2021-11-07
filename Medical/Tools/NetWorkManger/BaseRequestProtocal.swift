//
//  BaseRequestProtocal.swift
//  Medical
//
//  Created by 于争光 on 2021/10/4.
//

import Foundation
import Alamofire
import Combine

protocol BaseRequestProtocal: BaseApiProtocol,URLRequestConvertible{
    var paramters: Parameters? { get }
    
    var encoding: URLEncoding { get }
}

extension BaseRequestProtocal{
    var encoding: URLEncoding {
        return .default
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(path))
        
        urlRequest.allHTTPHeaderFields = headers
        
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.timeoutInterval = 30
        
        if let params = paramters{
            urlRequest = try encoding.encode(urlRequest, with: params)
        }
        
        return urlRequest
    }
}
