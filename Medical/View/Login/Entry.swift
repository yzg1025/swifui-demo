//
//  Entry.swift
//  Medical
//
//  Created by 于争光 on 2021/10/16.
//

import SwiftUI

struct Entry: View {

    @EnvironmentObject var logins: LoginModel
    var body: some View {
        VStack(alignment: .center){
            HStack{
                Image(systemName: "arrow.down")
                    .font(.system(size: 20))

                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            logins.showLoginPage.toggle()
                        }
                    }
                Spacer()
            }
            Image("login")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 300)
            
            VStack{
                Text("Enterprise team")
                Text("collabotation")
            }
            .font(.system(size: 30, weight: .bold))
            
            VStack(spacing: 5){
                Text("bring together your files, your tools.")
                Text("projects and people.including a new")
                Text(" mobile and desktop apploction")
            }
            .padding(.top,15)
            .font(.system(size: 15))
            .foregroundColor(.gray)
            
            Spacer()
            
            HStack{
                
                ForEach(["Register","Login"],id:\.self){ item in
                    Button {
                        withAnimation(.easeInOut) {
                            logins.enterType = item
                            logins.isPresented.toggle()
                        }
                    } label: {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(logins.enterType == item ? Color.white : Color.clear)
                          .overlay(
                            Text(item)
                          )
                          .padding(.horizontal,5)
                    }
                    .frame(height: 40)
                    
                }

            }
            .frame(height: 50)
            .foregroundColor(.black)
            .background(Color.init(hex: "#EBEBEB"))
            .cornerRadius(5)
      
        }
        .padding(.horizontal,15)
        .fullScreenCover(isPresented: $logins.isPresented){
            LoginOrRegister(isPresented: $logins.isPresented, type: $logins.enterType)
                .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .top)))
        }
     
    }
}

