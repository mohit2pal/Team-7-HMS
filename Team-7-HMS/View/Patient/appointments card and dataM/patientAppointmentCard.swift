//
//  patientAppointmentCard.swift
//  Team-7-HMS
//
//  Created by Vikashini G on 22/04/24.
//

import SwiftUI

struct patientAppointmentCard: View {
    var appointmentData: appointmentCardDataM
    
    var body: some View {
        HStack{
            //date day
            VStack{
                Text("\(appointmentData.date)")
                    .font(CentFont.mediumBold)
                Text(appointmentData.day)
                    .font(CentFont.smallReg)
            }
            .foregroundColor(.white)
            .padding()
            .frame(width: 90, height: 90)
            .background(Color.myAccent)
            .cornerRadius(50)
            
            Spacer()
                .frame(width: 30)
            
            //details
            VStack(alignment: .leading){
                Text(appointmentData.time)
                    .font(CentFont.mediumReg)
                Text(appointmentData.doctorName)
                    .font(.system(size: 23, weight: .semibold))
                Text(appointmentData.doctorSpeciality)
                    .font(CentFont.mediumReg)
            }
            Spacer()
        }
        .padding()
//        .padding(.vertical, 10)
        .background(Color.white)
        .cornerRadius(28)
        .customShadow()
    }
        
}

//#Preview {
//    patientAppointmentCard(appointmentData: appointmentMockData.appointmentMockDatas)
//}
