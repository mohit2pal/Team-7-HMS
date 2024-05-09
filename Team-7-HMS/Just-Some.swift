//import SwiftUI
//
//struct ContentView: View {
//    @StateObject private var viewModel = AppViewModel()
//
//    var body: some View {
//        VStack {
//            if viewModel.showSplashScreen {
//                SplashScreen(viewModel: viewModel)
//                    .transition(.opacity.combined(with: .slide)) // Combine fade and slide for the transition
//                    .animation(.easeInOut(duration: 1.0), value: viewModel.showSplashScreen) // Smooth transition animation
//            } else {
//                OnboardingScreen()
//                    .transition(.opacity.combined(with: .slide)) // Combine fade and slide for the transition
//                    .animation(.easeInOut(duration: 1.0), value: viewModel.showSplashScreen) // Smooth transition animation
//            }
//        }
//    }
//}
