//
//  DoctorHomeSwiftUI.swift
//  Team-7-HMS
//
//  Created by Ritwatz on 25/04/24.
//

import SwiftUI
import FirebaseAuth

struct DoctorHomeSwiftUI: View {
    @State var doctorUid: String
    @State var doctor: DoctorDetails
    @State private var shouldNavigateToLogin = false
    
    @State var doctorName: String
    @State var selectedAppointmentTypeIndex: Int = 0
    @State var selectedDate: String? = nil
    let appointmentType = ["Upcoming", "completed"]
    
    var dateDict : [String : String] {
            let dateFormatterInput = DateFormatter()
            dateFormatterInput.dateFormat = "dd\nEE"
            
            let dateFormatterOutput = DateFormatter()
            dateFormatterOutput.dateFormat = "dd_MM_yyyy"
            
            var dateDictionary = [String: String]()
            let today = Date()
            let calendar = Calendar.current
            
            for i in 0..<7 {
                if let nextDate = calendar.date(byAdding: .day, value: i, to: today) {
                    let inputDateString = dateFormatterInput.string(from: nextDate)
                    let outputDateString = dateFormatterOutput.string(from: nextDate)
                    dateDictionary[inputDateString] = outputDateString
                }
            }
            return dateDictionary
    }

    
    @State var fetchedAppointments: [DoctorAppointmentCardData] = []
    
    // Separate arrays for upcoming and completed appointments
    var displayedAppointments: [DoctorAppointmentCardData] {
        switch selectedAppointmentTypeIndex {
        case 0:
            return filterAppointments(appointments: fetchedAppointments, date: selectedDate, status: "Upcoming")
        case 1:
            if let selectedDate = selectedDate {
                return fetchedAppointments.filter { $0.date == dateDict[selectedDate] && $0.status == "completed" }
            } else {
                return fetchedAppointments.filter { $0.status == "completed" }
            }
        default:
            return []
        }
    }

    func filterAppointments(appointments: [DoctorAppointmentCardData], date: String?, status: String) -> [DoctorAppointmentCardData] {
            if let selectedDate = date {
                return appointments.filter { $0.date == dateDict[selectedDate] && $0.status == status }
            } else {
                return appointments.filter { $0.status == status }
            }
        }
    
    func generateDateList() -> [String] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd\nEE"
        
        var dateList = [String]()
        let today = Date()
        let calendar = Calendar.current
        
        for i in 0..<7 {
            if let nextDate = calendar.date(byAdding: .day, value: i, to: today) {
                let dateString = dateFormatter.string(from: nextDate)
                dateList.append(dateString)

            }
        }
        
        return dateList
    }

    var uniqueAppointmentDates: [String] {
        generateDateList()
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
                        .frame(width: 60, height: 60)
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
                        .font(.title)
                        .fontWeight(.semibold)
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
            
            Spacer().frame(height: 30)
            // Appointments heading
            HStack(alignment: .top) {
                    Text("Appointments")
                        .font(.title)
                        .padding(.bottom, 1)
                }
                        
            // Display appointment dates as circular cards
            HStack(alignment: .top){
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment:.top, spacing: 10) {
                        ForEach(uniqueAppointmentDates, id: \.self) { date in
                            Button(action: {
                                
                                selectedDate = date
                                
                            }) {
                                Text(date)
                                    .font(.callout)
                                    .foregroundColor(selectedDate == date ? .white : .black)
                                    .frame(width: 50 , height : 50)
                                    .padding()
                                    .background(selectedDate == date ? Color.myAccent : Color.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 30))
                                    
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
            ScrollView(showsIndicators: false) {
                if displayedAppointments.isEmpty {
                    HStack{
                        Spacer()
                        
                        if selectedDate == nil {
                            Text("There are no appointments booked")
                                .italic()
                                .foregroundStyle(.gray)
                                .multilineTextAlignment(.center)
                        }
                        
                        if let d = selectedDate  ,let date = dateDict[d] as? String{
                            Text("There are no appointments booked for \(date.replacingOccurrences(of: "_", with: "-"))")
                                .italic()
                                .foregroundStyle(.gray)
                                .multilineTextAlignment(.center)
                        }
                        
                            
                        
                        Spacer()
                    }
                   
                }
                ForEach(displayedAppointments) { appointment in
                    DoctorAppointmentCard(appointmentData: appointment)
                }
                Spacer(minLength: 130)
            }
            }
        .padding([.horizontal, .top])
        .background(Color.background)
        .onAppear{
            
            FirebaseHelperFunctions.getAppointmentsForDoctor(doctorUID: doctorUid) { appointments, error in
                if let error = error {
                    print("Error retrieving appointments:", error)
                    // Handle error if needed
                } else {
                    if let appointments = appointments {
                        
                        let filterAppointments = appointments.filter{report1 in
                            let date1 = getDateLiteral(date: report1.date, time: report1.time)
                           
                            return Date() < date1
                        }
                        
                        let sortedAppointments = filterAppointments.sorted { (report1, report2) in
                            let date1 = getDateLiteral(date: report1.date, time: report1.time)
                            let date2 = getDateLiteral(date: report2.date, time: report2.time)
                            return date1 > date2
                        }
                    
                        // Assign the sorted appointments to your fetchedAppointments variable
                        self.fetchedAppointments = sortedAppointments
                    }
                }
            }
        }
    }
    
    private func extractDay(from dateString: String) -> String? {
        let components = dateString.components(separatedBy: "_")
        guard components.count >= 3, let day = components.first else {
            return nil
        }
        return day
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
    NavigationStack{
        DoctorHomeSwiftUI(doctorUid: "3npmgJzI3gSWiBpnTdTRTCEBPtX2", doctor: DoctorDetails(dictionary: mockDoctorData)!, doctorName: "Dr.Prakash")
    }
}
