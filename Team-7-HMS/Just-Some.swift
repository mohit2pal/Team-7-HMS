//import SwiftUI
//// Import Firebase if you're using Firestore directly in this file
//// import Firebase
//
//struct addPrescription: View {
//    @State var appointmentData: AppointmentCardData
//    
//    @State private var diagnosis: String = ""
//    @State private var symptoms: String = ""
//    @State private var labTest: String = ""
//    @State private var followUp: String = ""
//    @State private var medicines: [Medicine] = []
//    
//    var body: some View {
//        // Your existing view code
//        
//        Button("Submit Prescription") {
//            // Call the addPrescription function here
//            FirebaseHelperFunctions.addPrescription(appointmentData: appointmentData, diagnosis: diagnosis, symptoms: symptoms, labTest: labTest, followUp: followUp, medicines: medicines) { result in
//                switch result {
//                case .success():
//                    print("Prescription added successfully")
//                    // Handle success, e.g., show a success message or clear the form
//                case .failure(let error):
//                    print("Error adding prescription: \(error)")
//                    // Handle failure, e.g., show an error message
//                }
//            }
//        }
//        // Style your button as needed
//    }
//}
