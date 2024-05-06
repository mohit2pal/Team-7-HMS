//
//  ForDoctorPatientAppointentView.swift
//  Team-7-HMS
//
//  Created by Subha on 03/05/24.
//

import Foundation
import SwiftUI

struct ForDoctorPatientAppointentView: View {
    @State private var appointmentData: AppointmentDataModel?
    @State var doctorAppointmentData: DoctorAppointmentCardData
    @State private var isLoading = true
    @State private var errorMessage: String?
    @State private var showPrescriptionSheet: Bool = false
    
    @State private var showMedicalHistorySheet: Bool = false // State to control the medical history sheet
    
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
                        Text(convertDateFormat(inputDate: doctorAppointmentData.date))
                        
                        Spacer()
                        
                        Image(systemName: "clock")
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
                                Text("Problems Mentioned")
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
                        .frame(width: 300)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(20)
                        .customShadow()
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                    
                    Button(action: {}, label: {
                        Text("Appointment Done")
                            .frame(width: 300)
                            .padding()
                            .foregroundStyle(Color.white)
                            .background(Color.green)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        
                    })
                }
                .padding([.top, .leading, .trailing], 25)
                .onAppear{
                    fetchAppointmentData()
                }
                .sheet(isPresented: $showPrescriptionSheet) {
                    ViewPrescription(appointmentData: AppointmentMockData.appointmentDataArray[0])
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
}

#Preview{
    ForDoctorPatientAppointentView(doctorAppointmentData: DoctorAppointmentMockData.doctorAppointmentDataArray[0])
}
