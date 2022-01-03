//
//  SeachButton.swift
//  Medical
//
//  Created by 于争光 on 2021/12/18.
//

import SwiftUI

struct SeachButton: View {
    @State var pushpage: Bool = false
    var body: some View {
        VStack{
            NavigationLink(destination:SearchPage().navigationBarHidden(true),isActive: $pushpage){}
            HStack{
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.black)
                Text("索搜你所感兴趣")
                    .foregroundColor(.init(hex: "#B9B9C0"))
                    
                Spacer()
            }
            .padding(.leading,15)
            .frame(maxWidth: .infinity)
            .frame(height: 40)
            .background(Color.white)
            .cornerRadius(5)
            .padding(.horizontal,15)
            .onTapGesture {
                DispatchQueue.main.async {
                    pushpage.toggle()
                }
            }
        }
    }
}
