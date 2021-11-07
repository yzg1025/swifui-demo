//
//  TabBar.swift
//  Medical
//
//  Created by 于争光 on 2021/10/4.
//

import SwiftUI

struct TabBar: View {
    @StateObject var current: UsersModel = UsersModel()
    
    init(){
        UITabBar.appearance().isHidden = true
    }
    
    @Namespace private var animation
    
    var body: some View {
        TabView(selection: $current.activeBar){
            Text("Home")
                .tag(Tab.Home)
            
            Text("Search")
                .tag(Tab.Search)
            
            Text("Notifications")
                .tag(Tab.Notifications)
            
            Text("Account")
                .tag(Tab.Account)
        }
        .overlay(
            HStack{
                ForEach(Tab.allCases,id: \.rawValue){ tab in
                    TabButton(tab: tab)
                }
            }
            .padding(.vertical)
                .padding(.bottom,getSafeArea().bottom == 0 ? 10 : (getSafeArea().bottom - 10))
                .background(
                    MaterialEffect(style: .systemChromeMaterial)
                        .clipShape(
                            BottomCurve(currentXValue: current.currentXValue)
                               
                        )
                        
                )
            ,alignment: .bottom
        )
//        .preferredColorScheme(.dark)
        .ignoresSafeArea(.all,edges: .bottom)
    }
    
    @ViewBuilder
    func TabButton(tab: Tab) -> some View {
        GeometryReader{ proxy in
            Button {
                withAnimation(.spring()) {
                    current.activeBar = tab
                    current.currentXValue = proxy.frame(in: .global).midX
                }
            } label: {
                Image(systemName: tab.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .frame(maxWidth:.infinity)
                    .foregroundColor(.black)
                    .padding(current.activeBar == tab ? 15 : 0)
                    .background(
                        ZStack{
                            if current.activeBar == tab {
                                MaterialEffect(style: .systemChromeMaterial)
                                    .clipShape(Circle())
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                            }
                        }
                    )
                    .contentShape(Rectangle())
                    .offset(y:current.activeBar == tab ? -50 : 0)
            }
            .onAppear {
                if tab == Tab.allCases.first && current.currentXValue == 0 {
                    current.currentXValue = proxy.frame(in: .global).midX
                }
            }
        }
        .frame(height: 30)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}


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

extension View{
    func getSafeArea() -> UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{ return .zero }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else{ return .zero }
        
        return safeArea
    }
}


struct BottomCurve: Shape {
    var currentXValue: CGFloat
    
    var animatableData: CGFloat{
        get{ currentXValue }
        set{ currentXValue = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        return Path{ path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            let mid = currentXValue
            
            path.move(to: CGPoint(x: mid - 50, y: 0))
            let to1 = CGPoint(x: mid, y: 35)
            let control1 = CGPoint(x: mid - 25, y: 0)
            let control2 = CGPoint(x: mid - 25, y: 35)
            
            path.addCurve(to: to1, control1: control1, control2: control2)
            
            let to2 = CGPoint(x:mid + 50, y: 0)
            let control3 = CGPoint(x: mid + 25, y: 35)
            let control4 = CGPoint(x: mid + 25, y: 0)
            
            path.addCurve(to: to2, control1: control3, control2: control4)
            
        }
    }
}
