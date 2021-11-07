//
//  LookViewCard.swift
//  Medical
//
//  Created by 于争光 on 2021/10/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct LookViewCard: View {
    var itemList: Category
    var body: some View {
        VStack{
            Text(itemList.cateName)
                .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .topLeading)
                .foregroundColor(.white)
                .padding(.leading,10)
                .padding(.top,10)
        }
        .frame(width: 120, height: 150)
        .background(Color.init(hex: itemList.cateBg))
        .overlay(
            Image(itemList.cateImage)
               .resizable()
               .aspectRatio(contentMode: .fit)
            ,alignment: .bottomTrailing)
        .cornerRadiusCustom(30, corners: [.topRight])
        .cornerRadius(10)
    }
}

struct LookViewShape: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadiusCustom(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(LookViewShape(radius: radius, corners: corners) )
    }
}

struct LookViewCard_Previews: PreviewProvider {
    static var previews: some View {
        LookViewCard(itemList: CategoryList.first!)
    }
}
