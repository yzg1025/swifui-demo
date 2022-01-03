//
//  AnchorBasicInfoCell.swift
//  Medical
//
//  Created by 于争光 on 2022/1/3.
//

import SwiftUI

struct AnchorBasicInfoCell: View {
    var info: AnchorBasicInfo
    @StateObject var simpleAlbum = AlbumSimpleInfo()
    var body: some View {
        VStack(alignment: .leading){
            Text("主播介绍").font(.title3)
            HStack{
                ZStack(alignment: .bottomTrailing){
                    AsyncImage(url: URL(string:"http:" + info.cover)!){ imag in
                        imag.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    
                    if info.isVip {
                        Text("VIP").foregroundColor(.red).font(.callout)
                    }
                }
                VStack(alignment: .leading){
                    HStack{
                        Text(info.nickName)
                        HStack(spacing: 0){
                            Image(systemName: "music.mic")
                                .foregroundColor(Color.init(hex: "#D695BA"))
                                .font(.callout)
                                .offset(x: 0, y: -3)
                                .padding(0)
                            Text("LV\(info.anchorGrade)")
                                .foregroundColor(Color.init(hex: "#853247"))
                                .font(.caption)
                        }
                        .frame(width: 50, height: 20)
                        .background(Color.init(hex: "#373B40"))
                        .cornerRadius(10)
                        
                    }
                    Text("已被\(info.fansCount)人关注")
                        .foregroundColor(Color.init(hex: "#5C5F71"))
                        .font(.footnote)
                        .padding(.top,3)
                }
                
                Spacer()
                
                HStack{
                    if !info.isFollow {
                        Image(systemName: "plus")
                    }
                    Text(info.isFollow ? "已关注" : "关注")
                }
                .frame(width: 80, height: 35)
                .background(Color.init(hex: "#373B40"))
                .cornerRadius(20)
                .onTapGesture {
                    simpleAlbum.followAnchor(uid: info.uid, follow: info.isFollow)
                }
            }
            .padding(.vertical,15)
            Text(info.personalSignature)
        }
        .foregroundColor(.white)
        .padding(.vertical,15)
    }
}
