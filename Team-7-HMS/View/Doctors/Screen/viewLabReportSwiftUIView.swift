//
//  viewLabReportSwiftUIView.swift
//  Team-7-HMS
//
//  Created by Vikashini G on 02/05/24.
//

import SwiftUI

struct viewLabReportSwiftUIView: View {
    @State var appointmentData: DoctorAppointmentCardData

    var body: some View {
        VStack(spacing: 20){
            HStack{
                VStack(alignment: .leading, spacing: 10){
                    Text(appointmentData.patientName)
                        .font(.title2)
                    HStack{
                        Text(appointmentData.gender)
                        RoundedRectangle(cornerRadius: 50)
                            .fill(Color(#colorLiteral(red: 0.8509804010391235, green: 0.8509804010391235, blue: 0.8509804010391235, alpha: 1)))
                            .frame(width: 2, height: 20)
                        Text("\(appointmentData.age)")
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
                Text("Appointment Date")
                    .font(.headline)
                Spacer()
                Text("\(appointmentData.day), \(appointmentData.date)")
                    .font(.subheadline)
                    .padding(10)
                    .padding(.horizontal, 10)
                    .background(Color.init(UIColor.systemGray5))
                    .cornerRadius(50)
            }
            
            HStack{
                Text("Appointment Time")
                    .font(.headline)
                Spacer()
                Text("\(appointmentData.time)")
                    .font(.subheadline)
                    .padding(10)
                    .padding(.horizontal, 10)
                    .background(Color.init(UIColor.systemGray5))
                    .cornerRadius(50)
            }
            VStack{
                HStack{
                    Text("Patient History")
                        .font(.headline)
                    Spacer()
                }
                List{
                    Text("thisIsASample.pdf")
                    Text("anotherSample.pdf")
                }
                .listStyle(.plain)
                .foregroundStyle(.blue)
                .padding(.horizontal)
                .background(Color.white)
                .cornerRadius(20)
                .customShadow()
            }
            
            Spacer()
            
//            NavigationLink(destination: ViewPrescription){
//                HStack{
//                    Spacer()
//                    Image(systemName: "plus")
//                        .foregroundColor(.blue)
//                    Text("Write prescription")
//                        .font(.headline)
//                        .foregroundStyle(Color.black)
//                    Spacer()
//                }
//                .padding()
//                .background(Color.white)
//                .cornerRadius(20)
//                .customShadow()
//            }
            
            Button(action: {
                if appointmentData.status == "Upcoming" {
                    appointmentData.status = "Completed"
                }
            }) {
                Spacer()
                Text("Mark Appointment Done")
                    .foregroundColor(.white)
                    .font(.headline)
                Spacer()
            }
            .padding()
            .background(appointmentData.status == "Upcoming" ? Color.myAccent : Color.gray)
            .cornerRadius(20)
        }
        .padding()
        .navigationTitle("Patient Details")
        .background(Color.background)
    }
}

#Preview {
    viewLabReportSwiftUIView(appointmentData: DoctorAppointmentMockData.doctorAppointmentDataArray[0])
}
