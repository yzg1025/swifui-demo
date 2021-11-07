//
//  Category.swift
//  Medical
//
//  Created by 于争光 on 2021/10/24.
//

import Foundation

struct Category: Codable,Hashable{
    var cateId: String
    var cateImage: String
    var cateName: String
    var cateBg: String
}

struct ChatCard: Codable,Hashable{
    var chatId: String
    var chatDesc: String
    var chatName: String
    var chatIamge: String
}

struct ProductItem: Codable,Hashable,Identifiable {
    var id = UUID().uuidString
    var productId: String
    var isLike: Bool
    var productName: String
    var productDesc: String
    var productPrice: String
    var productImage: String
}

var CategoryList = [
    Category(
        cateId: "LOOK_DOCTOR",
        cateImage:"work",
        cateName:"Find\nDoctors",
        cateBg: "#0000FF"
    ),
    Category(
        cateId: "CHAT_DOCTOR",
        cateImage:"work",
        cateName:"Chat with\nDoctors",
        cateBg: "#FF7F50"
    ),
    Category(
        cateId:"MD_PRODUCT",
        cateImage:"work",
        cateName:"Medicines&\nProducts",
        cateBg: "#00FFFF"
    )
]

var ChatList = [
    ChatCard(
        chatId: "#01",
        chatDesc:"Pregnancy\nor Periods Doubts",
        chatName:"Gynaecology",
        chatIamge: "yf"
    ),
    ChatCard(
        chatId: "#02",
        chatDesc:"Acne,Pimple\nskin issucs",
        chatName:"Dermotoley",
        chatIamge: "yf"
    ),
    ChatCard(
        chatId: "#03",
        chatDesc:"Pregnancy\nor Periods Doubts",
        chatName:"Gynaecology",
        chatIamge: "yf"
    ),
    ChatCard(
        chatId: "#04",
        chatDesc:"Acne,Pimple\nskin issucs",
        chatName:"Dermotoley",
        chatIamge: "yf"
    ),
]


var ProductList = [
    ProductItem(productId: "001", isLike: false, productName: "THE ORDINARY", productDesc: "Peeling Solution 30ml", productPrice: "80.00",productImage: "yp"),
    
    ProductItem(productId: "002", isLike: true, productName: "THE ORDINARY", productDesc: "Plant-Derived Hemi Squal 25ml", productPrice: "120.03",productImage: "yp"),
    
    ProductItem(productId: "003", isLike: false, productName: "THE ORDINARY", productDesc: "Peeling Solution 30ml", productPrice: "30.00",productImage: "yp"),
    
    ProductItem(productId: "004", isLike: false, productName: "THE ORDINARY", productDesc: "Peeling Solution 30ml", productPrice: "34.00",productImage: "yp"),
    
    ProductItem(productId: "005", isLike: false, productName: "THE ORDINARY", productDesc: "Peeling Solution 30ml", productPrice: "88.20",productImage: "yp"),
    
    ProductItem(productId: "006", isLike: false, productName: "THE ORDINARY", productDesc: "Peeling Solution 30ml", productPrice: "230.00",productImage: "yp"),
    
    ProductItem(productId: "007", isLike: false, productName: "THE ORDINARY", productDesc: "Peeling Solution 30ml", productPrice: "670.00",productImage: "yp"),
    
    ProductItem(productId: "008", isLike: false, productName: "THE ORDINARY", productDesc: "Peeling Solution 30ml", productPrice: "139.00",productImage: "yp"),
    
    ProductItem(productId: "009", isLike: false, productName: "THE ORDINARY", productDesc: "Peeling Solution 30ml", productPrice: "98.00",productImage: "yp"),
    
    ProductItem(productId: "010", isLike: false, productName: "THE ORDINARY", productDesc: "Peeling Solution 30ml", productPrice: "10.33",productImage: "yp"),
    
    ProductItem(productId: "011", isLike: false, productName: "THE ORDINARY", productDesc: "Peeling Solution 30ml", productPrice: "67.00",productImage: "yp"),
    
    ProductItem(productId: "012", isLike: false, productName: "THE ORDINARY", productDesc: "Peeling Solution 30ml", productPrice: "88.00",productImage: "yp")
]
