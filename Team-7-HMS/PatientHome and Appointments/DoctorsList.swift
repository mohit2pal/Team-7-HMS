import SwiftUI
import FirebaseFirestore

// Example function to fetch documents from a Firestore collection
func fetchDoctorsBySpeciality(speciality: String, completion: @escaping ([String]?, Error?) -> Void) {
    let db = Firestore.firestore()
    
    // Construct the query to filter documents where "speciality" field matches the provided speciality
    let query = db.collection("doctor_details").whereField("speciality", isEqualTo: speciality)
    
    // Perform the query
    query.getDocuments { (querySnapshot, error) in
        if let error = error {
            print("Error fetching documents: \(error)")
            completion(nil, error)
        } else {
            var names = [String]()
            for document in querySnapshot!.documents {
                // Extract the "name" field from each document and append it to the names array
                if let name = document.get("name") as? String {
                    names.append(name)
                }
            }
            // Return the names array in the completion handler
            completion(names, nil)
        }
    }
}
