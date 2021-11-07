//
//  ChatItemCard.swift
//  Medical
//
//  Created by 于争光 on 2021/10/30.
//

import SwiftUI


struct ChatItemCard: View {
    var itemList: ChatCard
    var body: some View {
        VStack(alignment: .leading,spacing: 5){
            Text(itemList.chatId)
                .foregroundColor(.red)

            Text(itemList.chatDesc)
                .font(.system(size: 20, weight: .bold, design: .monospaced))
            
            Text(itemList.chatName)
                .foregroundColor(.gray)
        }
        .frame(width: 300, height: 150)
        .background(Color.white)
        .overlay(
            Image(itemList.chatIamge)
               .resizable()
               .aspectRatio(contentMode: .fit)
               .opacity(0.5)
                .offset(x: 40)
            ,alignment: .trailing)
        .cornerRadius(10)
    }
}
