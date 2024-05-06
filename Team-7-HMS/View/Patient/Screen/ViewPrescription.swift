//
//  ViewPrescription.swift
//  Team-7-HMS
//
//  Created by Ekta  on 30/04/24.
//

import SwiftUI
import Foundation

struct ViewPrescription: View {
    @Binding var showOldPrescriptionSheet: Bool
    
    @State var appointmentID: String
    
    @State private var diagnosis: String = "Diagnosis will be displayed Here"
    @State private var symptoms: String = "Symptoms will be displayed here"
    @State private var labTests: String = "Lab Tests will be displayed here"
    @State private var followUp: String = "Follow up will be displayed here"
    
    @State var medicines: [Medicine] = []
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack{
                    //                Spacer().frame(height: 30)
                    HStack{
                        Text("Diagnosis").font(.headline)
                        Spacer()
                    }
                    HStack{
                        Text(diagnosis)
                        Spacer()
                    }
                    .foregroundStyle(Color.black)
                    .padding()
                    .background(.white)
                    .cornerRadius(20)
                    .customShadow()
                    Spacer().frame(height: 20)
                    HStack{
                        Text("Symptoms").font(.headline)
                        Spacer()
                    }
                    HStack{
                        Text(symptoms)
                        Spacer()
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(20)
                    .customShadow()
                    Spacer().frame(height: 20)
                    HStack{
                        Text("Prescribed Medicines").font(.headline)
                        Spacer()
                    }
                    ForEach(medicines) {medicine in
                        HStack {
                            VStack{
                                Text(medicine.name)
                                /*ext("(AF for 10 days)").font(.system(size: 12))*/  //For adding medicine time
                            }
                            
                            Spacer()
                            VStack{
                                HStack{
                                    Image(systemName: medicine.morningDose ? "sun.max.fill" : "sun.max")
                                    Spacer()
                                    Image(systemName: medicine.eveningDose ? "sun.horizon.fill" : "sun.horizon")
                                    Spacer()
                                    Image(systemName: medicine.nightDose ? "moon.fill" : "moon")
                                }
                                .foregroundColor(.myAccent)
                                .frame(width: 110)
                                HStack{
                                    Text(medicine.morningDose ? "1" : "0")
                                    Spacer()
                                    Text(medicine.eveningDose ? "1" : "0")
                                    Spacer()
                                    Text(medicine.nightDose ? "1" : "0")
                                }
                                .frame(width: 100)
                            }
                        }
                        .padding()
                        .background(.white)
                        .cornerRadius(20)
                        .customShadow()
                    }
                    Spacer().frame(height: 20)
                    HStack{
                        Text("Lab tests").font(.headline)
                        Spacer()
                    }
                    HStack{
                        Text(labTests)
                        Spacer()
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(20)
                    .customShadow()
                    Spacer().frame(height: 20)
                    HStack{
                        Text("Follow up").font(.headline)
                        Spacer()
                    }
                    HStack{
                        Text(followUp)
                        Spacer()
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(20)
                    .customShadow()
                    Spacer()
                }
                .padding()
                .background(Color.background)
                .navigationTitle("Prescription")
                .onAppear{
                    fetchPrescriptionData()
                }
            }
        }
    }
    
    private func fetchPrescriptionData() {
            // Assuming FirebaseHelperFunctions is the class where fetchPrescription is defined
            let firebaseHelper = FirebaseHelperFunctions()
            firebaseHelper.fetchPrescription(appointmentID: appointmentID) { result in
                switch result {
                case .success(let prescription):
                    // Update your state variables here based on the fetched prescription
                    self.diagnosis = prescription.diagnosis
                    self.symptoms = prescription.symptoms
                    self.labTests = prescription.labTest
                    self.followUp = prescription.followUp
                    self.medicines = prescription.medicines
                    
                case .failure(let error):
                    print("Error fetching prescription: \(error)")
                    // Handle error appropriately
                }
            }
        }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ViewPrescription(showOldPrescriptionSheet: .constant(true), appointmentID: "hh", medicines: medi)
//    }
//}
