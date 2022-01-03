
 import SwiftUI


 struct MainView: View {
     @StateObject var current: UsersModel = UsersModel()
     @Environment(\.colorScheme) var colorScheme
     @Namespace private var animation
     var body: some View {
         NavigationView{
             ZStack(alignment: .bottom){
                 TabView(selection: $current.activeBar){
                     Home()
                         .tag(CustomTabs.home)
                     
                     MyPage()
                         .tag(CustomTabs.mine)
                 }
                 Overlay()
             }
             .ignoresSafeArea(.all,edges: .bottom)
         }
         .navigationTitle("787")
     }

     func Overlay() -> some View {
         HStack{
             ForEach(CustomTabs.allCases,id: \.rawValue){ tab in
                 TabButton(tab: tab)
             }
         }
         .opacity(current.isTabViewShow ? 1 : 0)
         .padding(.vertical)
         .padding(.bottom,getSafeArea().bottom == 0 ? 10 : (getSafeArea().bottom - 10))
         .background(
            MaterialEffect(style: .systemChromeMaterial)
         )
     }

     @ViewBuilder
     func TabButton(tab: CustomTabs) -> some View {
         GeometryReader{ proxy in
             Button {
                 withAnimation(.easeInOut) {
                     current.activeBar = tab
                     current.currentXValue = proxy.frame(in: .global).midX
                 }
             } label: {
                 VStack{
                     Image(current.activeBar == tab ? tab.iconNameAct : tab.iconNameNor)
                         .resizable()
                         .aspectRatio(contentMode: .fit)
                         .frame(width: 22, height: 22)
                         .frame(maxWidth:.infinity)
                         .foregroundColor(colorScheme == .dark ? .white : .black)
                         .background(
                            ZStack{
                                if current.activeBar == tab {
                                    RoundedRectangle(cornerRadius: 2)
                                        .fill(.orange)
                                        .matchedGeometryEffect(id: "TAB", in: animation)
                                        .frame(width: 40, height: 4)
                                        .offset(x: 0, y: -25)
                                }
                            }
                         )
                         .contentShape(Rectangle())
                     
                     Text(tab.rawValue)
                         .font(.system(size: 14))
                         .foregroundColor(current.activeBar == tab ? .init(hex:"#FFA500") : .init(hex: "#bfbfbf"))
                 }

             }
             .onAppear {
                 if tab == CustomTabs.allCases.first && current.currentXValue == 0 {
                     current.currentXValue = proxy.frame(in: .global).midX
                 }
             }
         }
         .frame(height: 30)

     }
 }

 extension View{
     func getSafeArea() -> UIEdgeInsets {
         guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{ return .zero }
         guard let safeArea = screen.windows.first?.safeAreaInsets else{ return .zero }
         return safeArea
     }
 }



