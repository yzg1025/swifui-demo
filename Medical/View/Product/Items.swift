//
//  Items.swift
//  Medical
//
//  Created by 于争光 on 2021/11/6.
//

import SwiftUI

struct Items: View {
    @Environment(\.presentationMode) var presentationMode
    var productItem: ProductItem
    
    var body: some View {
        ZStack(alignment: .top){
            Color.init(hex: "#F1F4F9")
                .ignoresSafeArea()
             
            Color.white
            .frame(height: 350)
            .cornerRadiusCustom(60, corners: [.bottomLeft])
            .ignoresSafeArea()
            VStack{
                HStack{
                    Image(systemName: "arrow.left")
                        .font(.system(size: 18))
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                    Spacer()
                    Image(systemName: "cart.fill")
                        .font(.system(size: 18))
                }
                .padding(.horizontal,15)
                .padding(.bottom,5)
                GeometryReader{ proxy in
                    VStack{
                        ZStack(alignment: .center){
                            Image(productItem.productImage)
                                .resizable()
                                .frame(height: 350)
                                .offset(x: -100)
                            
                            VStack(alignment: .leading){
                                Text("MEDINE NAME")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                                Text(productItem.productDesc)
                                    .fontWeight(.bold)
                                    .foregroundColor(.init(hex: "#3F3455"))
                                    .padding(.bottom,10)
                                    .frame(width: 200,alignment: .leading)
                                    .lineLimit(1)
                                
                                Text("QUANTITY")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                                Text("30mg")
                                    .fontWeight(.bold)
                                    .foregroundColor(.init(hex: "#3F3455"))
                                    .padding(.bottom,10)
                                
                                Text("PRICE")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                                Text(productItem.productPrice)
                                    .fontWeight(.bold)
                                    .foregroundColor(.init(hex: "#3F3455"))
                                    .padding(.bottom,10)
                            }
                            .offset(x: 50)
                        }
                        
                        VStack(alignment: .leading){
                            Text("NOTE")
                                .padding(.bottom,3)
                                .foregroundColor(.gray)
                            Text("4 Drops ever 4-6 Hours Daily. No more than 20 Drops")
                                .foregroundColor(.init(hex: "#3F3455"))
                                .padding(.bottom,20)
                            
                            Text("DESCRIPTION")
                                .padding(.bottom,3)
                                .foregroundColor(.gray)
                            Text("This oil is one of my mast beloved must-haves. After searing for an inexpensive rosehip oil(I persomally don't belived on playing over $20 for a single oil) I finall decided to try this one end i'm so glod i did It's great fro mosturizing nourrishing my skin yet is still fells lightweight")
                                .font(.system(size: 16))
                            
                            Button {
                                print("add cart")
                            } label: {
                                Text("Add to Card | $\(productItem.productPrice)")
                            }
                            .frame(width: proxy.size.width - 45, height: 45)
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .padding(.top,20)

                        }
                        .padding(.horizontal,25)
                    }
                }
            }
        }
        .onAppear {
            print("productItem",productItem)
        }
    }
}


