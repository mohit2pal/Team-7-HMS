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
    @State private var doctor: DoctorDetails? = nil
    @State var patientID : String?
//    @State private var isShowingSplash = true
    @State var role: String?
    
    @StateObject private var viewModel = AppViewModel()
    
    @StateObject private var networkMonitor = NetworkMonitor()
    @State private var isConnected: Bool = true
    
    var body: some View {
            NavigationStack {
                ZStack {
                    if viewModel.showSplashScreen {
                        SplashScreen(viewModel: viewModel)
                            .transition(.opacity.combined(with: .slide)) // Combine fade and slide for the transition
                            .animation(.easeInOut(duration: 1.0), value: viewModel.showSplashScreen) // Smooth transition animation
                            .onAppear {
                                fetchCurrentUserAndData()
                            }
                    }else {
                        if networkMonitor.isConnected {
                            if role == "patient" {
                                if let patient = patient {
                                    PatientView(patientName: patient.name, showPatientHistory: false, patientUid: self.currentUser?.uid ?? "Not Fetched")
                                        .transition(.opacity.combined(with: .slide)) // Combine fade and slide for the transition
                                        .animation(.easeInOut(duration: 1.0), value: viewModel.showSplashScreen) // Smooth transition animation
                                }
                            } else if role == "doctor" {
                                if let doctor = doctor {
                                    DoctorView(doctorUid: self.currentUser?.uid ?? "Not Fetched", doctorDetails: doctor, doctorName: doctor.name)
                                        .transition(.opacity.combined(with: .slide)) // Combine fade and slide for the transition
                                        .animation(.easeInOut(duration: 1.0), value: viewModel.showSplashScreen) // Smooth transition animation
                                }
                            } else {
                                OnBoardingScreen()
                                    .transition(.opacity.combined(with: .slide)) // Combine fade and slide for the transition
                                    .animation(.easeInOut(duration: 1.0), value: viewModel.showSplashScreen) // Smooth transition animation
                            }
                        } else {
                            VStack{
                                Image(systemName: "wifi.exclamationmark")
                                    .resizable()
                                    .frame(width: 110, height: 100)
                                    .symbolEffect(.bounce.down.byLayer, value: isConnected)
                            }
                            .onAppear{
                                isConnected.toggle()
                            }
                        }
                    }
                    
                }
            }
    }

    func fetchCurrentUserAndData() {
        guard let user = Auth.auth().currentUser else {
            self.currentUser = nil
            return
        }
        self.currentUser = user
        
        // First, check the patient_details collection
        let patientRef = Firestore.firestore().collection("patient_details").document(user.uid)
        patientRef.getDocument { (document, error) in
            if let document = document, document.exists {
                // User UID is in the patient_details collection
                self.role = "patient"
                // Fetch patient data using the user's UID
                FirebaseHelperFunctions().fetchPatientData(by: user.uid) { patient, error in
                    if let patient = patient {
                        self.patient = patient // Store fetched patient data
                        print(self.patient!)
                        
                    } else {
                        print(error?.localizedDescription ?? "Failed to fetch patient data")
                    }
                }
            } else {
                // If not found in patient_details, check the doctor_details collection
                let doctorRef = Firestore.firestore().collection("doctor_details").document(user.uid)
                doctorRef.getDocument { (document, error) in
                    if let document = document, document.exists {
                        // User UID is in the doctor_details collection
                        self.role = "doctor"
                        // Here, you might want to fetch doctor-specific data similarly
                        FirebaseHelperFunctions().fetchDoctorDetails(by: user.uid) { doctor, error in
                            if let doctor = doctor {
                                self.doctor = doctor
                                print(self.doctor!)
                            } else {
                                print(error?.localizedDescription ?? "Failed to fetch doctor data")
                            }
                        }
                    } else {
                        // Handle case where user is neither in patient_details nor doctor_details
                        print("User is not found in patient_details or doctor_details")
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AppState())
}
