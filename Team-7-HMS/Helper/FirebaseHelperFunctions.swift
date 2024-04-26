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
    
    
    
    // add doctor details to firebase
    
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
    
    
    
    
    //register patient
    
    func registerPatientDetails(email: String, name: String, password: String, added: @escaping (String) -> Void){
        
        let db = Firestore.firestore()
        let dateTimeStamp = Timestamp(date: Date())
        
        registerUser(email: email, password: password) {  result in
            switch result {
            case .success(let uid):
                print("User registered successfully. UID: \(uid)")
                let documentRef = db.collection("patient_details").document(uid)
                
                let data : [String : Any] = [
                    "name":name,
                    "email":email,
                    "dateOfJoining":dateTimeStamp
                ]
                
                documentRef.setData(data) { error in
                    if let error = error {
                        print("Error adding document: \(error)")
                    } else {
                        print("Document added successfully!")
                        added(uid)
                    }
                }
                
                
                
            case .failure(let error):
                print("Error registering user: \(error.localizedDescription)")
            }
        }
    }
    
    
    // register user with email and password authentication
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
    
    
    // login authentication for doctor
    func authenticateDoctor(email: String, password: String, onSuccess: @escaping (String) -> Void ,  onFail: @escaping () -> Void ){
        let db = Firestore.firestore()
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                // Authentication failed
                print("Error authenticating doctor: \(error.localizedDescription)")
                onFail()
            } else if let authResult = authResult {
                // Authentication successful
                print("Doctor authenticated successfully")
                // Print the UUID (User ID) of the authenticated user
                print("User ID: \(authResult.user.uid)")
                let documentRef = db.collection("doctor_details").document(authResult.user.uid)
                
                
                documentRef.getDocument { (document, error) in
                    if let error = error {
                        print("Error retrieving document: \(error.localizedDescription)")
                        
                    } else {
                        if let _ = document {
                            if let document = document, let doctorName = document.data()?["name"] as? String {
                                print("Doctor document found in Firestore")
                                onSuccess(doctorName)
                            } else {
                                print("False")
                                onFail()
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    // Add patient details to firebase from google sign in
    
    func addPatientDetails(email: String, name: String, uuid: String, phoneNumber: String, completion: @escaping (Result<String, Error>) -> Void, present: @escaping () -> Void, added: @escaping () -> Void) {
        let db = Firestore.firestore()
        let dateTimestamp = Timestamp(date: Date())
        
        let documentRef = db.collection("patient_details").document(uuid)
        
        // Check if the document with the given UUID already exists
        documentRef.getDocument { document, error in
            if let document = document, document.exists {
                // Document with UUID exists, call present()
                present()
            } else {
                // Document with UUID doesn't exist, proceed to add the data
                // Create a dictionary to represent the data
                let data: [String: Any] = [
                    "name": name,
                    "email": email,
                    "gender": "",
                    "dateOfJoining": dateTimestamp,
                    "phoneNumber": phoneNumber
                ]
                
                // Add data to Firestore
                db.collection("patient_details").document(uuid).setData(data) { error in
                    if let error = error {
                        print("Error adding document: \(error)")
                        completion(.failure(error))
                    } else {
                        print("Document added successfully!")
                        added()
                        completion(.success("Document added successfully!"))
                    }
                }
            }
        }
    }

//        add patient medical records
    
    func addPatientsRecords( uuid : String ,dateOfBirth :Date , gender : String , bloodGroup : String , height : String , weight : String, phoneNumber : String , pastMedicalHistory : [String] , surgeries : [String] , alergies : [String]){
        let db = Firestore.firestore()
        
        let data : [String : Any] = [
            "dateOfBirth" : dateOfBirth,
            "gender" : gender,
            "bloodGroup": bloodGroup,
            "height" : height,
            "weight" : weight,
            "phoneNumber" : phoneNumber,
            "pastMedicalHistory" : pastMedicalHistory,
            "surgeries" : surgeries,
            "alergies" : alergies
        ]
        
        db.collection("patient_details").document(uuid).collection("patient_records").document("past_medical_history").setData(data) { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Document added successfully!")
            }
        }
        
    }
}
