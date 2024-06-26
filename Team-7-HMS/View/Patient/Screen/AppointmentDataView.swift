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
    
    @State var showOldPrescriptionSheet: Bool = false
    @State var isDisabled: Bool = false // New state variable to control disabled state
    @Environment(\.presentationMode) var presentationMode
    
    @State private var shouldDismiss: Bool = false
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.background.ignoresSafeArea()
                VStack{
                    HStack{
                        Image(imageName)
                            .resizable()
                            .frame(width: 60 , height: 60)
                            .padding(12)
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(Color.black.opacity(0.4), lineWidth: 2)
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
                    
                    if let status = data?.status{
                        
                        if status == "completed" {
                            Button{
                                showOldPrescriptionSheet.toggle()
                            } label: {
                                HStack{
                                    Spacer()
                                    Image(systemName: "list.bullet.circle")
                                        .foregroundColor(.accentColor)
                                    Text("Show prescription")
                                        .font(.headline)
                                        .foregroundStyle(Color.black)
                                    Spacer()
                                }
                                .frame(width: 300, height: 50)
                                .background(Color.white)
                                .cornerRadius(20)
                                .customShadow()
                            }
                        } else {
                            NavigationLink {
                                RescheduleAppointmentsView(appointmentId: appointmentID, prevTime: data?.time ?? "time", date: data?.date ?? "date", previousDate: data?.date ?? "date", shouldDismiss: $shouldDismiss)
                             } label: {
                                 Text("Reschedule")
                                     .frame(width: 300)
                                     .padding()
                                     .foregroundStyle(Color.white)
                                     .background(Color.myAccent)
                                     .clipShape(RoundedRectangle(cornerRadius: 15))
                             }

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
                                            .background(Color.red.opacity(0.8))
                                            .clipShape(RoundedRectangle(cornerRadius: 15))
                                        
                                    }
                                    else {
                                        Text("Cancel Appointment")
                                            .frame(width: 300)
                                            .padding()
                                            .foregroundStyle(Color.white)
                                            .background(Color.red.opacity(0.8))
                                            .clipShape(RoundedRectangle(cornerRadius: 15))
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
                    }
                }
                .padding(.horizontal , 25)
                .disabled(isDisabled)
                .sheet(isPresented: $showOldPrescriptionSheet) {
                    ViewPrescription(showOldPrescriptionSheet: $showOldPrescriptionSheet, appointmentID: data?.appointmentID ?? "Null Value")
                }
                .onAppear{
                    if shouldDismiss {
                        self.presentationMode.wrappedValue.dismiss()
                    }
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
                
                // Fullscreen gray overlay conditionally displayed based on isDisabled
                if isDisabled {
                    Color.black.opacity(0.8).ignoresSafeArea()
                        .overlay(
                            // VStack for the symbol and text
                            VStack {
                                Image(systemName: "checkmark.seal")
                                    .font(.system(size: 52))
                                    .foregroundColor(.white)
                                Text("Your appointment is successfully canceled")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .padding()
                            }
                        )
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
            isDisabled = true
            
            // Wait for 2 seconds before executing the code inside the block
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                // Dismiss the view
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

#Preview {
    AppointmentDataView(appointmentID: "rigVXwyaiXE7JLUOfa0A")
}
