//import SwiftUI
//import FirebaseAuth
//
//struct DoctorHomeSwiftUI: View {
//    @State var doctorUid: String
//    @State var doctor: DoctorDetails
//    @State private var shouldNavigateToLogin = false
//    
//    @State var doctorName: String
//    @State var selectedAppointmentTypeIndex: Int = 0
//    @State var selectedDate: String? = nil
//    let appointmentType = ["Upcoming", "Completed"]
//    
//    // Updated to hold fetched appointments
//    @State var fetchedAppointments: [DoctorAppointmentCardData] = []
//    
//    var displayedAppointments: [DoctorAppointmentCardData] {
//        switch selectedAppointmentTypeIndex {
//        case 0:
//            return filterAppointments(appointments: fetchedAppointments, date: selectedDate, status: "Upcoming")
//        case 1:
//            if let selectedDate = selectedDate {
//                return fetchedAppointments.filter { $0.date == selectedDate && $0.status == "Completed" }
//            } else {
//                return fetchedAppointments.filter { $0.status == "Completed" }
//            }
//        default:
//            return []
//        }
//    }
//
//    // Existing code for filterAppointments and generateDateList functions...
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            // Existing UI code...
//        }
//        .padding([.horizontal, .top])
//        .background(Color.background)
//        .onAppear {
//            fetchAppointments()
//        }
//    }
//    
//    // Existing code for signOut function...
//
//    // New function to fetch appointments
//    private func fetchAppointments() {
//        // Assuming FirebaseHelperFunctions.getAppointmentsForDoctor is a static method
//        // Adjust this call according to your actual implementation
//        FirebaseHelperFunctions.getAppointmentsForDoctor(doctorUID: doctorUid) { appointments, error in
//            if let error = error {
//                print("Error fetching appointments: \(error.localizedDescription)")
//            } else if let appointments = appointments {
//                DispatchQueue.main.async {
//                    self.fetchedAppointments = appointments
//                }
//            }
//        }
//    }
//}
//
//// Existing code for Preview...
