//
//  BaseModel.swift
//  Medical
//
//  Created by 于争光 on 2021/10/4.
//

import Foundation

struct Future {
    private static func parseData<T: Decodable>(_ data:Data) -> Result<T,Error>{
         
         guard let decodeData = try? JSONDecoder().decode(T.self, from: data) else{
             let err = NSError(domain: "NetApiError", code: 0, userInfo: [NSLocalizedDescriptionKey:"无法解析数据"])
             return .failure(err)
         }
         
         return .success(decodeData)
     }
}
