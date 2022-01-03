//
//  TabTagCell.swift
//  Medical
//
//  Created by 于争光 on 2021/12/12.
//

import SwiftUI

struct TabTagCell: View {
    @EnvironmentObject var home: HomeModels
    var body: some View {
        LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 4),spacing: 5) {
            ForEach(home.tabLists,id:\.groupId) { item in
                Text(item.groupName)
                    .font(.callout)
                    .frame(width: 80, height: 80)
                    .cornerRadius(5)
                    .overlay(
                        Text(item.channelName.uppercased())
                            .foregroundStyle(
                                .linearGradient(
                                    Gradient(colors: [Color.red.opacity(0.3),Color.blue.opacity(0.3)]),
                                    startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/,
                                    endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/
                                )
                            )
                            .font(.system(size: 20))
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.linearGradient(
                                Gradient(colors: [Color.red.opacity(0.1),Color.blue.opacity(0.1)]),
                                startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/,
                                endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/
                            ))
                    )
            }
        }
        .padding(.horizontal,10)
        .onAppear {
            home.tabList()
        }
    }
}

