//
//  patientHomeSwiftUIView.swift
//  Team-7-HMS
//
//  Created by Vikashini G on 22/04/24.
//

import SwiftUI
import FirebaseAuth

struct patientHomeSwiftUIView: View {
    @ObservedObject var healthkit = HealthKitManager()
    @State var userName: String
    @State var userHeight: Int
    @State var userWeight: Int
    @State var userHeart: Int
    @State var userSleep: Int
    var body: some View {
        VStack{
            //header
            HStack(alignment: .top){
                Button {
                    signOut()
                } label: {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 70, height: 70)
                        .foregroundColor(.gray)
                        .padding(.trailing)
                }
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
                
                if !healthkit.isWatchConnected {
                    VStack(alignment: .center){
                        Text("heart")
                            .font(CentFont.smallReg)
                            .foregroundStyle(.gray)
                        Image(systemName: "heart.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 30)
                            .foregroundStyle(Color.red)
                            .scaleEffect(1.1) // Initial scale
                            
                        HStack(alignment: .bottom){
                            Text(String(format: "%.1f", healthkit.heartRate))
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
                
                else{
                    VStack{
                        HStack{
                            Spacer()
                            Image(systemName: "applewatch")
                                .resizable()
                                .frame(width: 30 , height: 36)
                            Spacer()
                        }
                        Text("Disconnected")
                    }
                    .foregroundStyle(Color.red)
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
        .onAppear{
            healthkit.startObservingHeartRate()
        }
        .padding()
        .background(Color.background)
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            print("User signed out successfully")
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError.localizedDescription)")
        }
    }
}

#Preview {
    patientHomeSwiftUIView(userName: "Bose", userHeight: 160, userWeight: 60, userHeart: 77, userSleep: 8)
}
