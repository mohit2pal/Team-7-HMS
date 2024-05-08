//private func fetchAppointments() {
//    FirebaseHelperFunctions.getAppointments(patientUID: patientUID) { appointments, error in
//        if let appointments = appointments {
//            // Sort the appointments based on the dateString property
//            self.fetchedAppointments = appointments.sorted(by: { $0.dateString < $1.dateString })
//            print(appointments)
//        } else if let error = error {
//            print("Error fetching appointments: \(error.localizedDescription)")
//        }
//    }
//}
