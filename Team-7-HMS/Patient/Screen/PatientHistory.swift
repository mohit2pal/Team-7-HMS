//
//  PatientHistory.swift
//  Team-7-HMS
//
//  Created by Ritwatz on 23/04/24.
//

import SwiftUI

struct PatientHistory: View {
    
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
    @State private var isEditingPhoneNumber = false // Track whether the phone number field is being edited
    
    let genders = ["Male", "Female", "Other"]
    let bloodGroup = ["Unknown", "O+", "O-", "A+", "A-", "B+", "B-", "AB+", "AB-"]
    
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd - MM - yyyy"
        return formatter
    }
    
    var body: some View {
        LazyVStack {
            Spacer()
            HStack {
                Spacer()
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 130 , height: 130)
                Spacer()
            }
            
            Section("Patient History") {
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
                VStack(alignment: .leading) { // Align text to the left edge
                                    Text("Medical History Summary")
                                        .foregroundColor(Color.gray)
                                    TextEditor(text: $medicalHistory)
                        .foregroundColor(height.isEmpty ? .gray.opacity(0.5) : .black)
                                        .padding(.vertical)
                                        .padding(.horizontal)
                                        .frame(minHeight: 100) // Set a minimum height for the text editor
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                        .border(Color.gray.opacity(0.2))
                                }
                                .padding(.horizontal)
                            }
                            .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .padding(.vertical)
        .padding(.horizontal)
        .navigationTitle("Add Patients History")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    // Perform your action here
                }, label: {
                    Text("Done")
                        .foregroundColor(Color.accentColor)
                })
            }
        }
    }
}

struct PatientHistory_Previews: PreviewProvider {
    static var previews: some View {
        PatientHistory()
    }
}

