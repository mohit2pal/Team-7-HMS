//
//  ViewPrescription.swift
//  Team-7-HMS
//
//  Created by Ekta  on 30/04/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct addPrescription: View {
    @State var appointmentData: AppointmentDataModel
    
    @Binding var showPrescriptionSheet: Bool
    
    @State private var isShowingProgressView: Bool = false
    
    @State private var diagnosis : String = ""
    @State private var symptoms : String = ""
    @State private var labTest : String = ""
    @State private var followUp : String = ""
    @State private var isPrescriptionOn = false
    @State private var isLabTestsOn = false
    @State var medicines: [Medicine] = []

    var body: some View {
            NavigationView {
                ScrollView {
                VStack{
                    HStack{
                        Text("Diagnosis").font(.headline)
                        Spacer()
                    }
                    TextField("Diagnosis", text: $diagnosis)
                        .padding()
                        .background(.white)
                        .cornerRadius(20)
                        .customShadow()
                    Spacer().frame(height: 20)
                    HStack{
                        Text("Symptoms").font(.headline)
                        Spacer()
                    }
                    TextField("Symptoms", text: $symptoms)
                        .padding()
                        .background(.white)
                        .cornerRadius(20)
                        .customShadow()
                    Spacer().frame(height: 20)
                    HStack{
                        Text("Prescribe Medicines").font(.headline)
                        Spacer()
                    }
                    
                    MedicineView(medicines: $medicines)
                    
                    Spacer().frame(height: 20)
                    HStack{
                        Text("Lab tests").font(.headline)
                        Spacer()
                    }
                    HStack{
                        TextField("Lab tests prescribed", text: $labTest)
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
                        TextField("Notes", text: $followUp)
                        Spacer()
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(20)
                    .customShadow()
                    Spacer()
                    
                    Button(action: {
                        isShowingProgressView = true // Show progress view
                        
                        // Call the addPrescription function here
                        FirebaseHelperFunctions.addPrescription(appointmentData: appointmentData, diagnosis: diagnosis, symptoms: symptoms, labTest: labTest, followUp: followUp, medicines: medicines) { result in
                            switch result {
                            case .success():
                                print("Prescription added successfully")
                                // Handle success, e.g., show a success message or clear the form
                            case .failure(let error):
                                print("Error adding prescription: \(error)")
                                // Handle failure, e.g., show an error message
                            }
                            
                            // Wait for two seconds before hiding the progress view and toggling the sheet
                            // This block should run regardless of the result
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                isShowingProgressView = false // Hide progress view
                                showPrescriptionSheet.toggle() // Toggle the sheet
                            }
                            
                        }
                    }) {
                        if isShowingProgressView {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    .frame(width: 300, height: 50)
                                    .background(Color.blue) // Assuming Color.myAccent is defined elsewhere, replace Color.blue with Color.myAccent
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                            } else {
                                Text("Add Prescription")
                                    .frame(width: 300, height: 50)
                                    .foregroundStyle(Color.white)
                                    .background(Color.myAccent) // Assuming Color.myAccent is defined elsewhere, replace Color.blue with Color.myAccent
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                            }
                    }
                    .disabled(isShowingProgressView) // Optionally disable the button while the progress view is showing
                    
                }
                .padding()
                .background(Color.background)
                .navigationTitle("Prescription")
            }
        }
    }
}

//#Preview{
//    addPrescription(appointmentData: <#T##AppointmentDataModel#>)
//}
