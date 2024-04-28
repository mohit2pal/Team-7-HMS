import SwiftUI
import FirebaseFirestore

func fetchDoctorsDetails(name: String, completion: @escaping ([String: Any]?, Error?) -> Void) {
    let db = Firestore.firestore()
    
    // Construct the query to filter documents where "name" field matches the provided name
    let query = db.collection("doctor_details").whereField("name", isEqualTo: name)
    
    // Perform the query
    query.getDocuments { (querySnapshot, error) in
        if let error = error {
            print("Error fetching documents: \(error)")
            completion(nil, error)
        } else {
            var doctorDetails = [String: Any]()
            for document in querySnapshot!.documents {
                // Extract the "email", "gender", "experience", "speciality", and "phoneNumber" fields from each document and add them to the doctorDetails dictionary
                if let email = document.get("email") as? String,
                   let gender = document.get("gender") as? String,
                   let education = document.get("education") as? String,
                   let experience = document.get("experience") as? Int,
                   let speciality = document.get("specialty") as? String,
                   let phoneNumber = document.get("phoneNumber") as? String {
                    doctorDetails["email"] = email
                    doctorDetails["gender"] = gender
                    doctorDetails["experience"] = experience
                    doctorDetails["speciality"] = speciality
                    doctorDetails["education"] = education
                    doctorDetails["phoneNumber"] = phoneNumber
                    doctorDetails["docId"] = document.documentID
                }
            }
            // Return the doctorDetails dictionary in the completion handler
            completion(doctorDetails, nil)
        }
    }
}



func fetchDoctorsNames(forSpecialty specialty: String, completion: @escaping ([[String: String]]?, Error?) -> Void) {
    let db = Firestore.firestore()
    
    // Construct the query to filter documents where "specialty" field matches the provided specialty
    let query = db.collection("doctor_details").whereField("specialty", isEqualTo: specialty)
    
    // Perform the query
    query.getDocuments { (querySnapshot, error) in
        if let error = error {
            print("Error fetching documents: \(error)")
            completion(nil, error)
        } else {
            var doctors = [[String: String]]()
            for document in querySnapshot!.documents {
                // Extract the "name" and "id" fields from each document and add them to the doctors array
                if let name = document.get("name") as? String,
                   let id = document.documentID as? String  {
                    let doctorInfo = ["name": name, "id": id]
                    doctors.append(doctorInfo)
                }
            }
            // Return the doctors array in the completion handler
            completion(doctors.isEmpty ? nil : doctors, nil)
        }
    }
}
