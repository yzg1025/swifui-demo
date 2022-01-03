//
//  UserInfoCell.swift
//  Medical
//
//  Created by 于争光 on 2021/12/17.
//

import SwiftUI

struct UserInfoCell: View {
    @EnvironmentObject var user: UsersModel
    @StateObject var login = LoginModel()
    let url = "https://s1.xmcdn.com/yx/ximalaya-web-static/last/dist/images/default_ad05575.png"
    let bg = "https://s1.xmcdn.com/yx/ximalaya-web-static/last/dist/images/bg_684491a.png"
    var body: some View {
        HStack{
            if user.getNormalDefult(key: "token") == nil {
                AsyncImage(url: URL(string: url)!){ imag in
                    imag.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                
                Button {
                    withAnimation {
                        login.isPresented.toggle()
                    }
                } label: {
                    VStack(alignment: .leading){
                        Text("登录/注册")
                            .fontWeight(.heavy)
                        Text("点击登录/注册")
                            .font(.system(size: 15))
                            .foregroundColor(.gray)
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }else{
                if user.getNormalDefult(key: "hearder") != nil {
                    AsyncImage(url: URL(string: user.getNormalDefult(key: "hearder") as! String)!){ imag in
                        imag.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                }
                
                
                VStack(alignment: .leading){
                    HStack{
                        Text(user.getNormalDefult(key: "nickname") as! String)
//                        Text(user.getNormalDefult(key: "phone") as! String)
                    }
                    .foregroundColor(.black)
                    Text("uid:\(user.getNormalDefult(key: "uid") as! Int)")
                        .foregroundColor(.gray)
                }
            }

        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            AsyncImage(url: URL(string: bg)!){ imag in
                imag.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(maxWidth: .infinity)
                .cornerRadius(10)
        )
        .padding()
        
        .fullScreenCover(isPresented: $login.isPresented){
            LoginOrRegister(isPresented: $login.isPresented)
                .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .top)))
        }
    }
}
