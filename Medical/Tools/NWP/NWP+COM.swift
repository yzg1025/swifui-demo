//
//  NWP.swift
//  Medical
//
//  Created by 于争光 on 2021/10/3.
//

import SwiftUI

enum NwpType{
    case wait
    case alert
}

struct NWP<Content: View>: View {
    let type: NwpType
    @ViewBuilder let content: Content
    var body: some View {
        if type == .wait{
            content
                .padding(.horizontal,12)
                .padding(16)
                .background(
                  RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.white)
                    .shadow(color:.black.opacity(0.15), radius: 12, x: 0, y: 5)
                )

        }else{
            content
                .padding(.horizontal,12)
                .padding(16)
                .background(
                  Capsule()
                    .foregroundColor(.white)
                    .shadow(color:.black.opacity(0.15), radius: 12, x: 0, y: 5)
                )

        }
    }
}

extension View{
    // 等待弹窗
    func with<Content: View>(showWait: Binding<Bool>,@ViewBuilder content:()-> Content) -> some View {
        ZStack{
            self
            
            if showWait.wrappedValue {
                NWP(type: .wait, content: content)
                    .zIndex(1)
            }
        }
    }
    
    func alertMsg<Content: View>(isPresent: Binding<Bool>,@ViewBuilder content:()-> Content) -> some View {
        ZStack(alignment: .top){
            self
            
            if isPresent.wrappedValue {
                NWP(type: .alert, content: content)
                    .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
                    .onAppear(perform: {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation {
                                isPresent.wrappedValue.toggle()
                            }
                        }
                    })
                    .zIndex(1)
            }
        }
    }
    
}

// Loading Demo
struct Loading: View {
    @StateObject var nwpState: NWPState = NWPState()
    var body: some View{
        ZStack(alignment: .top){
            NavigationView{
                Button{
                    nwpState.showWaits(message: "正在请求,请稍等")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                        nwpState.showWait = false
                        nwpState.alertMsg(message: "更新成功", systemImage: "text.bubble.fill")
                    }
                } label:{
                    Text("show")
                }
            }
            .with(showWait: $nwpState.showWait) {
                VStack{
                    //                    AnimatedImage(name: "loading.gif")
                    //                        .resizable()
                    //                        .aspectRatio(contentMode: .fill)
                    //                        .frame(width: 100, height: 100)
                    ProgressView()
                        .padding(10)
                        .foregroundColor(Color.black)
                    Text(nwpState.message)
                        .font(.system(size: 14, weight: .semibold))
                }
            }
            .alertMsg(isPresent:$nwpState.isPresent){
                Label(nwpState.message,systemImage: nwpState.systemImage)
            }
        }
        
    }
}
