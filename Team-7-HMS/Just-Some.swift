//// Function to fetch medical records for a given patient ID
//func fetchMedicalRecord(for patientId: String, completion: @escaping (Result<PatientMedicalRecords?, Error>) -> Void) {
//    let db = Firestore.firestore()
//    let patientDocRef = db.collection("patient_details").document(patientId)
//    
//    patientDocRef.getDocument { (document, error) in
//        if let error = error {
//            // If there's an error fetching the document, pass the error to the completion handler
//            completion(.failure(error))
//        } else if let document = document, document.exists, let data = document.data() {
//            // If the document is fetched successfully and contains data, try to extract the medical records
//            if let medicalRecordsData = data["medicalRecords"] as? [String: Any] {
//                // Parse the data into a PatientMedicalRecords object
//                let patientMedicalRecords = PatientMedicalRecords(dictionary: medicalRecordsData)
//                
//                if let patientMedicalRecords = patientMedicalRecords {
//                    print("Successfully parsed patient medical records")
//                    // Pass the successfully parsed medical records to the completion handler
//                    completion(.success(patientMedicalRecords))
//                } else {
//                    print("Failed to parse patient medical records")
//                    // If the data cannot be parsed into a PatientMedicalRecords object, pass nil
//                    completion(.success(nil))
//                }
//            } else {
//                // If the document does not contain medical records, pass nil
//                completion(.success(nil))
//            }
//        } else {
//            // If the document does not exist, pass nil
//            completion(.success(nil))
//        }
//    }
//}
