//
//  FirebaseHelperFunctions.swift
//  Team-7-HMS
//
//  Created by Meghs on 22/04/24.
//

import Foundation
import UserNotifications
import FirebaseFirestore
import Firebase
import FirebaseAuth


struct FirebaseHelperFunctions {
    
    let genders = ["Male", "Female", "Other"]
    let specialties = ["Cardiology", "Dermatology", "Endocrinology", "Gastroenterology", "Hematology", "Nephrology", "Neurology", "Oncology", "Pediatrics " ]
   
    let medicalDegrees = [
        "MD (Doctor of Medicine)",
        "MBBS (Bachelor of Medicine, Bachelor of Surgery)",
        "DO (Doctor of Osteopathic Medicine)",
        "DDS/DMD (Doctor of Dental Surgery/Doctor of Dental Medicine)",
        "PharmD (Doctor of Pharmacy)",
        "DVM (Doctor of Veterinary Medicine)",
        "DC (Doctor of Chiropractic)",
        "DPT (Doctor of Physical Therapy)",
        "PsyD (Doctor of Psychology)",
        "DNP (Doctor of Nursing Practice)"
    ]


    
    func addDoctorDetails(name : String , email : String , dateOfJoining : Date , experience : Int , selectedGenderIndex : Int , selectedSpecialtyIndex : Int , medicalDegree : Int , phoneNumber :  String ,docId : String) {
            // Convert Date to Timestamp
            let db = Firestore.firestore()
            let dateTimestamp = Timestamp(date: dateOfJoining)

        
            // Create a dictionary to represent the data
            let data: [String: Any] = [
                "name": name,
                "email": email,
                "dateOfJoining": dateTimestamp,
                "experience": experience,
                "gender": genders[selectedGenderIndex],
                "specialty": specialties[selectedSpecialtyIndex],
                "education" : medicalDegrees[medicalDegree],
                "phoneNumber": phoneNumber
                // Add other fields as needed...
            ]

            // Add data to Firestore
            db.collection("doctor_details").document(docId).setData(data) { error in
                if let error = error {
                    print("Error adding document: \(error)")
                } else {
                    print("Document added successfully!")
                }
            }
        }
    
    func registerUser(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                completion(.failure(error))
            } else if let authResult = authResult {
                // User registered successfully
                let uid = authResult.user.uid
                completion(.success(uid))
            } else {
                // Unexpected error occurred
                let unknownError = NSError(domain: "Unknown", code: -1, userInfo: nil)
                completion(.failure(unknownError))
            }
        }
    }
}
