//
//  AlbumSimpleInfo.swift
//  Medical
//
//  Created by 于争光 on 2022/1/2.
//

import Foundation

typealias TypeSimpleAlbum = Result<CommonResult<SimpleAlbum>,Error>
typealias TypeAnchorInfo = Result<CommonResult<AnchorBasicInfo>,Error>

class AlbumSimpleInfo: ObservableObject{
    @Published var https:HttpManager = HttpManager.share
    @Published var state:NWPState = NWPState.share
    @Published var simpleInfo: SimpleAlbum!
    @Published var anchorInfo: AnchorBasicInfo!
    
    func getSimpleInfo(albumId: Int){
        let path = "api/hs_base/simpleAlbum"
        let params = ["albumId":albumId]
        self.https.Post(path:path, params: params){res in
            switch res{
            case let .success(data):
                let result: TypeSimpleAlbum = self.https.parseData(data)
                switch result{
                case let .success(list):
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.simpleInfo = list.data
                    }
                    
                case let .failure(err):  print(err.localizedDescription)
                }
            case .failure(_): print("banner 请求失败")
            }
        }
    }
    
    func getAnchorInfo(uid: String){
        let path = "api/hs_base/basicAnchorInfo"
        let params = ["uid":uid.components(separatedBy: "/")[2]]
        self.https.Post(path:path, params: params){res in
            switch res{
            case let .success(data):
                let result: TypeAnchorInfo = self.https.parseData(data)
                switch result{
                case let .success(list):
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.anchorInfo = list.data
                    }
                    
                case let .failure(err):  print(err.localizedDescription)
                }
            case .failure(_): print("AnchorInfo 请求失败")
            }
        }
    }
    
    func followAnchor(uid: Int,follow: Bool){
        let path = "api/hs_base/followAnchor"
        let params = ["uid":uid,"follow": follow ? "1": "0"] as [String : Any]
        self.https.Post(path:path, params: params){res in
            switch res{
            case let .success(data):
                let result: TypeAnchorInfo = self.https.parseData(data)
                switch result{
                case let .success(list):
                    if list.code == 200 {
                        self.state.showWaits(message: "关注成功")
                    }
                    
                case let .failure(err):  print(err.localizedDescription)
                }
            case .failure(_): print("AnchorInfo 请求失败")
            }
        }
    }
}
