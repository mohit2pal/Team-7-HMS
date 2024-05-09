//
//  PatientAppointmentView.swift
//  Team-7-HMS
//
//  Created by Subha on 08/05/24.
//

import SwiftUI
import FirebaseAuth

struct PatientAppointmentView: View {
    var patientUID : String {
        Auth.auth().currentUser?.uid ?? ""
    }
    
    @State private var isLoading : Bool = false
    
    @State var selectedAppointmentTypeIndex: Int = 0
    let appointmentType = ["Upcoming", "completed"]
    @State var selectedDate: String? = nil
    
    @State var fetchedAppointments: [AppointmentCardData] = []
    // Separate arrays for upcoming and completed appointments
    var displayedAppointments: [AppointmentCardData] {
        switch selectedAppointmentTypeIndex {
        case 0:
            return filterAppointments(appointments: fetchedAppointments, date: selectedDate, status: "Upcoming")
        case 1:
            if let selectedDate = selectedDate {
                return fetchedAppointments.filter { $0.date == selectedDate && $0.status == "completed" }
            } else {
                return fetchedAppointments.filter { $0.status == "completed" }
            }
        default:
            return []
        }
    }
    
    func filterAppointments(appointments: [AppointmentCardData], date: String?, status: String) -> [AppointmentCardData] {
        if let selectedDate = date {
            return appointments.filter { $0.date == selectedDate && $0.status == status }
        } else {
            return appointments.filter { $0.status == status }
        }
    }
       
    
    var body: some View {
        NavigationView {
            VStack{
                Picker("Appointment Type", selection: $selectedAppointmentTypeIndex) {
                    ForEach(0..<appointmentType.count, id: \.self) {
                        Text(appointmentType[$0])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.vertical)
                
                // Display appointments based on selected segment
                ScrollView(showsIndicators: false) {
                    if isLoading {
                        ProgressView()
                    } else {
                        if !fetchedAppointments.isEmpty {
                            if !displayedAppointments.isEmpty {
                                ForEach(displayedAppointments) { appointment in
                                    NavigationLink(destination: AppointmentDataView(appointmentID: appointment.appointmentID)) {
                                        PatientAppointmentViewCard(appointment: appointment)
                                    }
                                }
                            } else {
                                Text("There are no Appointments.")
                                    .foregroundStyle(Color.gray)
                            }
                        } else {
                            Text("There are no Appointments booked.")
                                .foregroundStyle(Color.gray)
                                .padding()
                        }
                    }
                    Spacer(minLength: 90)
                }
            }
            .padding([.horizontal, .top])
            .background(Color.background)
            .navigationTitle("Appointments")
            .onAppear{
                fetchAppointments()
            }
        }
    }
    
    // Fetch appointments using the getAppointments function
    private func fetchAppointments() {
        FirebaseHelperFunctions.getAppointments(patientUID: patientUID) { appointments, error in
            if let appointments = appointments {
                // Directly use the fetched AppointmentCardData
                self.fetchedAppointments = appointments.sorted(by: { $0.dateString > $1.dateString })
                print(appointments)
            } else if let error = error {
                print("Error fetching appointments: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    PatientAppointmentView()
}
