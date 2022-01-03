//
//  AutoWrapPanel.swift
//  Medical
//
//  Created by 于争光 on 2021/12/14.
//

import SwiftUI

struct AutoWrapPanel<Data, ID, Content>: View
where Data: RandomAccessCollection, ID: Hashable, Content: View {
    
    let data: Array<Data.Element>
    let keyPath: KeyPath<Data.Element, ID>
    let content: (Data.Element) -> Content
    
    class ViewModel<Data: RandomAccessCollection>: ObservableObject {
        @Published var ranges: [Range<Int>]
        
        init(data: Data) {
            ranges = [0..<data.count]
        }
    }
    
    init(_ data: Data, id: KeyPath<Data.Element, ID>, @ViewBuilder content: @escaping (Data.Element) -> Content) {
        self.data = data.map { val in val }
        self.keyPath = id
        self.content = content
        self.model = ViewModel(data: data)
    }
    
    @ObservedObject var model: ViewModel<Data>
    
    @State private var frameWidth: CGFloat = .zero
    @State private var frameHeight: CGFloat = .zero
    @State private var subWidths: [ID: CGFloat] = [:]
    
    var body: some View {
        GeometryReader { geo in
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(model.ranges, id: \.self) { range in
                        HStack(spacing: 0) {
                            ForEach(range) { i in
                                content(data[i])
                                    .modifier(WidthWithID(id: data[i][keyPath: keyPath]))
                            }
                        }
                    }
                }
                .onPreferenceChange(ViewKey<WidthWithID<ID>.Element>.self) { values in
                    self.subWidths = [:]
                    values.forEach { val in
                        self.subWidths[val.id] = val.value
                    }
                    self.freshRanges()
                }

                Spacer(minLength: 0)
            }
            .frame(width: geo.size.width)
            .modifier(FrameWidthPreference())
            .onPreferenceChange(ViewKey<FrameWidth>.self) { values in
                values.forEach { val in
                    self.frameWidth = val.frameWidth
                }
                self.freshRanges()
            }
            .modifier(FrameHeightPreference())
            .onPreferenceChange(ViewKey<FrameHeight>.self) { values in
                values.forEach { val in
                    self.frameHeight = val.frameHeight
                }
            }
        }
        .frame(height: frameHeight)
    }
    
    func freshRanges() {
        guard frameWidth != .zero && subWidths.count == data.count else {
            return
        }
        model.ranges = []
        var start = 0, last = 0, sum: CGFloat = .zero
        for (i, value) in data.enumerated() {
            let width = subWidths[value[keyPath: keyPath]] ?? .zero
            if sum + width >= frameWidth {
                model.ranges.append(start..<i)
                sum = .zero
                start = i
            }
            sum += width
            last = i
        }
        if start <= last && data.count != 0 {
            model.ranges.append(start..<(last + 1))
        }
    }
}

struct ViewKey<Element>: PreferenceKey {
    typealias Value = [Element]
    static var defaultValue: Value { Value() }
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value.append(contentsOf: nextValue())
    }
}

struct BindID<ID: Hashable, Value: Hashable>: Hashable {
    let id: ID
    let value: Value
}

struct WidthWithID<ID: Hashable>: ViewModifier {
    typealias Element = BindID<ID, CGFloat>
    let id: ID
    
    func body(content: Content) -> some View {
        content.background(
            GeometryReader { geo in
                Spacer().preference(
                    key: ViewKey<Element>.self,
                    value: [Element(id: id, value: geo.size.width)]
                )
            }
        )
    }
}

struct FrameWidth: Hashable {
    let frameWidth: CGFloat
}

struct FrameWidthPreference: ViewModifier {
    func body(content: Content) -> some View {
        content.background(
            GeometryReader { geo in
                Spacer().preference(
                    key: ViewKey<FrameWidth>.self,
                    value: [FrameWidth(frameWidth: geo.size.width)]
                )
            }
        )
    }
}

struct FrameHeight: Hashable {
    let frameHeight: CGFloat
}

struct FrameHeightPreference: ViewModifier {
    func body(content: Content) -> some View {
        content.background(
            GeometryReader { geo in
                Color.clear.preference(
                    key: ViewKey<FrameHeight>.self,
                    value: [FrameHeight(frameHeight: geo.size.height)]
                )
            }
        )
    }
}
