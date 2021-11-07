//
//  Login.swift
//  Medical
//
//  Created by 于争光 on 2021/10/16.
//

import SwiftUI

struct LoginOrRegister: View {
    @Binding var isPresented: Bool
    @State var phone: String = ""
    @State var password: String = ""
    
    @Binding var type: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            Image(systemName: "arrow.turn.up.left")
                .font(.system(size: 20))
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
                        Text("Let's \(type == "Login" ? "sign your in" : type)")
                            .font(.system(size: 30, weight: .bold))
                        Text("Welecome back")
                        Text("You've been")
                    }
                    .font(.system(size: 30))
                    
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.init(hex: "#EBEBEB"))
                        .overlay(
                            TextField("Phone emael or username", text: $phone)
                                .padding(.leading)
                        )
                        .frame(height: 50)
                        .padding(.vertical,10)
                    
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.init(hex: "#EBEBEB"))
                        .overlay(
                            SecureField("Password", text: $password)
                                .padding(.leading)                      )
                        .frame(height: 50)

                    
                    Spacer()
                    
                    HStack(alignment: .center){
                        Text("Don't have an account")
                        Text(type)
                            .font(.system(size: 16,weight: .bold))
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    type = type == "Login" ? "Register" : "Login"
                                }
                            }
                    }
                    .frame(maxWidth: .infinity)
                    
                    Button {
                        print("3232")
                    } label: {
                        Text(type == "Login" ? "Sign in" : "Register")
                    }
                    .customButtom(bgColor: Color.black)

                }
                .frame(width:proxy.size.width , height: proxy.size.height)
            }
        }
        .padding(.horizontal,15)
        .padding(.vertical,20)
        .ignoresSafeArea(.all)
        .onAppear {
            print("311",type)
            
        }
    }
}

//struct LoginOrRegister_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginOrRegister(isPresented: $isPresented, type: "Login")
//    }
//}
