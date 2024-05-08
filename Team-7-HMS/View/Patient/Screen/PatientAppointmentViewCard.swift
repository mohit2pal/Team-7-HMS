//
//  PatientAppointmentViewCard.swift
//  Team-7-HMS
//
//  Created by Subha on 08/05/24.
//

import SwiftUI

struct PatientAppointmentViewCard: View {
    @State var appointment: AppointmentCardData
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                VStack{
                    HStack{
                        Text(appointment.doctorName)
                            .font(.title2)
                            .bold()
                            .foregroundColor(.black) // Added foregroundColor
                        
                        Spacer()
                        
                        Button(action: {
                            //Action to Perform
                        }, label: {
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.blue)
                        })
                    }
                    
                    HStack{
                        Text("ID : \(appointment.appointmentID.suffix(6))")
                            .padding(.bottom)
                            .foregroundStyle(Color.gray.opacity(0.9))
                            .foregroundColor(.black) // Added foregroundColor
                        Spacer()
                    }
                }
                Spacer()
            }
            HStack{
                Image(systemName: "calendar")
                    .foregroundColor(.black) // Added foregroundColor
                Text(appointment.date.replacingOccurrences(of: "_", with: "-"))
                    .foregroundColor(.black) // Added foregroundColor
                Spacer()
                Image(systemName: "clock")
                    .foregroundColor(.black) // Added foregroundColor
                Text(appointment.time)
                    .foregroundColor(.black) // Added foregroundColor
            }
            Spacer()
            VStack(alignment: .center) {
                Text("Visit the Hospital 15 minute before the booked time slot.")
                    .multilineTextAlignment(.center)
                    .font(.caption)
                    .foregroundColor(.black) // Added foregroundColor
            }
        }
        .frame(width: 330, height: 125 ,alignment: .leading)
        .padding()
        .multilineTextAlignment(.leading)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 1)
    }
}

#Preview {
    PatientAppointmentViewCard(appointment: AppointmentMockData.appointmentDataArray[0])
}
