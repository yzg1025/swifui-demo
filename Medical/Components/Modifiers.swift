//
//  Modifiers.swift
//  Medical
//
//  Created by 于争光 on 2021/12/15.
//

import SwiftUI

struct MaterialEffect: UIViewRepresentable {
    var style: UIBlurEffect.Style
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        print("232")
    }
}

struct BulerEffect: ViewModifier {
    func body(content: Content) -> some View {
        content.background(MaterialEffect(style: .systemChromeMaterial))
    }
}

extension View{
    func bulerEffect() -> some View {
        modifier(BulerEffect())
    }
}

struct CornerShape: Shape {
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
        clipShape(CornerShape(radius: radius, corners: corners) )
    }
}

// 页面滚动的offset
struct OffSetView: ViewModifier {
    func body(content: Content) -> some View {
        content.background(
            GeometryReader {
                Color.clear.preference(key: ViewOffsetKey.self,
                    value: -$0.frame(in: .named("scroll")).origin.y)
            }
        )
    }
}
extension View{
    func pageOffset() -> some View {
       modifier(OffSetView())
    }
}
