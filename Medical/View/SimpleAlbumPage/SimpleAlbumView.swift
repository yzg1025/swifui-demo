//
//  SimpleAlbumPage.swift
//  Medical
//
//  Created by 于争光 on 2022/1/2.
//

import SwiftUI
import UIKit
import PopupView

struct SimpleAlbumView: View {
    @EnvironmentObject var albumInfo: AlbumSimpleInfo
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    var albumRank: Album
    @State var show: Bool = false
    init(albumRank: Album) {
        self.albumRank = albumRank
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().tintColor = UIColor.white
    }
    
    var body: some View {
        VStack(alignment: .leading){
            ScrollView(.vertical,showsIndicators: false){
                if albumInfo.simpleInfo != nil  {
                    let info = albumInfo.simpleInfo.albumsimpleInfo
                    HStack{
                        AsyncImage(url: URL(string:"https:" + info.cover)!){ imag in
                            imag.resizable().aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 100, height: 100)
                        .cornerRadius(5)
                        
                        VStack{
                            HStack(alignment: .top){
                                Text(info.albumTitle)
                                    .font(.title2).foregroundColor(.white)
                                switch info.isFinished {
                                case "2":
                                    Tags(text: "完结")
                                default:
                                    EmptyView()
                                }
                            }
                            .frame(maxWidth:.infinity, alignment: .leading)
                            if info.tags != "" {
                                ScrollView(.horizontal,showsIndicators: false){
                                    HStack{
                                        ForEach(tagStrToArr(tags: info.tags),id:\.self) { item in
                                            TagStrToArrCell(text: item)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    HStack{
                        Statics(title: "评分", count: "8.7")
                        Spacer()
                        Statics(title: "播放量", count:FormetValue(val: info.playCount))
                        Spacer()
                        Statics(title: "订阅量", count: FormetValue(val:info.subscribeCount))
                        Spacer()
                        
                        Attention()
                    }
                    .padding(.vertical,15)
                
                    Text(info.recommendReason).font(.body).foregroundColor(.white)
                        .frame(maxWidth:.infinity, alignment: .leading)
                    
                    WebViewRoot(url: HtmlStr(richIntro: info.richIntro), isLink: true).frame(height: 300)
                    
                    if albumInfo.anchorInfo != nil {
                        AnchorBasicInfoCell(info: albumInfo.anchorInfo)
                    }
                    
                    Spacer()
                }
            }
            
        }
        .padding(.horizontal,15)
        .onAppear {
            albumInfo.getSimpleInfo(albumId: albumRank.id)
            albumInfo.getAnchorInfo(uid: albumRank.anchorUrl)
        }
        .background(Color.init(hex: "#242735"))
        .navigationTitle(Text(albumRank.albumTitle))
        .navigationBarTitleDisplayMode(.inline)
        .popup(isPresented: $show, type: .floater(), position: .bottom,dragToDismiss: true) {
            Tags(text: "3232")
        }
    }
    
    func tagStrToArr(tags: String) -> [String] {
        return tags.components(separatedBy: ",")
    }
    
    // 小说更新状态
    func Tags(text: String) -> some View {
        Text(text)
            .foregroundColor(.orange)
            .font(.system(size: 14))
            .overlay(
              RoundedRectangle(cornerRadius: 2)
                .stroke(.orange)
                .frame(width: 40, height: 25)
            )
            .padding(.horizontal,5)
            .padding(.top,5)
    }
    
    // 滑动tags
    func TagStrToArrCell(text: String) -> some View {
        Button {
            withAnimation {
               print("item")
            }
        } label: {
            HStack{
                Text(text)
                Image(systemName: "chevron.right")
            }
            .font(.footnote)
            .foregroundColor(.white)
        }
        .foregroundColor(colorScheme == .light ? Color.black : .white)
        .buttonStyle(PlainButtonStyle())
        .frame(height: 25)
        .frame(minWidth:50)
        .padding(5)
        .background(Color.init(hex: "#1D1E29"))
        .cornerRadius(2)
    }
    
    func Statics(title: String,count: String) -> some View {
        VStack{
            Text("\(count)")
                .font(.title3)
                .foregroundColor(.white)
            Text(title)
                .font(.footnote)
                .foregroundColor(Color.init(hex: "#5C5F71"))
        }
    }
    
    // 关注
    func Attention() -> some View {
        Button {
            show.toggle()
        } label: {
            HStack(spacing: 0){
                Image(systemName: "plus").foregroundColor(.black)
                Text("关注").foregroundColor(.black).padding(0)
            }
            .frame(width: 90,height: 35)
            .background(Color.white)
            .cornerRadius(20)
        }
        .buttonStyle(PlainButtonStyle())

    }
    
    func FormetValue(val: Int) -> String {
        if val <= 10000 {
            return "\(val)"
        }
        if val > 10000 && val <= 10000000 {
            return "\(val / 10000)万"
        }
        if val > 100000000 {
            return "\(val / 100000000)亿"
        }
        return ""
    }
    
    func HtmlStr(richIntro:String) -> String {
        let html1 = """
                   <html lang="en">
                   <head>
                     <meta charset="UTF-8">
                     <meta http-equiv="X-UA-Compatible" content="IE=edge">
                     <meta name="viewport" content="width=device-width, initial-scale=1.0">
                     <style>
                        img{ max-width: 100% !important }
                        body{ background: #242735 }
                        p{ color: #fff !important }
                        *{ padding:0; margin:0 }
                     </style>
                   </head>
                   <body>
                     
                   """
        let html2 = """
                    </body>
                    </html>
                    """
        return """
        \(html1)
        \(richIntro)
        \(html2)
        """
        
    }
}
