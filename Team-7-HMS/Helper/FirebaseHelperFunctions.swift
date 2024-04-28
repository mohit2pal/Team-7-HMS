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


struct DoctorInfo {
    let name: String
    let specialty: String
    let id: String
}

class FirebaseHelperFunctions {
    
    let genders = ["Male", "Female", "Other"]
    let specialties = [
        "General Physician",
        "Obstetrics & Gynaecology",
        "Orthopaedics",
        "Urology",
        "Paediatrics",
        "Cardiology",
        "Dermatology",
        "ENT"
    ]
    
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
        
        let data : [String : Any] =
        [ "medicalRecords": [
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
        ]
        let patientRecordsRef = db.collection("patient_details").document(uuid)
        
        patientRecordsRef.getDocument { snapshot, error in
            if let error = error {
                print("Error fetching document: \(error)")
                return
            }
            
            guard let existingData = snapshot?.data() else {
                print("Snapshot is nil")
                return
            }
            
            // Merge the existing data with the new data
            var newData = existingData
            newData.merge(data) { _, new in new }
            
            // Update the document with the merged data
            patientRecordsRef.setData(newData) { error in
                if let error = error {
                    print("Error updating document: \(error)")
                } else {
                    print("Document updated successfully!")
                }
            }
        }
    }
    
    
    // Function to fetch patient data by UUID
    static func fetchPatientData(by uuid: String, completion: @escaping (Patient?, Error?) -> Void) {
        // Reference to the Firestore database
        let db = Firestore.firestore()
        
        // Reference to the specific patient document using the UUID
        let patientDocRef = db.collection("patient_details").document(uuid)
        
        // Fetch the document for the specified UUID
        patientDocRef.getDocument { (document, error) in
            if let error = error {
                // If there's an error fetching the document, pass the error to the completion handler
                completion(nil, error)
            } else {
                // If the document is fetched successfully, try to map it to a Patient struct
                if let document = document, document.exists, let patient = try? document.data(as: Patient.self) {
                    // Pass the patient to the completion handler
                    completion(patient, nil)
                } else {
                    // If the document does not exist or cannot be mapped to a Patient, pass nil
                    completion(nil, nil)
                }
            }
        }
    }
    // Function to fetch only the doctor name, specialty, and document ID from Firestore
    func fetchAllDoctors(completion: @escaping (Result<[DoctorInfo], Error>) -> Void) {
        let db = Firestore.firestore()
        
        // Fetch all documents from the "doctor_details" collection
        db.collection("doctor_details").getDocuments { snapshot, error in
            if let error = error {
                // If there's an error, pass it to the completion handler
                completion(.failure(error))
            } else if let snapshot = snapshot {
                // If the query is successful, parse the documents into DoctorInfo objects along with their document IDs
                var doctorsInfo: [DoctorInfo] = []
                for document in snapshot.documents {
                    if let doctorName = document.data()["name"] as? String,
                       let specialty = document.data()["specialty"] as? String {
                        let doctorID = document.documentID
                        let doctorInfo = DoctorInfo(name: doctorName, specialty: specialty, id: doctorID)
                        doctorsInfo.append(doctorInfo)
                    }
                }
                // Pass the array of doctor information to the completion handler
                completion(.success(doctorsInfo))
            }
        }
    }
    
    
    // Function to create slots for doctor's appointments
    func createSlots(doctorName: String, doctorID: String, date: Date, slots: [String]) {
        let db = Firestore.firestore()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd_MM_yyyy"
        let dateString = dateFormatter.string(from: date)
        
        // Mapping slots to the availability
        let formattedSlots = slots.map { ["\($0)": "Empty"] }
        
        // Reference to the document for the given doctor and date
        let slotsDocRef = db.collection("slots").document(doctorID)
        
        slotsDocRef.getDocument { (document, error) in
            if let document = document, document.exists {
                // Document exists, update the existing slots with new slots
                if var existingData = document.data() {
                    // Check if slots for the date already exist
                    if var slotsData = existingData[dateString] as? [[String: String]] {
                        // Append new slots to the existing slots for the date
                        slotsData.append(contentsOf: formattedSlots)
                        existingData[dateString] = slotsData
                    } else {
                        // Create a new entry for the date with the new slots
                        existingData[dateString] = formattedSlots
                    }
                    
                    // Update the document with the merged data
                    slotsDocRef.setData(existingData) { error in
                        if let error = error {
                            print("Error updating document: \(error)")
                        } else {
                            print("Slots updated successfully!")
                        }
                    }
                } else {
                    print("Error: Unable to parse existing slots data.")
                }
            } else {
                // Document does not exist, add a new document with the slots
                var data: [String: Any] = [:]
                data[dateString] = formattedSlots
                
                slotsDocRef.setData(data) { error in
                    if let error = error {
                        print("Error adding document: \(error)")
                    } else {
                        print("Slots added successfully!")
                    }
                }
            }
        }
    }
    
    
    //fetch the slots for doctors
    func fetchSlots(doctorID: String, date: String, completion: @escaping ([String: [[String: String]]]?, Error?) -> Void) {
        let db = Firestore.firestore()
        
        // Reference to the document for the given doctor
        let slotsDocRef = db.collection("slots").document(doctorID)
        
        // Fetch the document
        slotsDocRef.getDocument { document, error in
            if let error = error {
                print("Error fetching document: \(error)")
                completion(nil, error)
            } else if let document = document, document.exists {
                // Document exists, extract slots data
                if let slotsData = document.data() as? [String: [[String: String]]] {
                    // Filter out slots with value "Empty" for the specified date
                    if let slotsForDate = slotsData[date] {
                        let filteredSlots = slotsForDate.filter { $0.values.first == "Empty" }
                        completion([date: filteredSlots], nil)
                    } else {
                        print("No slots available for the specified date.")
                        completion(nil, NSError(domain: "NoSlotsError", code: -1, userInfo: nil))
                    }
                } else {
                    print("Error: Unable to parse slots data.")
                    completion(nil, NSError(domain: "ParsingError", code: -1, userInfo: nil))
                }
            } else {
                // Document does not exist
                print("Document does not exist.")
                completion(nil, NSError(domain: "DocumentNotFoundError", code: -1, userInfo: nil))
            }
        }
    }
    
    
    static func bookSlot(doctorUID: String, date: String, slotTime: String, patientUID: String, completion: @escaping (Result<String, Error>) -> Void) {
        let db = Firestore.firestore()
        
        let data = [
            "patientID" : patientUID,
            "doctorID" : doctorUID,
            "date" : date,
            "slotTime" : slotTime
        ]
        
        let appointmentDocRef = db.collection("appointments")
        var docID = ""
        appointmentDocRef.addDocument(data: data) { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Document added successfully")
                // You can use docID here as needed
            }
        }
        
