//
//  Login.swift
//  Medical
//
//  Created by 于争光 on 2021/10/16.
//

import SwiftUI

struct LoginOrRegister: View {
    @StateObject var login = LoginModel()
    @Binding var isPresented: Bool
    @State var phone: String = ""
    @State var password: String = ""
    @State var nickname: String = ""
    @State var isRegister: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            Image(systemName: "arrow.left")
                .font(.system(size: 25))
                .padding(.top,20)
                .padding(.bottom,30)
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        isPresented.toggle()
                    }
                }
            
            GeometryReader{ proxy in
                VStack(alignment: .leading){
                    VStack(alignment: .leading,spacing: 15){
                        Text("你好,")
                            .font(.system(size: 35))
                        HStack{
                            Text("欢迎来到HomeLeft,立即")
                            Text(!isRegister ? "注册" : "登录")
                                .foregroundColor(.orange)
                                .onTapGesture {
                                    withAnimation {
                                        isRegister.toggle()
                                    }
                                }
                        }
                        .font(.system(size: 23))
                    }
                    .padding(.bottom,50)
                    
                    ZStack(alignment:.bottom){
                        TextField("请输入用户名/手机号/邮箱", text: $phone)
                            .font(.system(size: 20))
                            .frame(height: 50)
                            .frame(maxWidth:.infinity)
                        Divider()
                    }
                    .padding(.bottom,20)
                    
                    if isRegister {
                        ZStack(alignment:.bottom){
                            TextField("请输入昵称", text:$nickname)
                                .font(.system(size: 20))
                                .frame(height: 50)
                                .frame(maxWidth:.infinity)
                            Divider()
                        }
                        .padding(.bottom,20)
                    }
                    
                    ZStack(alignment:.bottom){
                        SecureField("请输入密码", text: $password)
                            .font(.system(size: 20))
                            .frame(height: 50)
                            .frame(maxWidth:.infinity)
                        Divider()
                    }
                    
                    HStack{
                        Text("\(isRegister ? "注册" : "登录")遇到问题,反馈？")
                            .font(.system(size: 20))
                            .foregroundColor(.orange)
                        Spacer()
                        
                        Button {
                            if !isRegister {
                                login.loginPhone(phone: phone, password: password)
                            }
                            isPresented.toggle()
                        } label: {
                            Text(isRegister ? "注册" : "登录")
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                        }
                        .frame(width: 100, height: 50)
                        .background((phone == "" && password == "") ? Color.gray : Color.orange)
                        .disabled(phone == "" && password == "")
                        .cornerRadius(25)
                    }
                    .padding(.top,50)
                    
                    
                    Spacer()
                    
                  

                }
                .frame(width:proxy.size.width , height: proxy.size.height)
                
            }
        }
        .padding(20)
        .ignoresSafeArea(.all)
    }
}
