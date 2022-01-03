//
//  GuessYouLike.swift
//  Medical
//
//  Created by 于争光 on 2021/12/15.
//

import SwiftUI

struct GuessYouLikeView: View {
    @EnvironmentObject var home: HomeModels
    @Environment(\.colorScheme) var colorScheme
    @State var deg: Double = 0
    @State var length: Int = 6
    var body: some View {
        VStack{
            HStack {
                Color.init(hex: "#f86442").frame(width: 4, height: 20).padding(.trailing,5)
                Text("猜你喜欢")
                    .font(.callout)
                Spacer()
                Button {
                    withAnimation {
                        deg += 360
                        length += 6
                    }
                } label: {
                    HStack{
                        Image(systemName: "goforward")
                            .rotationEffect(.degrees(deg))
                        Text("换一批")
                    }
                    .font(/*@START_MENU_TOKEN@*/.callout/*@END_MENU_TOKEN@*/)
                }
                .foregroundColor(colorScheme == .light ? Color.black : .white)
            }
            FlowLayoutView(list: home.guessyouLike.suffix(length),column: 3,itemSpacingH:10, itemSpacingV: 10){ list in
                NavigationLink(destination: Text("2121").navigationTitle(Text("13"))){
                    VStack(alignment: .leading, spacing: 3){
                        ZStack(alignment: .topLeading){
                            AsyncImage(url: URL(string:"https:" + list.albumCoverPath)) { image in
                                image.resizable().aspectRatio(contentMode: .fit)
                            } placeholder: {
                                ProgressView().frame(width:UIScreen.main.bounds.width/2 - 30)
                            }
                            if list.vipType == 2 {
                                Text("VIP")
                                    .foregroundColor(.white)
                                    .font(.system(size: 15))
                                    .fontWeight(.semibold)
                                    .frame(width: 40, height: 20)
                                    .background(
                                        LinearGradient(
                                            gradient: Gradient(colors: [Color.init(hex: "#956740"),Color.init(hex: "#D9AD89")]),
                                            startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/,
                                            endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/
                                        )
                                    )
                                    .cornerRadiusCustom(15, corners: [.bottomRight])
                            }
                            if list.vipType == 0 {
                                Text("优选")
                                    .foregroundColor(.init(hex: "#BD9A78"))
                                    .font(.system(size: 15))
                                    .fontWeight(.semibold)
                                    .frame(width: 50, height: 20)
                                    .background(
                                        LinearGradient(
                                            gradient: Gradient(colors: [Color.init(hex: "#131313"),Color.init(hex: "#4D4D4D")]),
                                            startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/,
                                            endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/
                                        )
                                    )
                                    .cornerRadiusCustom(15, corners: [.bottomRight])
                            }
                           
                        }
                        .cornerRadius(10)
                        .frame(width:UIScreen.main.bounds.width/3 - 30)
                        
                        Text(list.intro).lineLimit(2).font(.system(size: 12))
                            .foregroundColor(colorScheme == .light ? Color.black : .white)
                            .frame(maxWidth:.infinity,alignment:.leading)
                    
                        Text(list.albumUserNickName)
                            .font(.system(size: 12))
                            .lineLimit(1)
                            .foregroundColor(.gray)
                            
                    }
                    .cornerRadius(3)
                    .padding(4)
                }
                .buttonStyle(PlainButtonStyle())
                .navigationBarHidden(true)
            }
        }
        .padding(.horizontal,15)
        .onAppear {
            home.getGuessYouLike()
        }
    }
    
}
