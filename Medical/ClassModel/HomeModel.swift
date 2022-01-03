//
//  Banners.swift
//  Medical
//
//  Created by 于争光 on 2021/12/4.
//

import Foundation
import CoreMotion

typealias TypeBanner = Result<CommonResult<[Banners]>,Error>
typealias TypeTabList = Result<CommonResult<[Tabs]>,Error>
typealias TypeTabViewList = Result<CommonResult<[TabViewListModel]>,Error>
typealias TypeRankAlbum = Result<CommonResult<ResultAlbumRank>,Error>
typealias TypeGuessYouLike = Result<CommonResult<GuessYouLike>,Error>

class HomeModels:NSObject,ObservableObject {
    
    @Published var motionManager = CMMotionManager()
    @Published var queue = OperationQueue()
    
    @Published var x = Double.zero
    @Published var y = Double.zero
    @Published var z = Double.zero
    
    @Published var https:HttpManager = HttpManager.share
    @Published var bannerList: [Banners] = []
    
    @Published var tabLists:[Tabs] = []
    @Published var tabViewLists:[TabViewListModel] = []
    @Published var albumRanks:[AlbumRankPageList] = []
    @Published var guessyouLike: [RecommendInfoList] = []
    
    func queryBanners(){
        let path = "api/hs_base/banners_list"
        self.https.Get(path:path, params: nil){res in
            switch res{
            case let .success(data):
                let result: TypeBanner = self.https.parseData(data)
                switch result{
                case let .success(list):
                    self.bannerList = list.data
                case let .failure(err):  print(err.localizedDescription)
                }
            case .failure(_): print("banner 请求失败")
            }
        }
    }
    
    func tabList(){
        let path = "api/hs_base/tablist"
        self.https.Post(path:path, params: nil){res in
            switch res{
            case let .success(data):
                let result: TypeTabList = self.https.parseData(data)
                switch result{
                case let .success(list):
                    self.tabLists = list.data
                case let .failure(err):  print(err.localizedDescription)
                }
            case .failure(_): print(" 请求失败")
            }
        }
    }
    
    func tabViewList(){
        let path = "api/hs_base/tabViewList"
        self.https.Post(path:path, params: nil){res in
            switch res{
            case let .success(data):
                let result: TypeTabViewList = self.https.parseData(data)
                switch result{
                case let .success(list):
                    self.tabViewLists = list.data
                case let .failure(err):  print(err.localizedDescription)
                }
            case .failure(_): print(" 请求失败")
            }
        }
    }
    
    func getRankAlbum(rankIds: String,pageNo:Int,pageSize:Int) {
        let path = "api/hs_base/getRankAlbum"
        let params = ["rankIds":rankIds,"pageNo":pageNo,"pageSize":pageSize] as [String : Any]
        self.https.Get(path:path, params: params){res in
            switch res{
            case let .success(data):
                let result: TypeRankAlbum = self.https.parseData(data)
                switch result{
                case let .success(list):
                    self.albumRanks = list.data.albumRankPageList
                case let .failure(err):  print(err.localizedDescription)
                }
            case .failure(_): print("请求失败")
            }
        }
    }
    
    //GuessYouLike
    func getGuessYouLike() {
        let path = "api/hs_base/getGuessLike"
        self.https.Get(path:path, params: nil){res in
            switch res{
            case let .success(data):
                let result: TypeGuessYouLike = self.https.parseData(data)
                switch result{
                case let .success(list):
                    self.guessyouLike = list.data.recommendInfoList
                case let .failure(err):  print(err.localizedDescription)
                }
            case .failure(_): print("请求失败")
            }
        }
    }
    
    func Motions() {
        print("ON APPEAR")
        self.motionManager.startDeviceMotionUpdates(to: self.queue) { (data: CMDeviceMotion?, error: Error?) in
            guard let data = data else {
                print("Error: \(error!)")
                return
            }
            let position = data.rotationRate

            DispatchQueue.main.async {
                self.x = position.x
                self.y = position.y
                self.z = position.z
            }
        }
    }
    
}
