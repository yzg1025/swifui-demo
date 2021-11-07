//
//  Index.swift
//  Medical
//
//  Created by 于争光 on 2021/10/24.
//

import SwiftUI

struct Index: View {
    
    @EnvironmentObject var logins: LoginModel
    @EnvironmentObject var users: UsersModel
    var cates: [Category] = CategoryList
    var chat: [ChatCard] = ChatList
    
    @State var showDoctorCard: Bool = false
    
    var body: some View {
        NavigationView{
            ZStack(alignment: .bottom){
                Color.init(hex: "#F1F4F9").ignoresSafeArea()
                VStack{
                    
                    Top
                    Text("Find your Desired \nDoctor.")
                        .font(.system(size: 25, weight: .medium,design: .monospaced))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom,10)
                        .padding(.horizontal,15)
                    ScrollView(.vertical){
                        VStack{
                            // 索搜按钮
                            SearchBtn
                            
                            LookView
                            
                            FootControl
                            
                            ChatDoctor
                            
                            Spacer()
                        }
                    }
                }
                .fullScreenCover(isPresented: $logins.showLoginPage) {
                    Entry()
                }
                
                if showDoctorCard{
                    ConcatDoctor(closeCard: $showDoctorCard)
                }
            }
        }
       
    }
    
    var Top: some View{
        HStack{
            Image(systemName: "text.justifyleft")
                .font(.system(size: 16, weight: .bold))
            Text("(\(users.places))")
            Spacer()
            Button {
                logins.showLoginPage.toggle()
            } label: {
                Image("avatar")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
            }
            
        }
        .padding(.horizontal,15)
    }
    
    var SearchBtn: some View{
        NavigationLink(destination:
                        SearchPage()
                        .navigationBarHidden(true)
        ){
            HStack{
               Image(systemName: "magnifyingglass")
                   .font(.system(size: 18, weight: .bold))
                   .foregroundColor(.black)
               Text("Search something here...")
                   .foregroundColor(.init(hex: "#B9B9C0"))
               Spacer()
           }
           .padding(.leading,15)
        }
        .frame(maxWidth: .infinity)
        .frame( height: 40)
        .background(Color.white)
        .padding(.bottom,10)
        .padding(.horizontal,15)
        .cornerRadius(5)

    }
    
    var LookView: some View{
        VStack(alignment: .leading, spacing: 15){
            Text("What are you looking fro ?")
                .padding(.leading,15)
            ScrollView(.horizontal,showsIndicators: false){
                HStack{
                    ForEach(cates,id:\.cateId){ item in
                        NavigationLink(
                            destination: ProductDetail()
                                .navigationBarHidden(true)
                                .navigationBarBackButtonHidden(true)
                        ){
                            LookViewCard(itemList: item)
                                .padding(.leading,15)
                        }
                        .navigationBarHidden(true)
                    }
                }
            }
            
        }
    }
    
    // 饮食控制
    var FootControl: some View{
        HStack{
            VStack(alignment:.leading){
                Text("Foot Control")
                    .font(.system(size: 16, weight: .black, design: .rounded))
                Text("Your food control Summary")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                
                HStack{
                    HStack{
                        Image("fruish")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("Fruits")
                            .font(.system(size: 14))
                    }
                    .padding(.trailing,15)
                    HStack{
                        Image("sc")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("Vegetables")
                            .font(.system(size: 14))
                    }
                }
                ZStack(alignment: .trailing){
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.red)
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.green)
                        .frame(width: 100)
                }
                .frame(height: 12)
            }
            Divider()
                .frame(width: 2, height: 50)
                .padding(.horizontal,20)
                
            VStack{
                Text("12")
                    .font(.system(size: 30, weight:.bold))
                Text("DAYS")
                    .foregroundColor(.gray)
            }
        }
        .padding(15)
        .background(Color.white)
        .cornerRadius(5)
        .padding(.horizontal,15)
    }
    
    
    var ChatDoctor: some View{
        VStack{
            Text("Chat with Top Doctors")
                .frame(maxWidth:.infinity,alignment: .leading)
                .padding(.leading,15)
            ScrollView(.horizontal,showsIndicators: false){
                HStack{
                    ForEach(chat,id:\.chatId){ item in
                        Button {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                showDoctorCard.toggle()
                            }
                        } label: {
                            ChatItemCard(itemList: item)
                                .padding(.leading,15)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            
        }
    }
    
}


