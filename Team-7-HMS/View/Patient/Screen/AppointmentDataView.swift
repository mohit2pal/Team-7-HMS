//
//  AppointmentDataView.swift
//  Team-7-HMS
//
//  Created by Meghs on 02/05/24.
//

import SwiftUI

struct AppointmentDataView: View {
    var appointmentID : String
    @State var data : AppointmentData?
    @State var imageName : String = ""
    @State var isLoading : Bool  = false
    @State var deleted  :Bool = false
    @State var showAlert: Bool = false
    var body: some View {
        
        NavigationStack{
            ZStack{
                Color.background.ignoresSafeArea()
                VStack{
                    HStack{
                        Image(imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100 , height: 100)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(Color.black, lineWidth: 2)
                            )
                        
                        Spacer()
                        
                        VStack(alignment: .leading){
                            Text("Dr. \(data?.doctorName ?? "Doctor Name")")
                                .font(.title2)
                                .bold()
                            
                            Text(data?.doctorSpeciality ?? "Speaciality")
                                .bold()
                        }
                        
                        Spacer()
                    }
                    
                    Divider()
                    
                    HStack{
                        Image(systemName: "calendar")
                            .foregroundColor(.myAccent)
                        Text(data?.date ?? "Date of Appointment")
                        
                        Spacer()
                        
                        Image(systemName: "clock")
                            .foregroundColor(.myAccent)
                        Text(data?.time ?? "time")
                    }
                    .padding(.vertical)
                    
                    Text("Please arrive 15 minutes before your appointment time for quick and efficient service.")
                        .font(.callout)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.bottom)
                    
                    if let issues = data?.issues, !issues.isEmpty {
                        HStack{
                            VStack{
                                Text("Symptoms")
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
                    }
                    else {
                        VStack{
                            Text("Symptoms")
                                .bold()
                                .font(.title2)
                            
                            Text("You have not mentioned any problems")
                                .font(.callout)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                                .padding(.bottom)
                        }
                    }
                    
                    
                    Spacer()
                    
                    Button(action: {}, label: {
                        Text("Reschedule")
                            .frame(width: 300)
                            .padding()
                            .foregroundStyle(Color.white)
                            .background(.myAccent)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    })
                    
                    Button(action: {
                        showAlert = true
                    }, label: {
                        
                        if isLoading{
                            ProgressView()
                        }
                        else {
                            
                            if deleted {
                                Text("Appointment Canceled")
                                    .frame(width: 300)
                                    .padding()
                                    .foregroundStyle(Color.white)
                                    .background(Color.red)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                
                            }
                            else {
                                Text("Cancel Appointment")
                                    .frame(width: 300)
                                    .padding()
//                                    .foregroundStyle(Color.white)
                                    .background(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                    .customShadow()
                            }
                        }
                        
                    })
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Cancel Appointment"),
                            message: Text("Are you sure you want to cancel this appointment?"),
                            primaryButton: .destructive(Text("Cancel Appointment")) {
                                // Handle cancellation
                                cancelAppointment()
                            },
                            secondaryButton: .cancel()
                        )
                    }
                    
                }
                .padding(.horizontal , 25)
                .onAppear{
                    FirebaseHelperFunctions().getAppointmentData(appointmentUID: appointmentID) { appData, error in
                        if let appointment = appData {
                            self.data = appointment
                            if let spec = data?.doctorSpeciality {
                                if spec == "General Physician" {
                                    self.imageName = "Doctor-icon"
                                }
                                else{
                                    self.imageName = spec + "-icon"
                                }
                            }
                        }
                    }
                    
                    
                }
            }
        }
    }
    
    func cancelAppointment() {
        isLoading = true
        FirebaseHelperFunctions().deleteAppointment(appointmentID: appointmentID) { _ in
            print("deleted")
            isLoading = false
            deleted = true
        }
    }
}

#Preview {
    AppointmentDataView(appointmentID: "rigVXwyaiXE7JLUOfa0A")
}
