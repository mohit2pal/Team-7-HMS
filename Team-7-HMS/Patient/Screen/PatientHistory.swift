//
//  PatientHistory.swift
//  Team-7-HMS
//
//  Created by Ritwatz on 23/04/24.
//

import SwiftUI

struct PatientHistory: View {
    
    @State var uid : String
    @State private var dateOfBirth = Date()
    @State private var selectedGenderIndex = 0
    @State private var selectedBloodGroupIndex = 0
    @State private var height = ""
    @State private var weight = ""
    @State private var experience = 0
    @State private var selectedMedicalIndex = 0
    @State private var phoneNumber = ""
    @State private var adhaarNumber = ""
    @State private var medicalHistory = ""
    @State private var isEditingPhoneNumber = false
    
    let genders = ["Male", "Female", "Other"]
    let bloodGroup = ["Unknown", "O+", "O-", "A+", "A-", "B+", "B-", "AB+", "AB-"]
    
    @State private var selectedMedicalHistories: [String] = []
    @State private var otherMedicalHistories : [String] = []
    @State private var medicalConditionStatus: [Bool] = Array(repeating: false, count: medicalConditions.count)
    
    @State var hadSurgery : Bool = false
    
    @State private var newMedicalProblem = ""
    
    @State private var surgeries: [String] = []
    @State private var newSurgery = ""
    
