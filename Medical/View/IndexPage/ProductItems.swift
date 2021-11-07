//
//  ProductItems.swift
//  Medical
//
//  Created by 于争光 on 2021/10/31.
//

import SwiftUI

struct ProductItems: View {
    var productItem: ProductItem
    var body: some View {
        ZStack(alignment: .topTrailing){
            Image(systemName: "suit.heart.fill")
                .padding(.top,20)
                .padding(.trailing,20)
                .foregroundColor(productItem.isLike ? .red : .gray)
            VStack(alignment: .leading){
                Image(productItem.productImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Text(productItem.productName)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                Text(productItem.productDesc)
                    .font(.system(size: 16))
                    .foregroundColor(.init(hex: "#3F3455"))
                
                HStack{
                    Text("$\(productItem.productPrice)")
                    Spacer()
                    Text("+Add")
                }
                .padding(.top,10)
                .font(.system(size: 15))
                .foregroundColor(.init(hex: "#3F3455"))
            }
            .padding()
        }
        .background(Color.white)
        .cornerRadius(10)
    }
}

struct ProductItems_Previews: PreviewProvider {
    static var previews: some View {
        ProductItems(productItem: ProductList.first!)
    }
}
