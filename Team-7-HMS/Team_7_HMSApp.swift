//
//  Team_7_HMSApp.swift
//  Team-7-HMS
//
//  Created by Subha on 19/04/24.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import HealthKit

@main
struct Team_7_HMSApp: App {
    
    private let healthStore: HKHealthStore
    
    init() {
        guard HKHealthStore.isHealthDataAvailable() else {  fatalError("This app requires a device that supports HealthKit") }
        healthStore = HKHealthStore()
        requestHealthkitPermissions()
    }
    
    private func requestHealthkitPermissions() {
        
        let sampleTypesToRead = Set([
            HKObjectType.quantityType(forIdentifier: .heartRate)!,
            HKObjectType.quantityType(forIdentifier: .bloodPressureSystolic)!,
            HKObjectType.quantityType(forIdentifier: .bloodPressureDiastolic)!,
            HKQuantityType.quantityType(forIdentifier: .oxygenSaturation)!
           ])
        
        healthStore.requestAuthorization(toShare: nil, read: sampleTypesToRead) { (success, error) in
            print("Request Authorization -- Success: ", success, " Error: ", error ?? "nil")
        }
    }
    
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @AppStorage("signIn") var isSignIn = false
    
    @ObservedObject var appState = AppState()

      var body: some Scene {
        WindowGroup {
          NavigationStack {
              ContentView()
                  .environmentObject(appState)
                  .id(appState.rootViewId)
          }
        }
      }
}
