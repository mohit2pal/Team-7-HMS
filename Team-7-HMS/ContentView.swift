//
//  ContentView.swift
//  Team-7-HMS
//
//  Created by Subha on 19/04/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

func fetchUserData(userId: String) {
    // Example: Fetch user data from Firestore
    let db = Firestore.firestore()
    db.collection("users").document(userId).getDocument { document, error in
        if let document = document, document.exists {
            // Document exists, extract user data
            if let userData = document.data(),
               let username = userData["name"] as? String {
                // Update UI with user data
                print("Username: \(username)")
                
            }
        } else {
            return
        }
    }
}


struct ContentView: View {
    @EnvironmentObject var appState: AppState
    @State private var currentUser: User? = nil
    
    @State private var isShowingSplash = true
    var body: some View {
        ZStack {
            if isShowingSplash {
                SplashScreen()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            isShowingSplash = false
                        }
                    }
            } else {
                if isLogin == true {
                    patientTabItems()
                } else if isLogin == false {
                    LoginScreen()
                }
            }
            
        }
    }
    
    var isLogin: Bool {
        // Check if user is logged in
        if let user = Auth.auth().currentUser {
            // If user is logged in, set currentUser with user data
            self.currentUser = user
            // Example: Retrieve additional user data from Firestore
            return true
        } else {
            // If no user is logged in, set currentUser to nil or take appropriate action
            self.currentUser = nil
            return false
        }
    }
}

#Preview {
    ContentView()
}
