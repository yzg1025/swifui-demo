//
//  Home.swift
//  Medical
//
//  Created by 于争光 on 2021/12/5.
//

import SwiftUI

struct Home: View {
    @StateObject var home = HomeModels()
    @State var pageoffset: CGFloat = .zero
    var body: some View {
        ZStack(alignment: .top){
            ScrollView(showsIndicators: false){
                VStack{
                    HomeSwiper()
                        .environmentObject(home)
                    
                    TabTagCell()
                        .environmentObject(home)
          
                    TabViewList()
                        .environmentObject(home)
                    
                    GuessYouLikeView()
                        .environmentObject(home)

                    AlbumRankView()
                        .environmentObject(home)
                    
                }
                .pageOffset()
                .onPreferenceChange(ViewOffsetKey.self) { pageoffset = $0 }
            }
            if pageoffset >= 80  {
                SeachButton()
                    .frame(maxWidth: .infinity)
                    .frame(height: 100)
                    .offset(x: 0, y: 20)
                    .background(.ultraThinMaterial)
            }
        }
        .coordinateSpace(name: "scroll")
        .ignoresSafeArea()
    }
}


