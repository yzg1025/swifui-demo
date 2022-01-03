//
//  Search.swift
//  Medical
//
//  Created by 于争光 on 2021/12/14.
//

import Foundation

//
//  Banners.swift
//  Medical
//
//  Created by 于争光 on 2021/12/4.
//

import Foundation

typealias TypeHotCate = Result<CommonResult<[SearchHotCate]>,Error>
typealias TypeHotWord = Result<CommonResult<[HotWordBillboard]>,Error>

class SearchModels:NSObject,ObservableObject {

    @Published var https:HttpManager = HttpManager.share
    @Published var searchCate: [SearchHotCate] = []
    @Published var hotWord: [HotWordBillboard] = []
    
    func hotWordBillboardCategory(){
        let path = "api/hs_base/hotWordBillboardCategory"
        self.https.Get(path:path, params: nil){res in
            switch res{
            case let .success(data):
                let result: TypeHotCate = self.https.parseData(data)
                switch result{
                case let .success(list):
                    self.searchCate = list.data
                case let .failure(err):  print(err.localizedDescription)
                }
            case .failure(_): print("请求失败")
            }
        }
    }
    
    func hotWordBillboard(id:Int){
        let params = ["categoryId":id]
        let path = "api/hs_base/hotWordBillboard"
        self.https.Get(path:path, params: params){res in
            switch res{
            case let .success(data):
                let result: TypeHotWord = self.https.parseData(data)
                switch result{
                case let .success(list):
                    self.hotWord = list.data
                case let .failure(err):  print(err.localizedDescription)
                }
            case .failure(_): print("请求失败")
            }
        }
    }
}
