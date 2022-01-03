//
//  TabViewList.swift
//  Medical
//
//  Created by 于争光 on 2021/12/12.
//

import SwiftUI

struct TabViewList: View {
    @EnvironmentObject var home: HomeModels
    @Environment(\.colorScheme) var colorScheme
    @State var current:String = "推荐"
    @Namespace var id
    var body: some View {
        ScrollView(.horizontal,showsIndicators: false){
            HStack{
                ForEach(home.tabViewLists,id:\.id) { item in
                    Button {
                        withAnimation {
                            current = item.name
                        }
                    } label: {
                        VStack{
                            Text(item.name)
                                .font(.callout)
                                .fontWeight(item.name == current ? .heavy : .none)
                                .scaleEffect(item.name == current ? 1.2 : 1)
                                .foregroundColor(item.name == current ? .orange : (colorScheme == .light ? Color.black : .white))
                               
                            if item.name == current {
                                RoundedRectangle(cornerRadius: 2)
                                    .fill(.orange)
                                    .frame(height: 2)
                                    .matchedGeometryEffect(id: "TaB", in: id)
                            }else{
                                EmptyView()
                            }
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.leading,8)
                }
            }
            .padding()
        }
        .onAppear {
            home.tabViewList()
        }
    }
}

