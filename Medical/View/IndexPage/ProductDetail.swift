//
//  ProductDetail.swift
//  Medical
//
//  Created by 于争光 on 2021/10/31.
//

import SwiftUI

struct ProductDetail: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var productList: [ProductItem] = ProductList
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.init(hex: "#F1F4F9")
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
                    .padding(.vertical,15)
                    GeometryReader{ proxy in
                        VStack{
                            Text("Medicines&\nHealth Products")
                                .font(.system(size: 30, weight: .bold, design: .monospaced))
                                .frame(maxWidth: .infinity,alignment: .leading)
                            FlowLayoutView(list: productList, column: 2, itemSpacingH: 15, itemSpacingV: 15){ list in
                                NavigationLink(
                                    destination: Items(productItem: list)
                                            .navigationBarHidden(true)
                                ){
                                    ProductItems(productItem: list)
                                }
                                .navigationBarHidden(true)
                            }
                        }
                    }
                }
                .padding(.horizontal,20)
            }
        }
    }
}

struct ProductDetail_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetail()
    }
}
