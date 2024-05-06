//
//  test.swift
//  Team-7-HMS
//
//  Created by Ritwatz on 24/04/24.


import SwiftUI

struct DoctorAppointmentCard: View {
    var appointmentData: DoctorAppointmentCardData
    
    var body: some View {
        NavigationLink {
            ForDoctorPatientAppointentView(doctorAppointmentData: appointmentData)
        } label: {
            HStack(spacing: 10){
                Text(appointmentData.time)
                    .foregroundColor(.white)
                    .font(.title3)
                    .padding()
                    .frame(width: 90, height: 90)
                    .background(Color.myAccent)
                    .cornerRadius(50)
                    .foregroundColor(.white)
                HStack{
                    VStack(alignment: .leading, spacing: 5){
                        Text(appointmentData.patientName)
                            .foregroundColor(.black)
                            .font(.title3)
                            .padding(.init(top: 0, leading: 0, bottom: 1, trailing: 0))
                        Text("\(appointmentData.gender), \(appointmentData.age)")
                            .foregroundColor(.black)
                            .font(.title3)
    //                    Text("\(appointmentData.day), \(appointmentData.date), \(appointmentData.year)")
    //                        .foregroundColor(.black)
    //                        .font(.title3)
    //                    Text(appointmentData.time)
    //                        .foregroundColor(.black)
    //                        .font(.title3)
                    }//VStack End
                    Spacer() // Add Spacer to push the arrow to the right
                    NavigationLink(destination: ForDoctorPatientAppointentView(doctorAppointmentData: appointmentData)){
                        Image("Arrow")
                            .rotationEffect(.degrees(180))
                            .foregroundColor(Color("PrimaryColor"))
                    }
                }
                .padding()
                .background(.white)
                .cornerRadius(20)
                .customShadow()
            }//Hstack End
        }

    }
}

#Preview {
    NavigationStack{
        DoctorAppointmentCard(appointmentData: DoctorAppointmentMockData.doctorAppointmentDataArray[0])
    }
}
