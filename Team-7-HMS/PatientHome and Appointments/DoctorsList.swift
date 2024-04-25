import SwiftUI
import FirebaseFirestore

//func displayDoctorsNames(speciality: String) {
//    // Call the fetchDoctorsBySpeciality function
//    fetchDoctorsBySpeciality(speciality: speciality) { (names, error) in
//        // Check if there's an error
//        if let error = error {
//            print("Error fetching doctor names: \(error)")
//        } else {
//            // Print or display the retrieved names
//            if let names = names {
//                print("Doctors' Names:")
//                // Create a VStack to hold the DoctorNameUIView instances
//                VStack {
//                    ForEach(names, id: \.self) { name in
//                        // Use DoctorNameUIView inside the loop
//                        DoctorNameUIView(doctorName: name)
//                    }
//                }
//            } else {
//                print("No names found.")
//            }
//        }
//    }
//}

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
