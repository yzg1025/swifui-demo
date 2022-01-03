//
//  SwiftUIView.swift
//  Medical
//
//  Created by 于争光 on 2021/12/17.
//

import SwiftUI
import Introspect

struct MyPage: View {
    @StateObject var users = UsersModel()
    @State var pageoffset: CGFloat = .zero
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView(showsIndicators: false){
                BarItem().opacity(pageoffset > -30 ? 0 : 1)
                VStack{
                    UserInfoCell()
                        .environmentObject(users)
                }
                .pageOffset()
                .onPreferenceChange(ViewOffsetKey.self) { pageoffset = $0 }
            }
            
            if pageoffset > 0 {
                BarItem()
                    .background(.ultraThinMaterial) 
            }
        }
        .coordinateSpace(name: "scroll")
    }
    
    
    func BarItem() -> some View {
        HStack{
            Spacer()
            Text("我的(\(users.places))")
            Spacer()
            NavigationLink(destination: Setting()){
                Image(systemName: "gear").navigationTitle("我的").navigationBarTitleDisplayMode(.inline)
                    .foregroundColor(.orange)
            }
        }
        .padding(.horizontal,15)
        .frame(maxWidth: .infinity)
        .frame(height: 40)
    }
}
