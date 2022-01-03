//
//  WebViewContent.swift
//  Medical
//
//  Created by 于争光 on 2021/12/5.
//

import SwiftUI

struct WebViewContent: View {
    let bannerItem: Banners
    var body: some View {
        VStack{
            WebViewRoot(url:"https://www.ximalaya.com/\(bannerItem.redirect_url)",isLink: false)
        }
        .navigationBarTitle(bannerItem.title, displayMode: .inline)
       
    }
}