        let query = appointmentDocRef.whereField("patientID", isEqualTo: patientUID)
            .whereField("doctorID", isEqualTo: doctorUID)
            .whereField("date", isEqualTo: date)
            .whereField("slotTime", isEqualTo: slotTime)
        
        // Execute the query
        query.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetching documents: \(error)")
            } else {
                guard let documents = querySnapshot?.documents else {
                    print("No matching documents.")
                    return
                }
                
                for document in documents {
                    docID = document.documentID
                    let documentData = document.data()
                    // Access the data for each matching document
                    
                    print("Document data: \(documentData) id : \(docID)")
                    
                    // Reference to the slots document for the given doctor
                    let slotsDocRef = db.collection("slots").document(doctorUID)
                    
                    // Fetch the document to get the current slots
                    slotsDocRef.getDocument { document, error in
                        if let error = error {
                            print("Error fetching document: \(error)")
                            completion(.failure(error))
                            return
                        }
                        
                        guard let document = document, document.exists, var slotsData = document.data() as? [String: [[String: String]]] else {
                            print("Document does not exist or data format is incorrect.")
                            completion(.failure(NSError(domain: "DocumentNotFoundError", code: -1, userInfo: nil)))
                            return
                        }
                        
                        // Check if there are slots for the specified date and modify the slot if found
                        if var slotsForDate = slotsData[date] {
                            var slotFound = false
                            for i in 0..<slotsForDate.count {
                                if slotsForDate[i].keys.contains(slotTime), slotsForDate[i][slotTime] == "Empty" {
                                    // Mark the slot as booked by changing its value
                                    slotsForDate[i][slotTime] = docID // Or "Booked" if you prefer not to use patientUID
                                    slotFound = true
                                    break
                                }
                            }
                            
                            if slotFound {
                                // Update the slots data with the modified slots for the date
                                slotsData[date] = slotsForDate
                                
                                // Update the document with the new slots data
                                slotsDocRef.setData(slotsData) { error in
                                    if let error = error {
                                        print("Error updating document: \(error)")
                                        completion(.failure(error))
                                    } else {
                                        print("Slot booked successfully!")
                                        completion(.success("Slot booked successfully!"))
                                    }
                                }
                            } else {
                                print("Slot not found or already booked.")
                                completion(.failure(NSError(domain: "SlotNotFoundError", code: -1, userInfo: nil)))
                            }
                        } else {
                            print("No slots available for the specified date.")
                            completion(.failure(NSError(domain: "NoSlotsError", code: -1, userInfo: nil)))
                        }
                    }
                }
            }
        }
    }
    
}


