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
                    
                    // Right Rectangular Card with Patient Information
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white)
                        .frame(width: .infinity, height: 130)
                        .shadow(color: Color("PrimaryColor").opacity(0.4), radius: 3, x: 0, y: 0)
                        .overlay(
                            HStack {
                                VStack(alignment: .leading, spacing: 5){
                                    Text(appointmentData.patientName)
                                        .foregroundColor(.black)
                                        .font(.title2)
                                        .padding(.init(top: 0, leading: 0, bottom: 1, trailing: 0))
                                    Text("\(appointmentData.gender), \(appointmentData.age)")
                                        .foregroundColor(.black)
                                        .font(.title3)
                                    Text("\(appointmentData.day), \(appointmentData.date), \(appointmentData.year)")
                                        .foregroundColor(.black)
                                        .font(.title3)
                                    Text(appointmentData.time)
                                        .foregroundColor(.black)
                                        .font(.title3)
                                }//VStack End
                                Spacer() // Add Spacer to push the arrow to the right
                                VStack{
                                    Image("Arrow")
                                        .rotationEffect(.degrees(180))
                                        .foregroundColor(Color("PrimaryColor"))
                                    Spacer()
                                    
                                }
                            }//Hstack End
                            .padding()
                        )
//
                }
//                .customShadow()
    }
}

#Preview {
    DoctorAppointmentCard(appointmentData: DoctorAppointmentMockData.doctorAppointmentDataArray[0])
}
