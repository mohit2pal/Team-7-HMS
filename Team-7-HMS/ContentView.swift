//
//  ContentView.swift
//  Team-7-HMS
//
//  Created by Subha on 19/04/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var healthkit = HealthKitManager()
    var body: some View {
        VStack {
            OnBoardingScreen()
                
        }
        .onAppear{
            healthkit.startObservingHeartRate()
        }
    }
}

#Preview {
    ContentView()
}
