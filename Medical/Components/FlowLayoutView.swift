//
//  FlowLayoutView.swift
//  Medical
//
//  Created by 于争光 on 2021/10/4.
//

import SwiftUI

struct FlowLayoutView<Content: View,T: Identifiable>: View where T: Hashable {
    
    var list: [T]
    
    var column: Int
    
    var content: (T) -> Content
    
    var itemSpacingH: CGFloat
    
    var itemSpacingV: CGFloat
    
    private func splite() ->[[T]]{
        var currentIndex: Int = 0
        var gridList: [[T]] = Array(repeating: [], count: column)
        
        list.forEach { item in
            gridList[currentIndex].append(item)
            if currentIndex == column - 1 {
                currentIndex = 0
            }else{
                currentIndex += 1
            }
        }
        return gridList
    }
    
    init(list: [T],column: Int,itemSpacingH: CGFloat,itemSpacingV: CGFloat,@ViewBuilder content: @escaping (T) -> Content){
        self.list = list
        self.column = column
        self.content = content
        self.itemSpacingH = itemSpacingH
        self.itemSpacingV = itemSpacingV
    }
    
    var body: some View {
        ScrollView(.vertical,showsIndicators: false){
            HStack(alignment: .top,spacing: itemSpacingH){
                ForEach(splite(),id: \.self){ objs in
                    LazyVStack(spacing: itemSpacingV){
                        ForEach(objs){ obj in
                            content(obj)
                        }
                    }
                }
            }
        }
    }
}

