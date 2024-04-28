//import SwiftUI
//
//struct TabViewWithToolbar: View {
//    var body: some View {
//        TabView {
//            NavigationView {
//                Text("Home Tab")
//                    .navigationTitle("Home")
//                    .toolbar {
//                        ToolbarItem(placement: .navigationBarTrailing) {
//                            Button(action: {
//                                print("Action button tapped")
//                            }) {
//                                Image(systemName: "plus")
//                            }
//                        }
//                    }
//            }
//            .tabItem {
//                Image(systemName: "house.fill")
//                Text("Home")
//            }
//            
//            Text("Settings Tab")
//                .tabItem {
//                    Image(systemName: "gear")
//                    Text("Settings")
//                }
//        }
//    }
//}
//
//@main
//struct MyApp: App {
//    var body: some Scene {
//        WindowGroup {
//            TabViewWithToolbar()
//        }
//    }
//}
