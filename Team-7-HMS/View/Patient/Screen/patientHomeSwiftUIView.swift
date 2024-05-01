//
//  patientHomeSwiftUIView.swift
//  Team-7-HMS
//
//  Created by Vikashini G on 22/04/24.
//

import SwiftUI
import FirebaseAuth

struct patientHomeSwiftUIView: View {
    @EnvironmentObject var appState : AppState
    @ObservedObject var healthkit = HealthKitManager()
    @State private var shouldNavigateToLogin = false
    @State private var appointments: [AppointmentCardData] = []
    var patientUID : String
    @State var openDetailsView : Bool = false

    @State var userName: String
    @State var patientMedicalRecords: PatientMedicalRecords?

    var body: some View {
        VStack{
            //header
            HStack(alignment: .top){
                Button {
                    openDetailsView = true
                } label: {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 70, height: 70)
                        .foregroundColor(.gray)
                        .padding(.trailing)
                }
                
                NavigationLink(destination: LoginScreen().navigationBarBackButtonHidden(true), isActive: $shouldNavigateToLogin) {
                    EmptyView()
                }
                
                VStack(alignment: .leading){
                    Text("Hello 👋")
                        .font(CentFont.mediumReg)
                    Text(String(userName.prefix(20)))
                        .font(.title2)
                }
                Spacer()
                NavigationLink(destination: patientNotificationSwiftUIView()) {
                    Button(action: {
                        // Handle button action here if needed
                    }) {
                        Image(systemName: "bell.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 24)
                            .foregroundColor(.myAccent)
                    }
                }
            }
            .onAppear{
                FirebaseHelperFunctions().getMedicalRecords(patientUID: patientUID) { medicalRecord, error in
                    self.patientMedicalRecords = medicalRecord
                }
            }
            Spacer()
                .frame(height: 30)
        
            //vitals
            HStack{
                Text("Vitals")
                    .font(.title2)
                Spacer()
            }
            
            HStack{
                if healthkit.isWatchConnected {
                
                    VStack(alignment: .center){
                        Text("sp O2")
                            .font(CentFont.smallReg)
                            .foregroundStyle(.gray)
                        Image(systemName: "drop.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 30)
                            .foregroundStyle(.myAccent)
                        HStack(alignment: .bottom){
                            Text(String(format: "%.0f", healthkit.spo2))
                                .font(CentFont.mediumSemiBold)
                            Text("%")
                                .font(CentFont.smallReg)
                                .foregroundStyle(.gray)
                        }
                    }
                    Spacer()
                    RoundedRectangle(cornerRadius: 50)
                        .foregroundStyle(.gray)
                        .frame(width: 2, height: 33)
                    Spacer()
                    
                    VStack(alignment: .center){
                        Text("heart")
                            .font(CentFont.smallReg)
                            .foregroundStyle(.gray)
                        Image(systemName: "heart.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 30)
                            .foregroundStyle(Color.red)
                            .scaleEffect(1.1) // Initial scale
                            
                        HStack(alignment: .bottom){
                            Text(String(format: "%.0f", healthkit.heartRate))
                                .font(.title2)
                                .bold()
                            Text("bpm")
                                .font(.caption2)
                                .foregroundStyle(.gray)
                        }
                    }
                    Spacer()
                    RoundedRectangle(cornerRadius: 50)
                        .foregroundStyle(.gray)
                        .frame(width: 2, height: 33)
                    Spacer()
                    
                    VStack(alignment: .center){
                        Text("blood Pressure")
                            .frame(alignment: .center)
                            .multilineTextAlignment(.center)
                            .font(CentFont.smallReg)
                            .foregroundStyle(.gray)
                        Image(systemName: "waveform.path.ecg")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 30)
                            .foregroundStyle(.myAccent)
                        VStack(){
                            Text("\(String(format: "%.0f", healthkit.bp_s))/\(String(format: "%.0f", healthkit.bp_d))")               .font(CentFont.mediumSemiBold)
                            Text("mmHg")
                                .font(.caption2)
                                .foregroundStyle(.gray)
                        }
                    }
                }
                
                else{
                    VStack{
                        HStack{
                            Spacer()
                            Image(systemName: "applewatch")
                                .resizable()
                                .frame(width: 30 , height: 36)
                            Spacer()
                        }
                        Text("Disconnected")
                    }
                    .foregroundStyle(Color.red)
                }
            }
            
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .customShadow()
            
            Spacer()
                .frame(height: 30)
            
            //apointments upcoming
            HStack{
                Text("Upcoming appointments")
                    .font(CentFont.mediumReg)
                Spacer()
            }
            
            //Data modelling is done on appointmentCardDataM
            ScrollView(.vertical, showsIndicators: false){
                VStack(spacing: 10){
                    if appointments.isEmpty {
                        Text("There are no appointments scheduled")
                            .foregroundStyle(Color.gray)
                    }
                    else{
                        ForEach(appointments) { appointment in patientAppointmentCard(appointmentData: appointment)
                        }
                    }
                }
            }.customShadow()
            
            Spacer()
        }//Vstack end
        .sheet(isPresented: $openDetailsView, content: {
            PatientDetails(name: userName, flag: $shouldNavigateToLogin , closePage : $openDetailsView, medicalRecords: patientMedicalRecords ?? patientMedicalRecordStatic)
        })
        .onAppear {
            print("this is my patientUID : \(patientUID)")
            FirebaseHelperFunctions().getAppointments(patientUID: patientUID) { appointments, error in
                     if let error = error {
                         print("Error retrieving appointments:", error)
                         // Handle error if needed
                     } else {
                    
                         if let appointments = appointments {
                             self.appointments = appointments
                         }
                     }
                 }
            healthkit.startObservingHeartRate()
            healthkit.fetchBloodPressureData()
            healthkit.fetchSpO2Data()
        }
        .padding()
        .background(Color.background)
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.shouldNavigateToLogin = true
            print("User signed out successfully")
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError.localizedDescription)")
        }
    }
}

#Preview {
    patientHomeSwiftUIView(patientUID: "Vzo9cLiS9fZTyzpzkeH0Vure5YP2", userName: "Bose")
        .environmentObject(AppState())
}
