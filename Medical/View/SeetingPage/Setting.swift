//
//  Setting.swift
//  Medical
//
//  Created by 于争光 on 2021/12/17.
//

import SwiftUI
import PopupView

struct Setting: View {
    @State var colors = ["默认", "黑夜", "白天"]
    @AppStorage("colorIndex") var colorScheme: String = "默认"
    @State var popue: Bool = false
    var body: some View {
        List {
            Section{
                Picker(selection: $colorScheme, label: Text(colorScheme)) {
                    ForEach(colors,id:\.self) { item in
                        Text(item)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section{
                Button {
                    popue.toggle()
                } label: {
                    Text("退出登录").foregroundColor(.red.opacity(0.8))
                }
                .buttonStyle(PlainButtonStyle())

            }
        }
        .popup(isPresented: $popue) {
            PopupContent()
        }
        .listStyle(InsetGroupedListStyle())
    }
    
    func PopupContent() -> some View {
        VStack{
            Text("提示").font(.system(size: 23)).padding(.vertical,15)
            Text("是否退出当前用户").padding(.bottom,15)
            Divider()
            HStack(spacing: 0){
                Button {
                    popue = false
                } label: {
                    Text("取消").foregroundColor(.orange)
                }
                .frame(width: 150, height: 50, alignment: .center)
                .buttonStyle(PlainButtonStyle())
                
                Divider().frame(height: 50)
                
                Button {
                    print("2121")
                } label: {
                    Text("确定")
                        .foregroundColor(.orange)
                }
                .frame(width: 150, height: 50, alignment: .center)
                .buttonStyle(PlainButtonStyle())
            }
        }
        .frame(width: 300)
        .background(.ultraThinMaterial)
        .cornerRadius(5)
    }
}
