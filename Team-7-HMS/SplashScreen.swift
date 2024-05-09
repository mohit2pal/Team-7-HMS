//
//  SplashScreen.swift
//  Team-7-HMS
//
//  Created by Subha on 25/04/24.
//

import SwiftUI

import SwiftUI

struct SplashScreen: View {
    @ObservedObject var viewModel: AppViewModel
    @State private var logoPosition = 0.0 // Initial state, adjust if needed

    var body: some View {
        ZStack {
            Color("PrimaryColor")
                .opacity(0.83)
                .ignoresSafeArea()
            
            Image("hospitalLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
                .offset(y: logoPosition) // Use the state to control position
                .onAppear {
                    // Delay to display the SplashScreen before starting the exit animation
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        withAnimation(.easeInOut(duration: 2)) {
                            logoPosition = -160 // Move up to create the exit animation
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            viewModel.showSplashScreen = false // Hide splash screen after animation
                        }
                    }
                }
        }
    }
}

//#Preview {
//    SplashScreen(viewModel: true)
//}
