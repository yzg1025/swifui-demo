//
//  AlbumRankView.swift
//  Medical
//
//  Created by 于争光 on 2021/12/12.
//

import SwiftUI

struct AlbumRankView: View {
    @EnvironmentObject var home: HomeModels
    @StateObject var simpleAlbum = AlbumSimpleInfo()
    var allicon = "https://s1.xmcdn.com/yx/ximalaya-web-static/last/dist/images/all_bfd2513.png"
    var prefixUrl = "https://imagev2.xmcdn.com/"
    var body: some View {
        VStack{
            ForEach(home.albumRanks,id:\.rankResult.title){ item in
                Label(title: item.rankResult.title)
                ForEach(item.albums,id:\.id) { a in
                    HStack{
                        NavigationLink(
                            destination:SimpleAlbumView(albumRank: a)
                                .environmentObject(simpleAlbum)
                        ) {
                            AsyncImage(url: URL(string:prefixUrl + a.cover)!){ image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 80, height: 80)
                            .cornerRadius(5)
                            
                            VStack(alignment: .leading){
                                HStack{
                                    if a.tagStr == "" {
                                        EmptyView()
                                    }else{
                                        Text(a.tagStr)
                                            .foregroundColor(.orange)
                                            .font(.system(size: 14))
                                            .overlay(
                                              RoundedRectangle(cornerRadius: 2)
                                                .stroke(.orange)
                                                .frame(width: 40, height: 18)
                                            )
                                            .padding(.horizontal,5)
                                    }
                                   
                                    Text(a.albumTitle)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .lineLimit(1)
                                }
                                .padding(.bottom,3)
                                Text(a.anchorName)
                                    .font(.system(size: 16))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundColor(.gray)
                                    .lineLimit(1)
                                HStack{
                                    Image(systemName: "play")
                                    Text("\(a.playCount)")
                                }
                                .font(.system(size: 16))
                                .foregroundColor(.gray)
                                .padding(.top,3)
                            }
                            .frame(maxWidth:.infinity)
                        }
                        .buttonStyle(PlainButtonStyle())
                      
                    }
                    Divider()
                        .frame(width: UIScreen.main.bounds.width - 80)
                }
            }
        }
        .padding(.horizontal,10)
        .padding(.bottom,100)
        .onAppear {
            home.getRankAlbum(rankIds: "47,70,100", pageNo: 1, pageSize: 10)
        }
    }
    
    func Label(title: String) -> some View {
        HStack {
            Text(title)
                .fontWeight(.heavy)
                .font(.system(size: 22))
                .frame(height: 25)
                .overlay(
                  RoundedRectangle(cornerRadius: 2)
                    .fill( .linearGradient(
                        Gradient(colors: [Color.red.opacity(0.3),Color.blue.opacity(0.3)]),
                        startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/,
                        endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/
                    ))
                    .frame(height: 15)
                    .offset(x: 0, y: 5)
                )
            Spacer()
            NavigationLink(destination: Text("全部")) {
                AsyncImage(url: URL(string: allicon)!){ image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width:40,height: 19,alignment: .trailing)
            }
        }
    }
}

