//
//  test.swift
//  Team-7-HMS
//
//  Created by Ritwatz on 24/04/24.


import SwiftUI

struct DoctorAppointmentCard: View {
    var appointmentData: DoctorAppointmentCardData
    var body: some View {
                HStack(spacing: 10) {
                    // Left Circular Card with Time
                    Circle()
                        .fill(Color.myAccent)
                        .frame(width: 100, height: 100)
                        .overlay(
                            Text(appointmentData.time)
                                .foregroundColor(.white)
                                .font(.headline)
                        )
        
                    // Right Rectangular Card with Patient Information
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.myAccent)
                        .frame(height: 100)
                        .overlay(
                            HStack {
                                VStack(alignment: .leading, spacing: 5){
                                    Text(appointmentData.patientName)
                                        .foregroundColor(.white)
                                        .font(.headline)
                                    Text("\(appointmentData.gender), \(appointmentData.age)")
                                        .foregroundColor(.white)
                                        .font(.subheadline)
                                    Text("\(appointmentData.day), \(appointmentData.date), \(appointmentData.year)")
                                        .foregroundColor(.white)
                                        .font(.subheadline)
                                }//VStack End
                                Spacer() // Add Spacer to push the arrow to the right
        
                                Image(systemName: "greaterthan")
                                    .foregroundColor(.white) // Set arrow color to white
                                    .font(.headline)
                            }//Hstack End
                            .padding()
                        )
                }
                .padding()
                .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    DoctorAppointmentCard(appointmentData: DoctorAppointmentMockData.doctorAppointmentDataArray[0])
}
