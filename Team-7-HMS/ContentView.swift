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
    @State private var patient: Patient? = nil // Add this line to store fetched patient data
    
    @State private var isShowingSplash = true
    var body: some View {
        ZStack {
            if isShowingSplash {
                SplashScreen()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            isShowingSplash = false
                            fetchCurrentUserAndData()
                        }
                    }
            } else {
                if let patient = patient {
                    patientHomeSwiftUIView(userName: patient.name)
                } else {
                    LoginScreen()
                }
            }
            
        }
    }
    
    func fetchCurrentUserAndData() {
            if let user = Auth.auth().currentUser {
                self.currentUser = user
                print(self.currentUser?.uid)
                // Fetch patient data using the user's UID
                FirebaseHelperFunctions.fetchPatientData(by: user.uid) { patient, error in
                    if let patient = patient {
                        self.patient = patient // Store fetched patient data
                        print(self.patient)
                    } else {
                        print(error?.localizedDescription ?? "Failed to fetch patient data")
                    }
                }
            } else {
                self.currentUser = nil
            }
        }
}

#Preview {
    ContentView()
}