    @State private var allergies: [String] = []
    @State private var newAllergy = ""
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd - MM - yyyy"
        return formatter
    }
    
    var body: some View {
        
        ScrollView {
            LazyVStack {
                Spacer()
                HStack {
                    Spacer()
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 130 , height: 130)
                    Spacer()
                }
                
                Section() {
                    HStack{
                        DatePicker("Date of Birth", selection: $dateOfBirth, displayedComponents: .date)
                            .foregroundColor(Color.gray)
                    }
                    .padding(.horizontal)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .border(Color.gray.opacity(0.2))
                    
                    Picker("Gender", selection: $selectedGenderIndex) {
                        ForEach(0..<genders.count, id: \.self) {
                            Text(genders[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.vertical)
                    
                    HStack {
                        Text("Blood Group")
                            .foregroundColor(Color.gray)
                        Spacer()
                        Picker("", selection: $selectedBloodGroupIndex) {
                            ForEach(0..<bloodGroup.count, id: \.self) {
                                Text(bloodGroup[$0])
                            }
                        }
                        .pickerStyle(MenuPickerStyle()) // Dropdown style
                        .padding(.vertical)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .padding(.horizontal)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .border(Color.gray.opacity(0.2))
                    
                    TextField("Height(in cm)", text: $height)
                        .foregroundColor(height.isEmpty ? .gray.opacity(0.5) : .black)
                        .padding(.vertical)
                        .padding(.horizontal)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .border(Color.gray.opacity(0.2))
                        .onChange(of: height) { newValue in
                            // Check if the newValue contains only numbers
                            let filtered = newValue.filter { "0123456789".contains($0) }
                            // Limit the length of the filtered string to 10 characters
                            if filtered.count > 3 {
                                height = String(filtered.prefix(3))
                            } else {
                                height = filtered
                            }
                        }
                    
                    TextField("Weight(in Kg)", text: $weight)
                        .foregroundColor(height.isEmpty ? .gray.opacity(0.5) : .black)
                        .padding(.vertical)
                        .padding(.horizontal)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .border(Color.gray.opacity(0.2))
                        .onChange(of: weight) { newValue in
                            // Check if the newValue contains only numbers
                            let filtered = newValue.filter { "0123456789".contains($0) }
                            // Limit the length of the filtered string to 10 characters
                            if filtered.count > 3 {
                                weight = String(filtered.prefix(3))
                            } else {
                                weight = filtered
                            }
                        }
                    
                    TextField("Phone Number", text: $phoneNumber)
                        .keyboardType(.namePhonePad)
                        .foregroundColor(height.isEmpty ? .gray.opacity(0.5) : .black)
                        .padding(.vertical)
                        .padding(.horizontal)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .border(Color.gray.opacity(0.2))
                        .onChange(of: phoneNumber) { newValue in
                            // Check if the newValue contains only numbers
                            let filtered = newValue.filter { "0123456789".contains($0) }
                            // Limit the length of the filtered string to 10 characters
                            if filtered.count > 10 {
                                phoneNumber = String(filtered.prefix(10))
                            } else {
                                phoneNumber = filtered
                            }
                        }
                    TextField("Adhaar Number", text: $adhaarNumber)
                        .keyboardType(.namePhonePad)
                        .foregroundColor(height.isEmpty ? .gray.opacity(0.5) : .black)
                        .padding(.vertical)
                        .padding(.horizontal)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .border(Color.gray.opacity(0.2))
                        .onChange(of: adhaarNumber) { newValue in
                            // Check if the newValue contains only numbers
                            let filtered = newValue.filter { "0123456789".contains($0) }
                            // Limit the length of the filtered string to 12 characters
                            if filtered.count > 12 {
                                adhaarNumber = String(filtered.prefix(12))
                            } else {
                                adhaarNumber = filtered
                            }
                        }
                    
                    

                    
                    Divider()
                    
                    Section(header: Text("Past Medical History")
                        .font(.headline)
                        .frame(alignment: .leading)
                        .multilineTextAlignment(.leading)) {
                            ForEach(medicalConditions.indices, id: \.self) { index in
                                Toggle(medicalConditions[index], isOn: $medicalConditionStatus[index])
                            }
                        }
                    
                    Section() {
                            ForEach(otherMedicalHistories, id: \.self) { allergy in
                                HStack{
                                    Text(allergy)
                                    Spacer()
                                }
                            }
                            HStack {
                                TextField("If others, mention here", text: $newMedicalProblem)
                                    .padding(.vertical)
                                Button(action: {
                                    
                                    otherMedicalHistories.append(newMedicalProblem)
                                    newMedicalProblem = ""
                                    print(otherMedicalHistories)
                                }) {
                                    Image(systemName: "plus.circle.fill")
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                    
                    Divider()
                    
                    Section(header: Text("Past Surgical History")
                        .font(.headline)
                        .frame(alignment: .leading)
                        .multilineTextAlignment(.leading)) {
                            Toggle("Have you ever had Surgery ? ", isOn: $hadSurgery)
                            
                            
                            if hadSurgery {
                                
                                ForEach(surgeries, id: \.self) { surgery in
                                    HStack{
                                        Text(surgery)
                                        Spacer()
                                    }
                                }
                                
                                HStack {
                                    TextField("Add New Surgery", text: $newSurgery)
                                    Button(action: {
                                        if !newSurgery.isEmpty {
                                            surgeries.append(newSurgery)
                                            newSurgery = ""
                                        }
                                    }) {
                                        Image(systemName: "plus.circle.fill")
                                            .foregroundColor(.blue)
                                    }
                                }
                                
                            }
                        }
                    
                    Divider()
                    
                    Section(header: Text("Allergies to Medications")
                        .font(.headline)
                        .frame(alignment: .leading)
                        .multilineTextAlignment(.leading)) {
                            ForEach(allergies, id: \.self) { allergy in
                                HStack{
                                    Text(allergy)
                                    Spacer()
                                }
                            }
                            HStack {
                                TextField("Add New Allergy", text: $newAllergy)
                                Button(action: {
                                    
                                    allergies.append(newAllergy)
                                    newAllergy = ""
                                    print(allergies)
                                }) {
                                    Image(systemName: "plus.circle.fill")
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                    
                }
                
            }
            .padding(.vertical)
            .padding(.horizontal)
            .navigationTitle("Patients Medical History")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        collectMedicalHistories()
                        
                        print(selectedMedicalHistories)
//                        FirebaseHelperFunctions().addPatientsRecords(
//                                    uuid: uid,
//                                    dateOfBirth: dateOfBirth,
//                                    gender: genders[selectedGenderIndex],
//                                    bloodGroup: bloodGroup[selectedBloodGroupIndex],
//                                    height: height,
//                                    weight: weight,
//                                    phoneNumber: phoneNumber,
//                                    pastMedicalHistory: selectedMedicalHistories,
//                                    surgeries: surgeries,
//                                    alergies: allergies
//                                )
                        
                    }, label: {
                        Text("Done")
                            .foregroundColor(Color.accentColor)
                    })
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
    

    private func collectMedicalHistories() {
        selectedMedicalHistories = medicalConditions.enumerated().compactMap { index, condition in
            medicalConditionStatus[index] ? condition : nil
        }
        
        selectedMedicalHistories = selectedMedicalHistories + otherMedicalHistories
    }
}

struct PatientHistory_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PatientHistory( uid : "hi")
        }
    }
}

