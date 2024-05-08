//
//  patientAppointmentCard.swift
//  Team-7-HMS
//
//  Created by Vikashini G on 22/04/24.
//

import SwiftUI

struct patientAppointmentCard: View {
    var appointmentData: AppointmentCardData
    
    var body: some View {
        
        NavigationStack{
            NavigationLink {
                AppointmentDataView(appointmentID: appointmentData.appointmentID)
            } label: {
                HStack{
                    VStack{
                        Text("\(String(appointmentData.date.prefix(2)))")
                            .font(CentFont.mediumBold)
                        Text(appointmentData.day)
                            .font(CentFont.smallReg)
                    }
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 70, height: 70)
                    .background(Color.myAccent)
                    .cornerRadius(50)
                    
                    Spacer()
                        .frame(width: 30)
                    
                    //details
                    VStack(alignment: .leading){
                        Text(appointmentData.doctorName)
                            .font(.system(size: 23, weight: .semibold))
                        Text(appointmentData.doctorSpeciality)
                            .font(CentFont.mediumReg)
                        Text(appointmentData.time)
                            .font(CentFont.mediumReg)
                    }
                    .foregroundStyle(Color.black)
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                }
                .padding()
                //        .padding(.vertical, 10)
                .background(Color.white)
                .cornerRadius(28)
                .customShadow()

            }

        }
        
    }
}

#Preview {
    patientAppointmentCard(appointmentData: AppointmentMockData.appointmentDataArray[0])
}
