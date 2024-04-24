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

@main
struct Team_7_HMSApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @AppStorage("signIn") var isSignIn = false

      var body: some Scene {
        WindowGroup {
          NavigationView {
           ContentView()
          }
        }
      }
}
