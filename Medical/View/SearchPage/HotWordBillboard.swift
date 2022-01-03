//
//  HotWordBillboard.swift
//  Medical
//
//  Created by 于争光 on 2021/12/14.
//

import SwiftUI

struct HotWordBillboardItem: View{
    @EnvironmentObject var search: SearchModels
    @Environment(\.colorScheme) var colorScheme
    @Binding var current: Int
    var body: some View{
        VStack{
            ForEach(search.hotWord.prefix(10),id:\.self){ item in
                HStack{
                    if (getIndex(word: item.word) + 1) > 3 {
                        Text("\(getIndex(word:item.word) + 1)")
                            .foregroundColor(Color.init(hex: "#dabda6"))
                    }else {
                        ZStack{
                            Image(systemName: "flame.fill")
                                .foregroundColor(.orange)
                            Text("\(getIndex(word:item.word) + 1)")
                                .foregroundColor(.red)
                        }
                    }
                    Text(item.word)
                        .font(.system(size: 18))
                    Spacer()
                    Text("\(item.score)")
                }
                .padding(.horizontal,10)
                .padding(.vertical,10)
            }
            Divider()
            Text("查看更多 >").padding()
        }
        .frame(maxWidth:.infinity)
        .background(colorScheme == .light ? Color.white : Color.init(hex: "#171717").opacity(0.5))
        .padding(.vertical,15)
        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
        .cornerRadius(20)
        .onAppear {
            search.hotWordBillboard(id: current)
        }
    }
    
    func getIndex(word: String) -> Int {
        return search.hotWord.firstIndex { item in
            return item.word == word
         } ?? 0
    }

}
