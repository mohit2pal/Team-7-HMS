//
//  ForDoctorPatientAppointentView.swift
//  Team-7-HMS
//
//  Created by Subha on 03/05/24.
//

import Foundation
import SwiftUI

struct ForDoctorPatientAppointentView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var appointmentData: AppointmentDataModel?
    @State var doctorAppointmentData: DoctorAppointmentCardData
    @State private var isLoading = true
    @State private var errorMessage: String?
    @State private var showPrescriptionSheet: Bool = false
    
    @State private var showMedicalHistorySheet: Bool = false // State to control the medical history sheet
    @State private var showOldPrescriptionSheet: Bool = false // State to cntrol old Prescription
    
    @State private var disableAppointmentDone: Bool = true // State to disable the ui button
    @State private var showSuccessAnimation = false // New state variable for showing the tick animation
    
    var body: some View {
        NavigationView {
            ZStack{
                Color.background.ignoresSafeArea()
                VStack(){
                    HStack{
                        VStack(alignment: .leading){
                            Text(doctorAppointmentData.patientName)
                                .font(.title2)
                            HStack{
                                Text(doctorAppointmentData.gender)
                                RoundedRectangle(cornerRadius: 50)
                                    .fill(Color(#colorLiteral(red: 0.8509804010391235, green: 0.8509804010391235, blue: 0.8509804010391235, alpha: 1)))
                                    .frame(width: 2, height: 20)
                                Text("\(doctorAppointmentData.age)")
                            }
                        }
                        Spacer()
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                    }
                    .padding()
                    .background(Color.myAccent)
                    .foregroundStyle(.white)
                    .cornerRadius(20)
                    
                    HStack{
                        Image(systemName: "calendar")
                            .foregroundColor(Color.myAccent)
                        Text(convertDateFormat(inputDate: doctorAppointmentData.date))
                        
                        Spacer()
                        
                        Image(systemName: "clock")
                            .foregroundColor(Color.myAccent)
                        Text(doctorAppointmentData.time)
                    }
                    .padding(.vertical)
                    
                    Text("You can access the symptoms and medical background of the patient here.")
                        .font(.callout)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.bottom)
                    
                    if let issues = appointmentData?.issues, !issues.isEmpty {
                        HStack{
                            VStack{
                                Text("Symptoms")
                                    .bold()
                                    .font(.title2)
                                
                                List{
                                    ForEach(issues, id: \.self) { issue in
                                        Text(issue)
                                    }
                                }
                                .frame(height: CGFloat(issues.count * 50))
                                .listStyle(.plain)
                                .background(Color.background)
                                .cornerRadius(10)
                                .customShadow()
                            }
                            .frame(alignment: .leading)
                            .multilineTextAlignment(.leading)
                            
                        }
                        Spacer()
                    } else {
                        VStack{
                            Text("Symptoms")
                                .bold()
                                .font(.title2)
                            
                            Text("You have not mentioned any symptom")
                                .font(.callout)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                                .padding(.bottom)
                        }
                    }
                    
                    Spacer()
                    
                    
                    if doctorAppointmentData.status == "completed" {
                        Button{
                            showOldPrescriptionSheet.toggle()
                        } label: {
                            HStack{
                                Spacer()
                                Image(systemName: "list.bullet.circle")
                                    .foregroundColor(.accentColor)
                                Text("Show prescription")
                                    .font(.headline)
                                    .foregroundStyle(Color.black)
                                Spacer()
                            }
                            .frame(width: 300, height: 50)
                            .background(Color.white)
                            .cornerRadius(20)
                            .customShadow()
                        }
                    } else {
                        Button{
                            showPrescriptionSheet.toggle()
                        } label: {
                            HStack{
                                Spacer()
                                Image(systemName: "plus")
                                    .foregroundColor(.blue)
                                Text("Write prescription")
                                    .font(.headline)
                                    .foregroundStyle(Color.black)
                                Spacer()
                            }
                            .frame(width: 300, height: 50)
                            .background(Color.white)
                            .cornerRadius(20)
                            .customShadow()
                        }
                        
                        Button(action: {
                            let firebaseHelper = FirebaseHelperFunctions()
                            
                            firebaseHelper.completeAppointment(appointmentID: doctorAppointmentData.appointmentID) { result in
                                switch result {
                                case .success():
                                    print("Appointment status updated successfully.")
                                    self.showSuccessAnimation = true
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                        self.showSuccessAnimation = false
                                        presentationMode.wrappedValue.dismiss()
                                    }
                                case .failure(let error):
                                    print("Error updating appointment status: \(error)")
                                }
                            }
                        }, label: {
                            Text("Appointment Done")
                                .frame(width: 300, height: 50)
                                .foregroundStyle(Color.white)
                                .background(disableAppointmentDone ? Color.gray : Color.myAccent)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                            
                        })
                        .disabled(disableAppointmentDone)
                        .fullScreenCover(isPresented: $showSuccessAnimation) {
                            SuccessAnimationView()
                        }
                    }
                }
                .padding([.top, .leading, .trailing], 25)
                .onAppear{
                    fetchAppointmentData()
                    fetchPrescriptionData()
                }
                .sheet(isPresented: $showPrescriptionSheet) {
                    if let appointment = appointmentData {
                        addPrescription(appointmentData: appointment, showPrescriptionSheet: $showPrescriptionSheet)
                    } else {
                        OldAppointment()
                    }
                }
                .sheet(isPresented: $showMedicalHistorySheet) {
                    MedicalRecordView(patientId: doctorAppointmentData.patientID)
                }
                .sheet(isPresented: $showOldPrescriptionSheet) {
                    ViewPrescription(showOldPrescriptionSheet: $showOldPrescriptionSheet, appointmentID: doctorAppointmentData.appointmentID)
                }
                .onChange(of: showPrescriptionSheet) { newValue in
                    if !newValue { // When showPrescriptionSheet changes to false
                        fetchPrescriptionData()
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Appointment Details") // Example title
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showMedicalHistorySheet.toggle()
                }) {
                    Image(systemName: "folder")
                }
            }
        }
    }
    
    private func convertDateFormat(inputDate: String) -> String {
        // Create a DateFormatter to parse the input date string
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "dd_MM_yyyy"
        
        // Convert the input string to a Date object
        guard let date = inputFormatter.date(from: inputDate) else {
            // Handle the case where the date conversion fails
            print("Invalid date format")
            return ""
        }
        
        // Create another DateFormatter to format the Date object into the desired output string
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd-MM-yyyy"
        
        // Convert the Date object to the desired output date string format
        let outputDate = outputFormatter.string(from: date)
        
        return outputDate
    }
    
    private func fetchAppointmentData() {
        let firebaseHelper = FirebaseHelperFunctions()
        firebaseHelper.fetchAppointmentData(appointmentID: doctorAppointmentData.appointmentID) { appointmentDataModel, error in
            DispatchQueue.main.async {
                isLoading = false
                if let error = error {
                    self.errorMessage = error.localizedDescription
                } else if let appointmentDataModel = appointmentDataModel {
                    self.appointmentData = appointmentDataModel
                } else {
                    self.errorMessage = "Failed to load appointment data."
                }
            }
        }
    }
    
    private func fetchPrescriptionData() {
            // Assuming FirebaseHelperFunctions is the class where fetchPrescription is defined
            let firebaseHelper = FirebaseHelperFunctions()
        firebaseHelper.fetchPrescription(appointmentID: doctorAppointmentData.appointmentID) { result in
                switch result {
                case .success(let prescription):
                    disableAppointmentDone = false
                case .failure(let error):
                    disableAppointmentDone = true
                }
            }
        }
}

#Preview{
    ForDoctorPatientAppointentView(doctorAppointmentData: DoctorAppointmentMockData.doctorAppointmentDataArray[0])
}
