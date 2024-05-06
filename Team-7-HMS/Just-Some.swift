//// Function to fetch prescription based on the appointment ID
//func fetchPrescription(appointmentID: String, completion: @escaping (Result<PrescriptionModel, Error>) -> Void) {
//    let db = Firestore.firestore()
//    
//    // Reference to the "prescriptions" collection
//    let prescriptionsRef = db.collection("prescriptions")
//    
//    // Create a query to fetch prescriptions where the appointmentId matches the provided appointmentID
//    let query = prescriptionsRef.whereField("appointmentId", isEqualTo: appointmentID)
//    
//    // Execute the query
//    query.getDocuments { (querySnapshot, error) in
//        if let error = error {
//            // If there's an error executing the query, pass the error to the completion handler
//            completion(.failure(error))
//        } else if let documents = querySnapshot?.documents, !documents.isEmpty {
//            // Assuming there's only one prescription per appointment ID
//            let document = documents.first!
//            let data = document.data()
//            
//            // Parse the document data into a PrescriptionModel instance
//            if let prescription = PrescriptionModel(dictionary: data) {
//                // Pass the prescription model to the completion handler
//                completion(.success(prescription))
//            } else {
//                // If parsing fails, pass a custom error to the completion handler
//                completion(.failure(NSError(domain: "DataParsingError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to parse prescription data."])))
//            }
//        } else {
//            // If no documents are found, pass a custom error to the completion handler
//            completion(.failure(NSError(domain: "DocumentNotFoundError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Prescription document does not exist for the given appointment ID."])))
//        }
//    }
//}
//
////// Prescription model
////struct PrescriptionModel {
////    let patientId: String
////    let appointmentId: String
////    let diagnosis: String
////    let symptoms: String
////    let labTest: String
////    let followUp: String
////    let medicines: [MedicineModel]
////    
////    // Initializer to create a PrescriptionModel instance from a dictionary
////    init?(dictionary: [String: Any]) {
////        guard let patientId = dictionary["patientId"] as? String,
////              let appointmentId = dictionary["appointmentId"] as? String,
////              let diagnosis = dictionary["diagnosis"] as? String,
////              let symptoms = dictionary["symptoms"] as? String,
////              let labTest = dictionary["labTest"] as? String,
////              let followUp = dictionary["followUp"] as? String,
////              let medicinesArray = dictionary["medicines"] as? [[String: Any]] else {
////            return nil
////        }
////        
////        self.patientId = patientId
////        self.appointmentId = appointmentId
////        self.diagnosis = diagnosis
////        self.symptoms = symptoms
////        self.labTest = labTest
////        self.followUp = followUp
////        self.medicines = medicinesArray.compactMap { MedicineModel(dictionary: $0) }
////    }
//}
//
////// Medicine model used in the PrescriptionModel
////struct MedicineModel {
////    let name: String
////    let morningDose: String
////    let eveningDose: String
////    let nightDose: String
////    
////    // Initializer to create a MedicineModel instance from a dictionary
////    init?(dictionary: [String: Any]) {
////        guard let name = dictionary["name"] as? String,
////              let morningDose = dictionary["morningDose"] as? String,
////              let eveningDose = dictionary["eveningDose"] as? String,
////              let nightDose = dictionary["nightDose"] as? String else {
////            return nil
////        }
////        
////        self.name = name
////        self.morningDose = morningDose
////        self.eveningDose = eveningDose
////        self.nightDose = nightDose
////    }
////}
