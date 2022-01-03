//
//  NetWorkTool.swift
//  Medical
//
//  Created by 于争光 on 2021/10/4.
//

import Foundation
import Alamofire

enum ApiError{
    case custom(msg: String)
}


typealias Rus = Result<Data,Error>
typealias Completion = (Rus) -> Void

class HttpManager {
    
    static let share = HttpManager()
    
    private let header: HTTPHeaders = ["Content-Type":"application/json;charset=utf-8"]
    
    private let ApiUrl = "http://localhost:8866/"
    
    public init(){}
    
    @discardableResult
    func Get(
        path:String,
        params:Parameters?,
        completion: @escaping Completion
    ) -> DataRequest {
        AF.request(
            ApiUrl + path,
            parameters: params,
            headers: header,
            requestModifier: {$0.timeoutInterval = 15}
        )
        .responseData { res in
            switch res.result{
                case let .success(data): completion(.success(data))
                case let .failure(error): completion(self.handleErr(error))
            }
        }
    }
    
    @discardableResult
    func Post(
        path:String,
        params:Parameters?,
        completion: @escaping Completion
    ) -> DataRequest {
        AF.request(
            ApiUrl + path,
            method:.post,
            parameters: params,
            encoding: JSONEncoding.default,
            headers: header,
            requestModifier: {$0.timeoutInterval = 15}
        )
        .responseData { res in
            switch res.result{
                case let .success(data): completion(.success(data))
                case let .failure(error): completion(self.handleErr(error))
            }
        }
        
    }
    
    private func handleErr(_ error: AFError) -> Rus{
        if let underlyingError = error.underlyingError{
            let nserror = underlyingError as NSError
            let code = nserror.code
            if code == NSURLErrorNotConnectedToInternet || code == NSURLErrorTimedOut ||
               code == NSURLErrorInternationalRoamingOff || code == NSURLErrorDataNotAllowed ||
               code == NSURLErrorCannotFindHost || code == NSURLErrorCannotConnectToHost ||
               code == NSURLErrorNetworkConnectionLost {
                var useInfo = nserror.userInfo
                useInfo[NSLocalizedDescriptionKey] = "网络连接有点问题"
                let currentError = NSError(domain: nserror.domain, code: code, userInfo: useInfo)
                return .failure(currentError)
            }
        }
        return .failure(error)
    }
}

extension HttpManager{
    func parseData<T: Decodable>(_ data:Data) -> Result<T,Error>{
        guard let decodeData = try? JSONDecoder().decode(T.self, from: data) else{
            let err = NSError(domain: "NetApiError", code: 0, userInfo: [NSLocalizedDescriptionKey:"无法解析数据"])
            return .failure(err)
        }
        return .success(decodeData)
    }
}

