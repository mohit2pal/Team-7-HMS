//
//  ContentView.swift
//  Team-7-HMS
//
//  Created by Subha on 19/04/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    @State private var currentUser: User? = nil
    @State private var patient: Patient? = nil // Add this line to store fetched patient data
    
    @State private var isShowingSplash = true
    var body: some View {
        NavigationStack {
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
                        PatientView(patientName: patient.name)
                    } else {
                        OnBoardingScreen()
                    }
                }
                
            }
        }
    }
    
    func fetchCurrentUserAndData() {
            if let user = Auth.auth().currentUser {
                self.currentUser = user
                print(self.currentUser?.uid ?? "")
                // Fetch patient data using the user's UID
                FirebaseHelperFunctions.fetchPatientData(by: user.uid) { patient, error in
                    if let patient = patient {
                        self.patient = patient // Store fetched patient data
                        print(self.patient!)
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
