//
//  Search.swift
//  Medical
//
//  Created by 于争光 on 2021/12/14.
//

import Foundation

// MARK: -  SearchHotCate
struct SearchHotCate: Codable {
    let categoryId: Int
    let categoryName: String
}

struct HotWordBillboard: Codable,Hashable{
    let word: String
    let shift, display_type: Int
    let is_through: Bool
    let through_type, tgt_id, count: Int
    let intro, url, display_word: String
    let outside_hot_search_type, score, categoryInt: Int
}
