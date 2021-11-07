//
//  ContentView.swift
//  Medical
//
//  Created by 于争光 on 2021/10/3.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack {
            Index()
        }
    }
}








struct DemoShape: Shape {
    func path(in rect: CGRect) -> Path {
        return Path{ path in
            path.move(to: CGPoint(x: rect.width / 2, y: 0))
            path.addLine(to: CGPoint(x: rect.maxX / 2, y: rect.maxY / 2))
            path.addLine(to: CGPoint(x: 2*rect.maxX / 2, y: rect.maxY / 3))
        }
    }
}

struct BreakHeart: View {
    @State var fillColor: Bool = true
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View{
        CustomShape()
            .fill(Color.red)
            .frame(width: 300, height: 300)
            .scaleEffect(0.2)
            .rotationEffect(.degrees(-45))
            .overlay(
                CustomShape()
                    .fill(Color.orange)
                    .scaleEffect(fillColor ? 0 : 0.15)
                    .rotationEffect(.degrees(-45))
                    .overlay(
                        CustomShape()
                            .fill(Color.green)
                            .scaleEffect(fillColor ? 0 : 0.10)
                            .rotationEffect(.degrees(-45))
                            .overlay(
                                Text("666")
                                    .foregroundColor(.white)
                                    .offset(y: -10)
                                    .scaleEffect(fillColor ? 0 : 1)
                                    .onReceive(timer, perform: { _ in
                                        withAnimation(.spring()) {
                                            fillColor.toggle()
                                        }
                                    })
                            )
                    )
            )
    }
}


struct CustomShape: Shape {
    func path(in rect: CGRect) -> Path {
       return Path{ path in
          path.addPath(Rectangle().path(in: rect))
          let circleRectLeft = CGRect(x: 0, y: -(rect.height / 2), width: rect.width, height: rect.height)
          
          path.addPath(Circle().path(in: circleRectLeft))
          
          let circleRectRight = CGRect(x: (rect.width / 2), y: 0, width: rect.width, height: rect.height)
          
          path.addPath(Circle().path(in: circleRectRight))
        }
    }
}

struct CustomModifier: ViewModifier {
    
    var bgcolor: Color
    
    init(bgcolor: Color){
        self.bgcolor = bgcolor
    }
    
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .frame(maxWidth: .infinity)
            .frame(height: 40)
            .foregroundColor(Color.white)
            .background(bgcolor)
            .cornerRadius(5)
            .padding(.vertical,10)
            .padding(.horizontal,10)
    }
}

extension View{
    func getView(bgcolor: Color) -> some View {
        modifier(CustomModifier(bgcolor: bgcolor))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
