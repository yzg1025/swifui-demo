//
//  SimpleAblue+Model.swift
//  Medical
//
//  Created by 于争光 on 2022/1/2.
//

import Foundation

// MARK: - DataClass
struct SimpleAlbum: Codable {
    let albumId: Int
    let albumsimpleInfo: AlbumsimpleInfo
}

// MARK: - AlbumsimpleInfo
struct AlbumsimpleInfo: Codable {
    let albumId: String
    let anchorUid, albumStatus: Int
    let showApplyFinishBtn, showEditBtn, showTrackManagerBtn, showInformBtn: Bool
    let cover, albumTitle, updateDate, createDate: String
    let playCount: Int
    let isPaid: Bool
    let isFinished: String
    let isSubscribe, isPublic, hasBuy: Bool
    let vipType: Int
    let customTitle, recommendReason: String
    let albumSubscript: Int
    let tags: String
    let ximaVipFreeType, subscribeCount: Int
    let shortIntro, richIntro, detailRichIntro: String
}


// MARK: - DataClass
struct AnchorBasicInfo: Codable {
    let uid: Int
    let nickName, cover, background: String
    let isVip: Bool
    let constellationType: Int
    let personalSignature, personalDescription: String
    let fansCount, gender, birthMonth, birthDay: Int
    let province, city: String
    let anchorGrade, anchorGradeType: Int
    let isMusician: Bool
    let anchorUrl: String
    let logoType, followingCount, tracksCount, albumsCount: Int
    let albumCountReal: Int
    let userCompany: String
    let isFollow, beFollow, isBlack: Bool
}
