//
//  UpcomingMedicalRecodsView.swift
//  Team-7-HMS
//
//  Created by Meghs on 05/05/24.
//

import SwiftUI
import Firebase

struct UpcomingMedicalRecodsView: View {
    var patientUID : String {
        Auth.auth().currentUser?.uid ?? ""
    }
    @State private var isLoading : Bool = false
    @State private var medicalTests : [MedicalTest] = []
    @State private var notificationEnabled: [Bool] = []
    @State private var showAlert = false
    @State private var indexToDelete = 0
    @State private var viewId = false
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.background.ignoresSafeArea()
                ScrollView{
                    if isLoading {
                        ProgressView()
                    }
                    else{
                        if !medicalTests.isEmpty{
                            
                            ForEach(medicalTests.indices , id : \.self ){ index in
                                VStack(alignment: .leading){
                                    HStack{
                                        VStack{
                                            HStack{
                                                Text(medicalTests[index].medicalTest)
                                                    .font(.title2)
                                                    .bold()
                                                
                                                Spacer()
                                            }
                                            
                                            HStack{
                                                Text("ID : \(medicalTests[index].caseID.suffix(6))")
                                                    .padding(.bottom)
                                                    .foregroundStyle(Color.gray.opacity(0.9))
                                                Spacer()
                                            }
                                        }
                                        Spacer()
                                   

                                        
                                        Button(action: {
                                            
                                            notificationEnabled[index].toggle()
                                            
                                            if notificationEnabled[index] {
                                               scheduleNotifications(for: medicalTests[index])
                                            }
                                            
                                            else {
                                                removeNotification(for: medicalTests[index])
                                            }
                                            
                                            
                                            
                                            FirebaseHelperFunctions().updateNotificationStatus(for: medicalTests[index].caseID, isEnabled: notificationEnabled[index])
                                            
                                            
                                        }, label: {
                                            Image(systemName: notificationEnabled[index] ? "bell.fill" : "bell")
                                        })
                                        
                                        Spacer()
                                        
                                        Button(action: {
                                            
                                            indexToDelete = index
                                            showAlert = true
                                        }, label: {
                                            Image(systemName: "trash")
                                                .foregroundStyle(.red)
                                        })
                                        .alert(isPresented: $showAlert) {
                                            Alert(
                                                title: Text("Delete Medical Test"),
                                                message: Text("Are you sure you want to delete \(medicalTests[index].medicalTest) on \(medicalTests[index].date.replacingOccurrences(of: "_", with: "-"))"),
                                                primaryButton: .destructive(Text("Delete")) {
                                                    // Delete the medical test if confirmed
                                                    viewId.toggle()
                                                    FirebaseHelperFunctions().deleteMedicalTest(for: medicalTests[index].caseID)
                                                    medicalTests.remove(at: index)
                                                    
                                                },
                                                secondaryButton: .cancel()
                                            )
                                        }
                                        
                                    }
                                    HStack{
                                        Image(systemName: "calendar")
                                        Text(medicalTests[index].date.replacingOccurrences(of: "_", with: "-"))
                                        Spacer()
                                        Image(systemName: "clock")
                                        Text(medicalTests[index].time)
                                    }
                                    
                                    if let data = medicalTestInformation[medicalTests[index].medicalTest]{
                                        HStack{
                                            Text(data)
                                                .multilineTextAlignment(.center)
                                                .font(.caption)
                                        }
                                    }
                                }
                                .frame(width: 330 ,alignment: .leading)
                                .padding()
                                .multilineTextAlignment(.leading)
                                .background(Color.white)
                                .cornerRadius(15)
                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 1)
                            }
                            .id(viewId)
                        }
                        else {
                            Text("There are no upcoming Medical Tests.")
                                .padding()
                        }
                    }
                }
            }
            
            .onAppear{
                isLoading = true
                FirebaseHelperFunctions().fetchMedicalTests(patientUID: patientUID) { tests in
                    let inProgressTests = tests.filter { $0.status == "In progress" }
                    self.medicalTests = inProgressTests
                    self.notificationEnabled = inProgressTests.map { $0.notifications }
                    isLoading = false
                }
            }
        }
    }
}

#Preview {
    UpcomingMedicalRecodsView()
}
