//
//  DoctorHomeSwiftUI.swift
//  Team-7-HMS
//
//  Created by Ritwatz on 25/04/24.
//

import SwiftUI
import FirebaseAuth

struct DoctorHomeSwiftUI: View {
    @State private var shouldNavigateToLogin = false
    
    @State var doctorName: String
    @State var selectedAppointmentTypeIndex: Int = 0
    @State var selectedDate: String? = nil
    let appointmentType = ["Upcoming", "Completed"]
    
    // Separate arrays for upcoming and completed appointments
    var displayedAppointments: [DoctorAppointmentCardData] {
        let allAppointments = DoctorAppointmentMockData.doctorAppointmentDataArray
        switch selectedAppointmentTypeIndex {
        case 0:
            return filterAppointments(appointments: allAppointments, date: selectedDate, status: "Upcoming")
        case 1:
            if let selectedDate = selectedDate {
                return allAppointments.filter { $0.date == selectedDate && $0.status == "Completed" }
            } else {
                return allAppointments.filter { $0.status == "Completed" }
            }
        default:
            return []
        }
    }

    func filterAppointments(appointments: [DoctorAppointmentCardData], date: String?, status: String) -> [DoctorAppointmentCardData] {
            if let selectedDate = date {
                return appointments.filter { $0.date == selectedDate && $0.status == status }
            } else {
                return appointments.filter { $0.status == status }
            }
        }
        
        var uniqueAppointmentDates: [String] {
            let allDates = DoctorAppointmentMockData.doctorAppointmentDataArray.map { $0.date }
            return Array(Set(allDates))
        }
    
    var body: some View {
        VStack(alignment: .leading) {
            // Header
            HStack(alignment: .top) {
                Button {
                    signOut()
                } label: {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 70, height: 70)
                        .foregroundColor(.gray)
                        .padding(.trailing)
                }
                
                NavigationLink(destination: LoginScreen().navigationBarBackButtonHidden(true), isActive: $shouldNavigateToLogin) {
                    EmptyView()
                }
                
                VStack(alignment: .leading) {
                    Text("Hello 👋")
                        .font(CentFont.mediumReg)
                    Text(doctorName)
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
            // Appointments heading
            HStack(alignment: .top) {
                    Text("Appointments")
                        .font(.title)
                        .foregroundColor(.black)
                        .padding(.bottom, 1)
                }
                        
            // Display appointment dates as circular cards
            HStack(alignment: .top){
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment:.top, spacing: 10) {
                        ForEach(uniqueAppointmentDates.sorted(), id: \.self) { date in
                            Button(action: {
                                // Set selectedDate to filter appointments by this date
                                selectedDate = date
                            }) {
                                Text(date)
                                    .font(.title3)
                                    .foregroundColor(selectedDate == date ? .white : .black)
                                    .padding(30)
                                    .background(selectedDate == date ? Color.myAccent : Color.white)
                                    .clipShape(Circle())
                                    .frame(width:100)
                                    .customShadow()
                            }
                        }
                    }
                    
                }
            }
                        
            Spacer().frame(height: 5)
            
            Picker("Appointment Type", selection: $selectedAppointmentTypeIndex) {
                            ForEach(0..<appointmentType.count, id: \.self) {
                                Text(appointmentType[$0])
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.vertical)
                        
                        // Display appointments based on selected segment
                        ScrollView {
                            ForEach(displayedAppointments) { appointment in
                                DoctorAppointmentCard(appointmentData: appointment)
                                    
                            }
                        }
                    }
        .padding([.horizontal, .top])
        .background(Color.background)
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.shouldNavigateToLogin = true
            print("User signed out successfully")
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError.localizedDescription)")
        }
    }
}


#Preview {
    DoctorHomeSwiftUI(doctorName: "Dr.Prakash")
}
