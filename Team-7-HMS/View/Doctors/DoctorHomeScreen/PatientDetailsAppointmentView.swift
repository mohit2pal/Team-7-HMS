//
//  PatientDetailsAppointmentView.swift
//  Team-7-HMS
//
//  Created by Meghs on 02/05/24.
//

import SwiftUI

struct PatientDetailsAppointmentView: View {
    var patientUID : String
    @State var patientMedicalRecords: PatientMedicalRecords?
    @State var patientName : String  = ""
    var slotTime : String
    
    @State private var complaints: [String] = []
    @State private var newComplaint: String = ""
    @State private var diagnosis: String = ""

    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    Text("Patient Name :")
                    Text(patientName)
                }
                .font(.title2)
                
                HStack{
                    Text("Gender :")
                    Text(patientMedicalRecords?.gender ?? "")
    
                    Text("Time Slot :")
                    Text(slotTime)
                }
                
                VStack(alignment:.leading){
                    Text("Medical Info")
                        .font(.title2)
                        .bold()
                    
                    Text("Medical History:")
                        .bold()
                    if let medHist = patientMedicalRecords?.pastMedical {
                        ForEach(medHist, id: \.self) { issue in
                            Text("\(issue)")
                        }
                    } else {
                        Text("No previous medications recorded for this patient.")
                    }
                    
                    Text("Past Surgeries:")
                        .bold()
                    if let surgeries = patientMedicalRecords?.surgeries , !surgeries.isEmpty {
                        ForEach(surgeries, id: \.self) { allergy in
                            Text("\(allergy)")
                        }
                    } else {
                        Text("No allergies recorded for this patient.")
                    }
                    
                    
                    Text("Patient allergies:")
                        .bold()
                    if let allergies = patientMedicalRecords?.alergies {
                        ForEach(allergies, id: \.self) { allergy in
                            Text("\(allergy)")
                        }
                    } else {
                        Text("No allergies recorded for this patient.")
                    }
                }
                
                Divider()
                
                VStack(alignment: .leading) {
                                Text("Chief Complaints")
                                    .font(.title2)
                                    .bold()
                                
                    
                        ForEach(complaints, id: \.self) { complaint in
                            HStack {
                                Text(complaint)
                                Spacer()
                                Button(action: {
                                    // Action to delete complaint
                                    if let index = complaints.firstIndex(of: complaint) {
                                        complaints.remove(at: index)
                                    }
                                }, label: {
                                    Image(systemName: "trash")
                                })
                            }
                        }
                        .onDelete(perform: deleteComplaints)
                
                                HStack {
                                    TextField("Add Complaint", text: $newComplaint)
                                    Button(action: {
                                        // Action to add complaint
                                        complaints.append(newComplaint)
                                        newComplaint = ""
                                    }, label: {
                                        Image(systemName: "plus.circle.fill")
                                            .foregroundColor(.blue)
                                            .font(.title)
                                    })
                                }
                    
                    Text("Diagnosis")
                        .font(.title)
                        .padding(.bottom, 10)
                    
                    TextEditor(text: $diagnosis)
                        .frame(maxHeight: 100)
                        .border(Color.gray, width: 1)
                                
                }
            }
            .onAppear{
                FirebaseHelperFunctions().getMedicalRecords(patientUID: patientUID) { medicalRecord, error in
                    self.patientMedicalRecords = medicalRecord
                }
                FirebaseHelperFunctions().fetchPatientData(by: patientUID) { patientData, error in
                    if let name = patientData?.name{
                        self.patientName = name
                    }
                }
            }
        }
    }
    
    func deleteComplaints(at offsets: IndexSet) {
        complaints.remove(atOffsets: offsets)
    }
}

#Preview {
    PatientDetailsAppointmentView(patientUID:"Vzo9cLiS9fZTyzpzkeH0Vure5YP2", slotTime: "09:00 AM")
}
