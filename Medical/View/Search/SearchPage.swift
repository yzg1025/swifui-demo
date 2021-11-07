//
//  SearchPage.swift
//  Medical
//
//  Created by 于争光 on 2021/10/31.
//

import SwiftUI

struct SearchPage: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var searchKey: String = ""
    var body: some View {
        ZStack{
            Color.init(hex: "#F1F4F9")
                .ignoresSafeArea()
            VStack{
                HStack{
                    Image(systemName: "arrow.left")
                        .font(.system(size: 20))
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                    Spacer()
                }
                .padding(.bottom,10)
                
                HStack{
                    HStack{
                        Image(systemName: "magnifyingglass")
                        TextField("Search", text: $searchKey,onCommit: {
                            print("121212",searchKey)
                            searchKey = ""
                        })
                            .keyboardType(.webSearch)
                    }
                    .padding(.leading,5)
                    .frame(height: 40)
                    .background(Color.white)
                    .cornerRadius(5)
                    
                    Text("取消")
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                }
               
                
                GeometryReader{ proxy in
                    Text("搜索历史")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal,15)
        }
    }
}
//
//struct SearchPage_Previews: PreviewProvider {
//    static var previews: some View {
//        if #available(iOS 15.0, *) {
//            SearchPage()
//        } else {
//            // Fallback on earlier versions
//        }
//    }
//}
