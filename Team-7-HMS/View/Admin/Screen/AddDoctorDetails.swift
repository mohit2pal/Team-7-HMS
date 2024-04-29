//
//  AddDoctorDetails.swift
//  Team-7-HMS
//
//  Created by Meghs on 22/04/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct AddDoctorDetails: View {
    @State private var name : String = ""
    @State private var email : String = ""
    @State private var dateOfJoining : Date = Date()
    @State private var experience: Int = 0
    @State private var selectedGenderIndex = 0
    @State private var selectedSpecialtyIndex = 0
    @State private var selectedMedicalIndex = 0
    @State private var phoneNumber : String = ""
    @State private var password : String = ""
    let genders = ["Male", "Female", "Other"]
    let specialties = [
        "General Physician",
        "Obstetrics & Gynaecology",
        "Orthopaedics",
        "Urology",
        "Paediatrics",
        "Cardiology",
        "Dermatology",
        "ENT"
    ]
    
    let medicalDegrees = [
        "MD (Doctor of Medicine)",
        "MBBS (Bachelor of Medicine, Bachelor of Surgery)",
        "DO (Doctor of Osteopathic Medicine)",
        "DDS/DMD (Doctor of Dental Surgery/Doctor of Dental Medicine)",
        "PharmD (Doctor of Pharmacy)",
        "DVM (Doctor of Veterinary Medicine)",
        "DC (Doctor of Chiropractic)",
        "DPT (Doctor of Physical Therapy)",
        "PsyD (Doctor of Psychology)",
        "DNP (Doctor of Nursing Practice)"
    ]

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd - MM - yyyy"
        return formatter
    }
    
    @State var docId : String = ""
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .foregroundStyle(Color.gray)
                    .frame(width: 120 , height: 120)
                Spacer()
            }
            //            List{
            Section() {
                TextField("Full Name", text: $name)
                    .textFieldStyle(.plain)
                    .padding()
                    .background(.white)
                    .cornerRadius(10)
                    .customShadow()
                TextField("Email Address", text: $email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .textFieldStyle(.plain)
                    .padding()
                    .background(.white)
                    .cornerRadius(10)
                    .customShadow()
                
                TextField("Phone Number", text: $phoneNumber)
                    .keyboardType(.namePhonePad)
                    .textFieldStyle(.plain)
                    .padding()
                    .background(.white)
                    .cornerRadius(10)
                    .customShadow()
                
                HStack{
                    //                    TextField("Date of Joining", text: Binding(
                    //                        get: { dateFormatter.string(from: dateOfJoining) },
                    //                        set: { newValue in
                    //                            if let newDate = dateFormatter.date(from: newValue) {
                    //                                dateOfJoining = newDate
                    //                            }
                    //                        })
                    //                    )
                    Text("Date of Joining")
                    
                    DatePicker("", selection: $dateOfJoining, displayedComponents: .date)
                        .foregroundStyle(Color.gray)
                }
                .foregroundStyle(Color.gray.opacity(0.5))
                .padding()
                .clipShape(RoundedRectangle(cornerRadius: 20))
//                .border(Color.gray.opacity(0.2))
                .background(Color.white)
                .cornerRadius(10)
                .customShadow()
                
                HStack{
                    Text("Select Speciality")
                        .foregroundStyle(Color.gray)
                    
                    Spacer()
                    
                    Picker("Speciality", selection: $selectedSpecialtyIndex) {
                        ForEach(0..<specialties.count, id: \.self) {
                            Text(specialties[$0])
                        }
                    }
                    .pickerStyle(MenuPickerStyle()) // Dropdown style
                    .padding(.vertical)  .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding(.horizontal)
                .clipShape(RoundedRectangle(cornerRadius: 20))
//                .border(Color.gray.opacity(0.2))
                .background(Color.white)
                .cornerRadius(10)
                .customShadow()
                
                Picker("Gender", selection: $selectedGenderIndex) {
                    ForEach(0..<genders.count, id: \.self) {
                        Text(genders[$0])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.vertical)
                
                
                HStack{
                    Text("Degree")
                        .foregroundStyle(Color.gray)
                    
                    Spacer()
                    
                    Picker("", selection: $selectedMedicalIndex) {
                        ForEach(0..<medicalDegrees.count, id: \.self) {
                            Text(medicalDegrees[$0])
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding(.vertical)  .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding(.horizontal)
                .clipShape(RoundedRectangle(cornerRadius: 20))
//                .border(Color.gray.opacity(0.2))
                .background(Color.white)
                .cornerRadius(10)
                .customShadow()
                
                
                HStack {
                    Text("Experience")
                    Spacer()
                    Stepper(value: $experience, in: 0...100) {
                        Text("\(experience) years")
                            .foregroundStyle(Color.black)
                    }
                }
                .foregroundStyle(Color.gray)
                .padding(.horizontal)
                .padding(.vertical)
                .background(Color.white)
                .cornerRadius(10)
                .customShadow()
//                .border(Color.gray.opacity(0.2))
            }
            .textFieldStyle(.roundedBorder)
            .padding(.horizontal)
            Spacer()
        }
        .background(Color.background)
        .navigationTitle("Add Doctors")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    password = generateRandomPassword(length: 10)
                    FirebaseHelperFunctions().registerUser(email: email, password: password ) { result in
                        switch result {
                        case .success(let uid):
                            print("User registered successfully. UID: \(uid)")
                            
                            print(password)
                            print(email)
                            
                            self.docId = uid
                            
                            FirebaseHelperFunctions().addDoctorDetails(name : name , email : email , dateOfJoining : dateOfJoining , experience : experience , selectedGenderIndex : selectedGenderIndex , selectedSpecialtyIndex : selectedSpecialtyIndex, medicalDegree: selectedMedicalIndex , phoneNumber :  phoneNumber, docId: docId )
                            
                            let emailTemplate = """
                                                Dear Dr. \(name),
                                                
                                                We are delighted to welcome you to the UrHealth team! As part of your onboarding process, we're providing you with your account credentials.
                                                
                                                Email: \(email)
                                                Password: \(password)
                                                
                                                Please keep these credentials secure and do not share them with anyone. If you have any questions or need assistance, feel free to reach out to our support team.
                                                
                                                Feel free to change your password later on.
                                                
                                                Thank you for joining us, and we look forward to working together to provide exceptional healthcare services to our patients.
                                                
                                                Best regards,
                                                """
                            
                            EmailFunction.sendEmail(subject: "Welcome To UrHealth", body: emailTemplate, to: email)
                            
                        case .failure(let error):
                            print("Error registering user: \(error.localizedDescription)")
                        }
                    }
                    
                }, label: {
                    HStack{
                        Text("Done")
                    }
                        .foregroundStyle(Color.accentColor)
                })
            }
        }
    }
}

#Preview {
    NavigationStack{
        AddDoctorDetails()
    }
}
