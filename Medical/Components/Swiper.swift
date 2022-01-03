//
//  Swpier.swift
//  Medical
//
//  Created by 于争光 on 2021/10/6.
//

import SwiftUI

struct Swpier<T: Identifiable,Content: View>: View where T: Hashable {

    var content: (T) -> Content
    var list: [T]

    var spacing: CGFloat

    var trailingSpace: CGFloat

    @Binding var index: Int

    init(
        spacing: CGFloat = 15,
        trailingSpace: CGFloat = 100,
        index: Binding<Int>,
        item: [T],
        @ViewBuilder content: @escaping (T) -> Content
    ){
        self.spacing = spacing
        self.trailingSpace = trailingSpace
        self.list = item
        self._index = index
        self.content = content
    }

    @GestureState var offset: CGFloat = 0
    @State var currentIndex: Int = 0

    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

    var body: some View {
        GeometryReader{ geo in

            let width = (geo.size.width - (trailingSpace - spacing))
            let adjustMentWidth = (trailingSpace / 2) - spacing

            HStack(spacing: spacing){
                ForEach(list){ val in
                    content(val)
                        .frame(width: geo.size.width - trailingSpace)
                }
            }
            .padding(.horizontal,spacing)
            .offset(x: (CGFloat(currentIndex)  * -width) + (currentIndex != 0 ? adjustMentWidth : 0) + offset)
            .scaleEffect(currentIndex == index ? 1 : 1.2)
            .gesture(
              DragGesture()
                .updating($offset, body: { val, out, _ in
                    out = val.translation.width
                })
                .onEnded({ val in
                    let offsetX = val.translation.width
                    let progress =  -offsetX / width
                    let roundIndex = Int(progress.rounded())

                    currentIndex = max(min(currentIndex + roundIndex,list.count - 1), 0)

                    currentIndex = index
                })
                .onChanged({ value in
                    let offsetX = value.translation.width
                    let progress =  -offsetX / width
                    let roundIndex = Int(progress.rounded())

                    currentIndex = max(min(currentIndex + roundIndex,list.count - 1), 0)
                })
            )
        }
        .animation(.easeInOut, value: offset == 0)
        .onReceive(timer) { _ in
            withAnimation(.easeInOut) {
                if currentIndex == list.count - 1{
                    currentIndex = 0
                }else{
                    currentIndex += 1
                }
            }
        }
    }
}
//
//
//
//
//struct BannerModel: Identifiable {
//    var id: Int
//    var image: URL
//}
//
//let list = [
//    BannerModel(id: 0, image:URL(string: "https://m.360buyimg.com/mobilecms/s700x280_jfs/t1/198441/8/10862/165027/61558994Ee5038d17/78405df35613dab2.jpg!cr_1053x420_4_0!q70.jpg.dpg")!),
//
//    BannerModel(id: 1, image:URL(string: "https://m.360buyimg.com/mobilecms/s700x280_jfs/t1/132530/32/283/247671/5ecb56e0Ebf662190/2741e7a123ea8821.jpg!cr_1125x449_0_166!q70.jpg.dpg")!),
//
//    BannerModel(id: 2, image: URL(string: "https://imgcps.jd.com/ling4/10032363796052/5Lqs6YCJ5aW96LSn/5L2g5YC85b6X5oul5pyJ/p-5c11d16482acdd181dbc1fad/52f1aff6/cr_1125x449_0_166/s/q70.jpg")!),
//
//    BannerModel(id: 3, image: URL(string: "https://m.360buyimg.com/mobilecms/s700x280_jfs/t1/59883/3/4305/162788/5d268c4eE883fb4bd/a79c802e2d019688.jpg!cr_1125x449_0_166!q70.jpg.dpg")!)
//]
//
//struct Swiper<Content: View,T: Identifiable>: View where T: Hashable {
//
//    private var items: [T]
//
//    @Binding private var currentIndex: Int
//
//    init(items: [SwiperItem],currentIndex: Binding<Int>){
//        self.items = items
//        self._currentIndex = currentIndex
//    }
//
//    func makeUIViewController(context: Context) -> UIPageViewController {
//        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
//        pageViewController.dataSource = context.coordinator
//        pageViewController.delegate = context.coordinator
//        return pageViewController
//    }
//
//    func updateUIViewController(_ uiViewController: UIPageViewController, context: Context) {
//        print("uiViewController",uiViewController)
//
//        uiViewController.setViewControllers([context.coordinator.controllers[currentIndex]], direction: .forward, animated: true, completion: nil)
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    class Coordinator: NSObject,UIPageViewControllerDataSource,UIPageViewControllerDelegate{
//
//        private var parent:Swiper
//
//        var controllers = [UIViewController]()
//
//        init(_ parent: Swiper) {
//            self.parent = parent
//            controllers = parent.items.map({ UIHostingController(rootView: $0)})
//        }
//
//        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//            guard let index = controllers.firstIndex(of: viewController) else{ return nil}
//            if index == 0 {
//                return controllers.last
//            }
//            return controllers[index - 1]
//        }
//
//        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//            guard let index = controllers.firstIndex(of: viewController) else{ return nil}
//            if index == controllers.count - 1 {
//                return controllers.first
//            }
//            return controllers[index + 1]
//        }
//
//        func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
//            if completed,let visiableController = pageViewController.viewControllers?.first,let index = controllers.firstIndex(of: visiableController) {
//                parent.currentIndex = index
//            }
//        }
//    }
//}
//
//struct SwiperControl: UIViewRepresentable {
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//
//    var numOfPages: Int
//    @Binding var currentPage: Int
//
//    func makeUIView(context: Context) -> UIPageControl {
//        let control = UIPageControl()
//
//        control.numberOfPages = numOfPages
//
//        control.addTarget(context.coordinator, action: #selector(context.coordinator.onChanged(sender:)), for: .valueChanged)
//
//        return control
//    }
//
//    func updateUIView(_ uiView: UIPageControl, context: Context) {
//        uiView.currentPage = currentPage
//    }
//
//    class Coordinator: NSObject{
//        var parent: SwiperControl
//
//        init(_ parent: SwiperControl) {
//            self.parent = parent
//        }
//
//        @objc func onChanged(sender: UIPageControl){
//            parent.currentPage = sender.currentPage
//        }
//    }
//}
//
//struct Banner: View {
//    @State var cur: Int = 0
//    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
//    var body: some View{
//        ZStack(alignment: .bottom){
//            Swiper(items: [
//                Image("1")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit),
//                Image("2")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit),
//                Image("3")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit),
//                Image("4")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//               ], currentIndex: $cur)
//
//            SwiperControl(numOfPages: 3, currentPage: $cur)
//        }
//        .padding(.horizontal,10)
//        .aspectRatio(1.8, contentMode: .fit)
//        .onReceive(timer) { _ in
//            withAnimation(.easeInOut) {
//                if cur == list.count - 1{
//                    cur = 0
//                }else{
//                    cur += 1
//                }
//            }
//        }
//    }
//
//}
//
//struct Banner_Previews: PreviewProvider {
//    static var previews: some View {
//        Banner()
//    }
//}
