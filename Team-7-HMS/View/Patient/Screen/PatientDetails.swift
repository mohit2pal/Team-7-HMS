//
//  PatientDetails.swift
//  Team-7-HMS
//
//  Created by Meghs on 29/04/24.
//

import SwiftUI
import FirebaseAuth
import Firebase

let patientMedicalRecordStatic = PatientMedicalRecords(
    alergies: ["Paracetamol"],
    pastMedical: ["Asthama"],
    surgeries: [],
    bloodGroup: "O+",
    gender: "Male",
    height: "179",
    weight: "80",
    phoneNumber: "1234567890"
)

struct PatientDetails: View {
    @State var name : String
    @Binding var flag  : Bool
    @Binding var closePage : Bool
    @State var medicalRecords : PatientMedicalRecords
    var body: some View {
        
        NavigationStack{
            HStack{
                Spacer()
                profile_pic()
                    .frame(width: 100 , height: 100
                    )
                Spacer()
            }
            .navigationTitle("User Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        closePage = false
                    }, label: {
                        Text("Cancel")
                    })
                }
            })
            List{
                Section("User Information") {
                    Text(name)
                    Text("Age")
                }
                Section("Medical Information") {
                    HStack{
                        Text("Gender:")
                        Text("\(medicalRecords.gender)")
                    }
                    
                    HStack{
                        Text("Height :")
                        Text("\(medicalRecords.height) cm")
                    }
                    HStack{
                        Text("Weight :")
                        Text("\(medicalRecords.weight) kg")
                    }
                    
                    HStack{
                        Text("Blood Group :")
                        Text("\(medicalRecords.bloodGroup)")
                    }
                }
                Section("Medical History") {
                    NavigationLink {
                        VStack{
                            List{
                                Section("Past Medical Histories") {
                                    if !medicalRecords.pastMedical.isEmpty{
                                        ForEach(medicalRecords.pastMedical, id: \.self) { allergy in
                                            Text(allergy)
                                        }
                                    } else {
                                        Text("No Medical History added")
                                    }
                                }
                                
                                Section("Past Surgeries") {
                                    if !medicalRecords.surgeries.isEmpty{
                                        ForEach(medicalRecords.surgeries, id: \.self) { allergy in
                                            Text(allergy)
                                        }
                                    } else {
                                        Text("No Previous Surgeries")
                                    }
                                }
                                
                                Section("Alergies") {
                                    if !medicalRecords.alergies.isEmpty{
                                        ForEach(medicalRecords.alergies, id: \.self) { allergy in
                                            Text(allergy)
                                        }
                                    } else {
                                        Text("No Allergies")
                                    }
                                }


                            }
                        }
                    } label: {
                        Text("Medical History")
                    }
                }
                
                Section {
                    Button(action: {
                        signOut()
                    }
                           , label: {
                        Text("Logout")
                            .foregroundStyle(Color.red)
                    })
                }
                
            }
        }
        .onAppear{
            if let userUID = Auth.auth().currentUser?.uid {
            } else {
                print("User not authenticated")
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            flag = true
            print("User signed out successfully")
            closePage = false
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError.localizedDescription)")
        }
    }
}

#Preview {
    PatientDetails(name: "Bose", flag: .constant(true), closePage: .constant(true), medicalRecords: patientMedicalRecordStatic)
}
