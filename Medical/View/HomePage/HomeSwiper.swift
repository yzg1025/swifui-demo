//
//  HomeSwiper.swift
//  Medical
//
//  Created by 于争光 on 2021/12/5.
//

import SwiftUI

struct HomeSwiper: View {
    @EnvironmentObject var banner: HomeModels
    @StateObject var user: UsersModel = UsersModel()
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    @State var dragOffset: CGFloat = .zero
    @State var currentIndex: Int = 0
    @State var isAnimation: Bool = true
    
    var body: some View {
        let currentOffset = CGFloat(currentIndex) * (UIScreen.main.bounds.width + 10)
        ZStack(alignment: .topTrailing){
            HStack(spacing: 10){
                ForEach(banner.bannerList,id:\.id){ item in
                    if #available(iOS 15.0, *) {
                        NavigationLink(
                            destination: WebViewContent(bannerItem: item)
                        ){
                            AsyncImage(url: URL(string: item.url)) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width:UIScreen.main.bounds.width,height: 250)
                        }
                        .navigationBarHidden(true)
                    } else {
                        EmptyView()
                    }
                }
            }
            .frame(width:UIScreen.main.bounds.width,alignment:.leading)
            .offset(x: dragOffset - currentOffset)
            .gesture(dragGesture)
            .animation(isAnimation ? .spring(): .none)
            .onReceive(timer, perform: { value in
                if currentIndex == banner.bannerList.count - 1 {
                    currentIndex = 0
                }else{
                    currentIndex += 1
                }
                
            })

            if banner.bannerList.count != 0 { SeachButton().offset(x: 0, y: 40) }
           
            Indaiction.offset(x: 0, y: 140)
        }
        .onAppear {
            banner.queryBanners()
        }
    }
    // 指示器
    var Indaiction: some View{
        VStack{
            ZStack{
                HStack{
                    ForEach([1,2],id: \.self){ item in
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.white)
                            .frame(width: 4,height: CGFloat(13 * banner.bannerList.count))
                            .padding(.horizontal,15)
                    }
                }
                VStack{
                    ForEach(banner.bannerList,id:\.id){ item in
                        ZStack{
                            RoundedRectangle(cornerRadius: 4)
                                .fill(.white)
                                .frame(width: 40,height: 4)
                            if banner.bannerList[currentIndex].order == item.order  {
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(.black)
                                    .frame(width: 35,height: 4)
                            }
                        }
                        
                    }
                }
            }
        }
        .rotation3DEffect(.degrees(20), axis: (x: 1, y: 0, z: 0))
        .padding(.bottom,20)
    }
}

extension HomeSwiper{
    private var dragGesture: some Gesture{

        DragGesture()
            .onChanged {
                isAnimation = true
                dragOffset = $0.translation.width
            }
            .onEnded {
                dragOffset = .zero
                if $0.translation.width > 50{
                    currentIndex -= 1
                }
                if $0.translation.width < -50{
                    currentIndex += 1
                }
                currentIndex = max(min(currentIndex, banner.bannerList.count - 1), 0)
            }
    }
}
