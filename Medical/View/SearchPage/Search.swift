//
//  Search.swift
//  Medical
//
//  Created by 于争光 on 2021/12/13.
//
import SwiftUI

struct SearchPage: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    @StateObject var search = SearchModels()
    @StateObject var user = UsersModel()
    @State var current: Int = -1
    @Namespace var id
    
   var history = UserDefaults.standard.array(forKey: "historySearch")
    
    @State var searchKey: String = ""
    var body: some View {
        VStack{
            Input().padding(10)
            ScrollView{
                GeometryReader{ proxy in
                    VStack{
                        SearchHistory()
                       
                        SearchCates()
                        HotWordBillboardItem(current: $current)
                            .environmentObject(search)
                    }
                }
                .padding(.horizontal,15)
            }
        }
        .onAppear {
            search.hotWordBillboardCategory()
        }
        .background(Color.init(hex:colorScheme == .light ? "#F1F4F9" : "#0E0E0E"))
        
    }
    
    func SearchHistory() -> some View {
        VStack {
            if history?.count != nil {
                HStack{
                    Text("搜索历史")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                    Spacer()
                    Button {
                        withAnimation {
                            user.removeDeafult(key: "historySearch")
                        }
                    } label: {
                        Image(systemName: "trash")
                            .foregroundColor(colorScheme == .light ? Color.white : Color.init(hex: "#575757"))
                    }
                }
                .padding(.bottom,15)
            }
           
            HStack{
                ForEach((history ?? [""]) as [String],id: \.self){ item in
                    if item == "" {
                        EmptyView()
                    }else{
                        Button {
                            searchKey = item
                        } label: {
                            Text(item as String)
                                .padding(8)
                                .foregroundColor(Color.orange)
                                .background(colorScheme == .light ? Color.white : Color.init(hex: "#171717"))
                        }

                    }
                   
                }
            }
            .frame(maxWidth:.infinity, alignment: .leading)
            .padding(.bottom,15)
           
        }
    }
    
    // search TabView
    func SearchCates() -> some View {
        ScrollView(.horizontal,showsIndicators: false){
            HStack{
                ForEach(search.searchCate,id:\.categoryId) { item in
                    Button {
                        withAnimation {
                            current = item.categoryId
                            search.hotWordBillboard(id: item.categoryId)
                        }
                    } label: {
                        VStack{
                            Text(item.categoryName)
                                .fontWeight(item.categoryId == current ? .heavy : .none)
                                .scaleEffect(item.categoryId == current ? 1.2 : 1)
                                .foregroundColor(item.categoryId == current ? .orange : (colorScheme == .light ? Color.black : .white))
                               
                            if item.categoryId == current {
                                RoundedRectangle(cornerRadius: 2)
                                    .fill(.orange)
                                    .frame(width:20,height: 5)
                                    .matchedGeometryEffect(id: "TaB", in: id)
                            }else{
                                EmptyView()
                            }
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.leading,8)
                }
            }
        }
    }
    
    func Input() -> some View {
        HStack{
            HStack{
                Image(systemName: "magnifyingglass")
                TextField("专辑/用户", text: $searchKey,onCommit: {
                    user.setArray(value: searchKey)
                    searchKey = ""
                })
                    .keyboardType(.webSearch)
            }
            .padding(.leading,5)
            .frame(height: 40)
            .background(colorScheme == .light ? Color.white : Color.init(hex: "#151515"))
            .cornerRadius(5)
            
            Text("取消")
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
        }
    }
}
