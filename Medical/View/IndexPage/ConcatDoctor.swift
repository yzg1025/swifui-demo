//
//  ConcatDoctor.swift
//  Medical
//
//  Created by 于争光 on 2021/10/30.
//

import SwiftUI

struct ConcatDoctor: View {
    @Binding var closeCard: Bool
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Image(systemName: "xmark")
                    .offset(x: -20)
                    .font(.system(size: 18))
                    .onTapGesture {
                        withAnimation(.easeOut) {
                            closeCard.toggle()
                        }
                    }
            }
            HStack(){
                Image("avatar")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 5){
                    Label("Verified", systemImage: "checkmark.seal.fill")
                        .foregroundColor(Color.init(hex: "#32CD32"))
                    
                    Text("Dr.Jonathan Doe")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                    
                    Text("Gynacologist")
                        .foregroundColor(.gray)
                        .font(.system(size: 12))
                }

                Spacer()
            }
            .padding(.bottom,30)
            .padding(.horizontal,30)
            
            HStack(spacing: 20){
                RoundedRectangle(cornerRadius: 10)
                    .stroke(style: StrokeStyle(lineWidth:2))
                    .fill(Color.init(hex: "#000080"))
                    .overlay(
                        Button {
                            print("Chat Now")
                        } label: {
                            Label("Chat Now", systemImage: "ellipses.bubble.fill")
                                .foregroundColor(Color.init(hex: "#000080"))
                        }

                    )
                    .frame(width: 150, height: 40)
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.init(hex: "#000080"))
                    .overlay(
                        Button {
                            print("Appointment")
                        } label: {
                            Label("Appointment", systemImage: "briefcase.fill")
                                .foregroundColor(.white)
                        }
                        .buttonStyle(DefaultButtonStyle())
                    )
                    .frame(width: 150, height: 40)

            }
        }
        .frame(maxWidth:.infinity)
        .frame(height: 200)
        .background(Color.white)
        .cornerRadiusCustom(30, corners: [.topRight,.topLeft,.bottomLeft,.bottomRight])
        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: -10)
        .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .top)))
    }
}

