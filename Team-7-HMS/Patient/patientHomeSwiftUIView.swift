//
//  patientHomeSwiftUIView.swift
//  Team-7-HMS
//
//  Created by Vikashini G on 22/04/24.
//

import SwiftUI

struct patientHomeSwiftUIView: View {
    @State var userName: String
    @State var userHeight: Int
    @State var userWeight: Int
    @State var userHeart: Int
    @State var userSleep: Int
    var body: some View {
        VStack{
            //header
            HStack(alignment: .top){
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .foregroundColor(.gray)
                    .padding(.trailing)
                VStack(alignment: .leading){
                    Text("Hello 👋")
                        .font(CentFont.mediumReg)
                    Text(userName)
                        .font(CentFont.largeSemiBold)
                }
                Spacer()
                NavigationLink(destination: patientNotificationSwiftUIView()) {
                    Button(action: {
                        // Handle button action here if needed
                    }) {
                        Image(systemName: "bell.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 24)
                            .foregroundColor(.myAccent)
                    }
                }
            }
            
            
            Spacer()
                .frame(height: 30)
            
            
            //vitals
            HStack{
                Text("Vitals")
                    .font(CentFont.mediumReg)
                Spacer()
            }
            HStack{
                VStack(alignment: .center){
                    Text("height")
                        .font(CentFont.smallReg)
                        .foregroundStyle(.gray)
                    Image(systemName: "figure.stand")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 30)
                        .foregroundStyle(.myAccent)
                    HStack(alignment: .bottom){
                        Text("\(userHeight)")
                            .font(CentFont.mediumSemiBold)
                        Text("cm")
                            .font(CentFont.smallReg)
                            .foregroundStyle(.gray)
                    }
                }
                Spacer()
                RoundedRectangle(cornerRadius: 50)
                    .foregroundStyle(.gray)
                    .frame(width: 2, height: 33)
                Spacer()
                VStack(alignment: .center){
                    Text("weight")
                        .font(CentFont.smallReg)
                        .foregroundStyle(.gray)
                    Image(systemName: "figure")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 30)
                        .foregroundStyle(.myAccent)
                    HStack(alignment: .bottom){
                        Text("\(userWeight)")
                            .font(CentFont.mediumSemiBold)
                        Text("kg")
                            .font(CentFont.smallReg)
                            .foregroundStyle(.gray)
                    }
                }
                Spacer()
                RoundedRectangle(cornerRadius: 50)
                    .foregroundStyle(.gray)
                    .frame(width: 2, height: 33)
                Spacer()
                VStack(alignment: .center){
                    Text("heart")
                        .font(CentFont.smallReg)
                        .foregroundStyle(.gray)
                    Image(systemName: "heart.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 30)
                        .foregroundStyle(.myAccent)
                    HStack(alignment: .bottom){
                        Text("\(userHeart)")
                            .font(CentFont.mediumSemiBold)
                        Text("bpm")
                            .font(CentFont.smallReg)
                            .foregroundStyle(.gray)
                    }
                }
                Spacer()
                RoundedRectangle(cornerRadius: 50)
                    .foregroundStyle(.gray)
                    .frame(width: 2, height: 33)
                Spacer()
                VStack(alignment: .center){
                    Text("sleep")
                        .font(CentFont.smallReg)
                        .foregroundStyle(.gray)
                    Image(systemName: "zzz")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 30)
                        .foregroundStyle(.myAccent)
                    HStack(alignment: .bottom){
                        Text("\(userSleep)")
                            .font(CentFont.mediumSemiBold)
                        Text("hrs")
                            .font(CentFont.smallReg)
                            .foregroundStyle(.gray)
                    }
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .customShadow()
            
            Spacer()
                .frame(height: 30)
            
            //apointments upcoming
            HStack{
                Text("Upcoming appointments")
                    .font(CentFont.mediumReg)
                Spacer()
            }
            
            //Data modelling is done on appointmentCardDataM
            ScrollView(.vertical, showsIndicators: false){
                VStack(spacing: 10){
                    ForEach(AppointmentMockData.appointmentDataArray) { appointment in patientAppointmentCard(appointmentData: appointment)
                    }
                }
            }.customShadow()
            
            Spacer()
        }//Vstack end
        .padding()
        .background(Color.background)
    }
}

#Preview {
    patientHomeSwiftUIView(userName: "Bose", userHeight: 160, userWeight: 60, userHeart: 77, userSleep: 8)
}
