//
//  BannelModel.swift
//  Medical
//
//  Created by 于争光 on 2021/12/4.
//

import Foundation

// MARK: - Datum
struct Banners: Codable {
    let id: Int
    let url: String
    let redirect_url: String
    let order: Int
    let title: String
}


struct Tabs: Codable {
    let groupId: Int
    let groupName: String
    let position, channelId: Int
    let channelName, channelLink: String
}

struct TabViewListModel: Codable{
    let id: Int
    let name: String
    let channelCount: Int
    let position: Int
}

// MARK: - DataClass
struct GuessYouLike: Codable {
    let count: Int
    let recommendAnchorList: [RecommendAnchorList]
    let recommendInfoList: [RecommendInfoList]
}

// MARK: - RecommendAnchorList
struct RecommendAnchorList: Codable {
    let uid: Int
    let coverPath, anchorNickName, background, description: String
    let url: String
    let grade, gradeType, trackCount, albumCount: Int
    let followerCount: Int
    let followingCount: String
    let isFollow: Bool
    let logoType: Int
    let ptitle: String
}

// MARK: - RecommendInfoList
struct RecommendInfoList: Codable,Hashable {
    let albumId, albumPlayCount, albumTrackCount: Int
    let albumCoverPath, albumTitle, albumUserNickName: String
    let anchorId, anchorGrade: Int
    let isDeleted, isPaid: Bool
    let isFinished: Int
    let anchorUrl, albumUrl, intro: String
    let vipType, logoType, albumSubscript: Int
}


// MARK: - DataClass
struct ResultAlbumRank: Codable {
    let albumRankPageList: [AlbumRankPageList]
    let pageNum, pageSize: Int
    let rankIds: [Int]
}

// MARK: - AlbumRankPageList
struct AlbumRankPageList: Codable {
    let rankResult: RankResult
    let albums: [Album]
}

// MARK: - Album
struct Album: Codable {
    let id: Int
    let albumTitle, anchorName, albumUrl, cover: String
    let anchorUrl, playCount, trackCount, description: String
    let tagStr: String
    let isPaid: String
    let price, vipType: String
}

// MARK: - RankResult
struct RankResult: Codable {
    let count: Int
    let ids: String
    let coverPath: String
    let title: String
    let rankId: Int
    let subtitle, shareUrl: String

}
