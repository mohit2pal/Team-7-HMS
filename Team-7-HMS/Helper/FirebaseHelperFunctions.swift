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


struct DoctorInfo: Equatable {
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
        "ENT",
        "Radiology",
        "Phatology",
        "Phlebotomy"
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
    func fetchPatientData(by uuid: String, completion: @escaping (Patient?, Error?) -> Void) {
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
    
    
    func fetchPatientInfo(by uuid: String, completion: @escaping ([String: Any]?, Error?) -> Void) {
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
                // If the document is fetched successfully, pass the document data to the completion handler
                completion(document?.data(), nil)
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
    
    
    //retrieving appointment data from the appointment ID
    func getAppointmentData(appointmentUID: String, completion: @escaping (AppointmentData?, Error?) -> Void) {
        let db = Firestore.firestore()
        
        let appointmentDocRef = db.collection("appointments").document(appointmentUID)
        
        appointmentDocRef.getDocument { (documentSnapshot, error) in
            if let error = error {
                // Propagate the error to the completion handler
                completion(nil, error)
                return
            }
            
            guard let documentData = documentSnapshot?.data() else {
                // Document does not exist or does not contain data
                completion(nil, nil)
                return
            }
            
            // Extract appointment data from document data
            let doctorID = documentData["doctorID"] as? String ?? ""
            let dateString = documentData["date"] as? String ?? ""
            let slotTime = documentData["slotTime"] as? String ?? ""
            let issues = documentData["issues"] as? [String] ?? []
            
            // Fetch doctor details
            let doctorInfoRef = db.collection("doctor_details").document(doctorID)
            doctorInfoRef.getDocument { (doctorSnapshot, doctorError) in
                if let doctorError = doctorError {
                    // Propagate the doctor error to the completion handler
                    completion(nil, doctorError)
                    return
                }
                
                guard let doctorData = doctorSnapshot?.data(),
                      let doctorName = doctorData["name"] as? String,
                      let doctorSpeciality = doctorData["specialty"] as? String else {
                    // Handle missing doctor data or day calculation error
                    completion(nil, nil)
                    return
                }
                
                // Create an instance of AppointmentData with the extracted data
                let appointmentData = AppointmentData(appointmentID: appointmentUID, doctorName: doctorName, doctorSpeciality: doctorSpeciality, date: dateString.replacingOccurrences(of: "_", with: "-"), time: slotTime, issues: issues)
                
                // Call the completion handler with the appointment data
                completion(appointmentData, nil)
            }
        }
    }
    
    
    // retrieving the slot data from patient end
    func getAppointments(patientUID: String, completion: @escaping ([AppointmentCardData]?, Error?) -> Void) {
        let db = Firestore.firestore()
        
        let appointmentDocRef = db.collection("appointments")
        
        let query = appointmentDocRef.whereField("patientID", isEqualTo: patientUID)
        
        query.getDocuments { [self] (querySnapshot, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            var appointments: [AppointmentCardData] = []
            
            for document in querySnapshot!.documents {
                let doctorUID = document["doctorID"] as? String ?? ""
                let dateString = document["date"] as? String ?? ""
                let appointmentID = document.documentID
                let timeSlot = document["slotTime"] as? String ?? ""
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy hh:mm a"
                
                let dateFormatedString = dateString.replacingOccurrences(of: "_", with: "-") + " " + timeSlot
                let dateFormated = dateFormatter.date(from: dateFormatedString)

                
                
                let day = FirebaseHelperFunctions.getDayOfWeekFromDate(dateString: dateString)
                let date = String(dateString.prefix(2))
                let doctorInfoRef = db.collection("doctor_details").document(doctorUID)
                
                doctorInfoRef.getDocument { (doctorSnapshot, doctorError) in
                    if let doctorError = doctorError {
                        completion(nil, doctorError)
                        return
                    }
                    
                    if let doctorData = doctorSnapshot?.data(),
                       let doctorName = doctorData["name"] as? String,
                       let doctorSpeciality = doctorData["specialty"] as? String  {
                        let appointmentData = AppointmentCardData(date: date, day: day ?? "", time: document["slotTime"] as! String, doctorName: doctorName, doctorSpeciality: doctorSpeciality, appointmentID: appointmentID, dateString: dateFormated!)
                        
                        appointments.append(appointmentData)
                    }
                    else{
                        print("no data")
                    }
                    
                    completion(appointments, nil)
                }
            }
        }
    }
    
    
    // booking slots for appointment
    static func bookSlot(doctorUID: String, date: String, slotTime: String, patientUID: String, issues : [String], completion: @escaping (Result<String, Error>) -> Void) {
        let db = Firestore.firestore()
        
        let data : [String : Any] = [
            "patientID" : patientUID,
            "doctorID" : doctorUID,
            "date" : date,
            "slotTime" : slotTime,
            "issues" : issues,
            "status" : "Upcoming"
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
    
    // delete an appointmemnt
    func deleteAppointment(appointmentID: String, completion: @escaping (Result<String, Error>) -> Void) {
        let db = Firestore.firestore()
        
        // Reference to the appointment document
        let appointmentDocRef = db.collection("appointments").document(appointmentID)
        
        // Get the data of the appointment document before deleting it
        appointmentDocRef.getDocument { (documentSnapshot, error) in
            if let error = error {
                print("Error fetching appointment document: \(error)")
                completion(.failure(error))
                return
            }
            
            guard let document = documentSnapshot, document.exists else {
                print("Appointment document does not exist.")
                completion(.failure(NSError(domain: "DocumentNotFoundError", code: -1, userInfo: nil)))
                return
            }
            
            // Get the doctor ID, date, and slot time from the appointment document
            guard let doctorID = document["doctorID"] as? String,
                  let date = document["date"] as? String,
                  let slotTime = document["slotTime"] as? String else {
                print("Error: Missing appointment data.")
                completion(.failure(NSError(domain: "MissingDataError", code: -1, userInfo: nil)))
                return
            }
            
            // Delete the appointment document
            appointmentDocRef.delete { error in
                if let error = error {
                    print("Error deleting appointment document: \(error)")
                    completion(.failure(error))
                    return
                }
                
                // Reference to the slots document for the doctor
                let slotsDocRef = db.collection("slots").document(doctorID)
                
                // Fetch the document to get the current slots
                slotsDocRef.getDocument { document, error in
                    if let error = error {
                        print("Error fetching slots document: \(error)")
                        completion(.failure(error))
                        return
                    }
                    
                    guard let document = document, document.exists, var slotsData = document.data() as? [String: [[String: String]]] else {
                        print("Slots document does not exist or data format is incorrect.")
                        completion(.failure(NSError(domain: "DocumentNotFoundError", code: -1, userInfo: nil)))
                        return
                    }
                    
                    // Check if there are slots for the specified date
                    if var slotsForDate = slotsData[date] {
                        // Mark the slot as available again by setting its value to "Empty"
                        for i in 0..<slotsForDate.count {
                            if slotsForDate[i].keys.contains(slotTime), slotsForDate[i][slotTime] == appointmentID {
                                slotsForDate[i][slotTime] = "Empty"
                                break
                            }
                        }
                        
                        // Update the slots data with the modified slots for the date
                        slotsData[date] = slotsForDate
                        
                        // Update the document with the new slots data
                        slotsDocRef.setData(slotsData) { error in
                            if let error = error {
                                print("Error updating slots document: \(error)")
                                completion(.failure(error))
                            } else {
                                print("Appointment deleted successfully!")
                                completion(.success("Appointment deleted successfully!"))
                            }
                        }
                    } else {
                        print("No slots available for the specified date.")
                        completion(.failure(NSError(domain: "NoSlotsError", code: -1, userInfo: nil)))
                    }
                }
            }
        }
    }
    
    static func getDayOfWeekFromDate(dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd_MM_yyyy" // Adjust the date format according to your input string
        
        if let date = dateFormatter.date(from: dateString) {
            let dayOfWeekFormatter = DateFormatter()
            dayOfWeekFormatter.dateFormat = "E" // "E" represents the abbreviated day of the week (e.g., Sun, Mon)
            
            return dayOfWeekFormatter.string(from: date)
        } else {
            return nil
        }
    }
    
    
    // get medical Records
    static func getMedicalRecords(patientUID: String, completion: @escaping (PatientMedicalRecords?, Error?) -> Void) {
        let db = Firestore.firestore()
        
        let docRef = db.collection("patient_details").document(patientUID)
        
        docRef.getDocument { (document, error) in
            if let error = error {
                print("Error fetching document: \(error)")
                completion(nil, error)
                return
            }
            
            guard let document = document, document.exists else {
                print("Document does not exist")
                completion(nil, nil)
                return
            }
            
            if let data = document.data() {
                // Assuming you have a field called "medicalRecords" which holds the medical records
                if let medicalRecords = data["medicalRecords"] as? [String: Any] {
                    // Extracting values from Firestore data and creating PatientMedicalRecords instance
                    if let pastMedicalHistory = medicalRecords["pastMedicalHistory"] as? [String],
                       let surgeries = medicalRecords["surgeries"] as? [String],
                       let allergies = medicalRecords["alergies"] as? [String],
                       let bloodGroup = medicalRecords["bloodGroup"] as? String,
                       let gender = medicalRecords["gender"] as? String,
                       let height = medicalRecords["height"] as? String,
                       let weight = medicalRecords["weight"] as? String,
                       let phoneNumber = medicalRecords["phoneNumber"] as? String {
                        
                        let patientMedicalRecord = PatientMedicalRecords(alergies: allergies, pastMedical: pastMedicalHistory, surgeries: surgeries, bloodGroup: bloodGroup, gender: gender, height: height, weight: weight, phoneNumber: phoneNumber)
                        
                        completion(patientMedicalRecord, nil)
                    } else {
                        print("Some fields are missing or have incorrect types")
                        completion(nil, nil)
                    }
                } else {
                    print("Medical records not found for this patient")
                    completion(nil, nil)
                }
            } else {
                print("Document data was empty.")
                completion(nil, nil)
            }
        }
    }
    
    func fetchDoctorDetails(by docId: String, completion: @escaping (DoctorDetails?, Error?) -> Void) {
        let db = Firestore.firestore()
        let docRef = db.collection("doctor_details").document(docId)
        
        docRef.getDocument { (document, error) in
            if let error = error {
                completion(nil, error)
            } else if let document = document, document.exists, let data = document.data() {
                if let doctorDetails = DoctorDetails(dictionary: data) {
                    completion(doctorDetails, nil)
                } else {
                    completion(nil, NSError(domain: "DataModelingError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to model doctor data."]))
                }
            } else {
                completion(nil, NSError(domain: "DocumentNotFoundError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Document does not exist."]))
            }
        }
    }
    
    
    static func getAppointmentsForDoctor(doctorUID: String, completion: @escaping ([DoctorAppointmentCardData]?, Error?) -> Void) {
        let db = Firestore.firestore()
        
        // Reference to the appointments collection
        let appointmentDocRef = db.collection("appointments")
        
        // Create a query to fetch appointments where the doctorID matches the provided doctorUID
        let query = appointmentDocRef.whereField("doctorID", isEqualTo: doctorUID)
        
        // DispatchGroup to synchronize the asynchronous calls
        let group = DispatchGroup()
        
        // Execute the query
        query.getDocuments { (querySnapshot, error) in
            if let error = error {
                // If there's an error executing the query, pass the error to the completion handler
                completion(nil, error)
                return
            }
            
            var appointments: [DoctorAppointmentCardData] = []
            
            // Check if there are documents
            guard let documents = querySnapshot?.documents, !documents.isEmpty else {
                completion([], nil) // No documents found, return an empty array
                return
            }
            
            // Iterate through the documents returned by the query
            for document in documents {
                let appointmentID = document.documentID // Get the appointment ID
                let patientUID = document["patientID"] as? String ?? ""
                let dateString = document["date"] as? String ?? ""
                let slotTime = document["slotTime"] as? String ?? ""
                let status = document["status"] as? String ?? "Unknown"
                
                // Enter the group before starting the asynchronous call
                group.enter()
                
                // Fetch additional details about the patient
                let patientDocRef = db.collection("patient_details").document(patientUID)
                patientDocRef.getDocument { (patientDocument, patientError) in
                    defer {
                        group.leave() // Leave the group after the asynchronous call is completed
                    }
                    
                    if let patientDocument = patientDocument, patientDocument.exists {
                        let patientName = patientDocument["name"] as? String ?? "Unknown"
                        let gender = patientDocument["gender"] as? String ?? "Unknown"
                        let age = patientDocument["age"] as? Int ?? 0 // Assuming age is stored as an Int
                        
                        // Extract year from the date string
                        let year = Calendar.current.component(.year, from: Date())
                        
                        // Assuming you have a function to get the day from the date string
                        let day = self.getDayOfWeekFromDate(dateString: dateString) ?? "Unknown"
                        
                        // Create a DoctorAppointmentCardData object for each appointment
                        let appointmentData = DoctorAppointmentCardData(appointmentID: appointmentID, date: dateString, year: year, day: day, time: slotTime, patientName: patientName, gender: gender, age: age, status: status, patientID: patientUID)
                        
                        // Add the appointment data to the appointments array
                        appointments.append(appointmentData)
                    } else if let patientError = patientError {
                        print("Error fetching patient details: \(patientError)")
                    }
                }
            }
            
            // Wait for all the asynchronous calls to complete
            group.notify(queue: .main) {
                // Call the completion handler with the final appointments array
                completion(appointments, nil)
            }
        }
    }
    
    //function to book a slot for medical tests
    func bookMedicalTest(patientUID: String, medicalTest: String, timeSlot: String, date: String, completion: @escaping () -> Void) {
        let db = Firestore.firestore()
        let medicalTestRef = db.collection("medicalTestsAppointments")
        
        var minCaseCount = Int.max
        var selectedDoctorID: String?
        
        let mainQuery = medicalTestRef
            .whereField("medicalTest", isEqualTo: medicalTest)
            .whereField("slot", isEqualTo: timeSlot)
            .whereField("date", isEqualTo: date)
        
        let docRef = db.collection("doctor_details")
        if let specialty = medicalTestDepartments[medicalTest] {
            print(specialty)
            let query = docRef.whereField("specialty", isEqualTo: specialty)
            
            // Dispatch group to wait for asynchronous queries
            let dispatchGroup = DispatchGroup()
            
            dispatchGroup.enter()
            // Execute the query
            query.getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    guard let documents = querySnapshot?.documents else {
                        print("No documents found.")
                        dispatchGroup.leave()
                        return
                    }
                    
                    for document in documents {
                        let documentID = document.documentID
                        let medicalRef = db.collection("medicalTestsAppointments")
                        let queryInfo = medicalRef
                            .whereField("date", isEqualTo: date)
                            .whereField("doctorID", isEqualTo: documentID)
                        
                        dispatchGroup.enter()
                        queryInfo.getDocuments { (querySnapshot, error) in
                            if let error = error {
                                print("Error getting documents: \(error)")
                            } else {
                                guard let documents = querySnapshot?.documents else {
                                    print("No documents found.")
                                    dispatchGroup.leave()
                                    return
                                }
                                
                                let count = documents.count
                                if count <= minCaseCount && count <= 10 {
                                    minCaseCount = count
                                    selectedDoctorID = documentID
                                }
                            }
                            dispatchGroup.leave()
                        }
                    }
                    dispatchGroup.leave()
                }
            }
            
            dispatchGroup.notify(queue: .main) {
                // This code block is executed when all asynchronous tasks in the dispatch group have completed
                
                if let docID = selectedDoctorID{
                    // Continue with booking appointment using the selected doctor ID
                    
                    print("This")
                    print(docID)
                    mainQuery.getDocuments { (querySnapshot, error) in
                        if let error = error {
                            print("Error getting documents: \(error)")
                        } else {
                            guard let querySnapshot = querySnapshot else {
                                let data: [String: Any] = [
                                    "patientId": patientUID,
                                    "medicalTest": medicalTest,
                                    "date": date,
                                    "slot": timeSlot,
                                    "status" :  "In progress",
                                    "notification" : false,
                                    "doctorID" : docID
                                ]
                                medicalTestRef.addDocument(data: data) { error in
                                    if let error = error {
                                        print("Error adding document: \(error)")
                                    } else {
                                        print("Appointment booked successfully!")
                                    }
                                }
                                return
                            }
                            // Getting the count of matching documents
                            let count = querySnapshot.documents.count
                            if count < 2 {
                                let data: [String: Any] = ["patientId": patientUID,
                                                           "medicalTest": medicalTest,
                                                           "date": date,
                                                           "slot": timeSlot,
                                                           "status" :  "In progress",
                                                           "notification" : false,
                                                           "doctorID" : docID]
                                
                                medicalTestRef.addDocument(data: data) { error in
                                    if let error = error {
                                        print("Error adding document: \(error)")
                                        
                                    } else {
                                        print("Appointment booked successfully!")
                                        completion()
                                    }
                                }
                                
                            } else {
                                print("No available slots for \(medicalTest) at \(timeSlot) on \(date).")
                                completion()
                            }
                        }
                    }
                } else {
                    print("No available doctors found.")
                }
            }
            
        } else {
            print("Medical test department not found.")
        }
    }

    
    //fetch the count
    func fetchSlotColorForDateAndTimeSlot(date: String, timeSlot: String, medicalTest  : String ,completion: @escaping (Int) -> Void) {
        let db = Firestore.firestore()
        let medicalTestRef = db.collection("medicalTestsAppointments")
        
        let query = medicalTestRef
            .whereField("medicalTest", isEqualTo: medicalTest)
            .whereField("slot", isEqualTo: timeSlot)
            .whereField("date", isEqualTo: date)
        
        query.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                guard let querySnapshot = querySnapshot else {
                    completion(0)
                    return
                }
                
                // Getting the count of matching documents
                let count = querySnapshot.documents.count
                print(count)
                completion(count)
            }
        }
    }
    
    // fetch the medical tests data
    func fetchMedicalTests(patientUID: String, completion: @escaping ([MedicalTest]) -> Void) {
        let db = Firestore.firestore()
        let medicalTestRef = db.collection("medicalTestsAppointments")
        
        let query = medicalTestRef.whereField("patientId", isEqualTo: patientUID)
        
        query.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                // Handle error here
                return
            }
            
            var medicalTests: [MedicalTest] = []
            
            
            
            guard let querySnapshot = querySnapshot else {
                // Handle nil snapshot
                completion(medicalTests)
                return
            }
            for document in querySnapshot.documents {
                
                let date = document["date"] as? String ?? ""
                let time = document["slot"] as? String ?? ""
                
                let dateFullForm = date.replacingOccurrences(of: "_", with: "-") + " " + time
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy hh:mm a"
                
                let fullDate = dateFormatter.date(from: dateFullForm)
                
                // Assuming MedicalTest has an initializer that takes a Firestore document
                let medicalTest = MedicalTest(caseID: document.documentID, medicalTest: document["medicalTest"] as? String ?? "", date: document["date"] as? String ?? "", time: document["slot"] as? String ?? "", status: document["status"] as? String ?? "", notifications: document["notification"] as? Bool ?? false , pdfURL:  document["medicalTestLink"] as? String ?? "", dateFull: fullDate!)
                medicalTests.append(medicalTest)
            }
            completion(medicalTests)
        }
    }
    
    func fetchMedicalTestsDoc(doctorUID: String, completion: @escaping ([PatientReport]) -> Void) {
        let db = Firestore.firestore()
        let medicalTestRef = db.collection("medicalTestsAppointments")
        
        let query = medicalTestRef.whereField("doctorID", isEqualTo: doctorUID)
        
        query.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                // Handle error here
                return
            }
            
            var medicalTests: [PatientReport] = []
            
            guard let querySnapshot = querySnapshot else {
                // Handle nil snapshot
                completion(medicalTests)
                return
            }
            for document in querySnapshot.documents {
                // Assuming MedicalTest has an initializer that takes a Firestore document
                let medicalTest = PatientReport(testName: document["medicalTest"] as? String ?? "", patientID: document["patientId"] as? String ?? "", scheduledDate: document["date"] as? String ?? "", caseId: document.documentID)
                medicalTests.append(medicalTest)
            }
            completion(medicalTests)
        }
    }

    
    // updating notifications
    func updateNotificationStatus(for caseID: String, isEnabled: Bool) {
        let db = Firestore.firestore()
        let medicalTestRef = db.collection("medicalTestsAppointments")
        
        // Update the notification field in the Firestore document with the matching caseID
        medicalTestRef.document(caseID).updateData(["notification": isEnabled]) { error in
            if let error = error {
                print("Error updating document: \(error)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    //update the pdf
    
    
    func updateMedicalRecord(for caseID: String, pdf : String, analysis : String) {
        let db = Firestore.firestore()
        let medicalTestRef = db.collection("medicalTestsAppointments")
        
        // Update the notification field in the Firestore document with the matching caseID
        medicalTestRef.document(caseID).updateData([    "medicalTestLink": pdf,
                                                        "status": "finish" ,
                                                        "analysis" : analysis
                                                    ]) { error in
            if let error = error {
                print("Error updating document: \(error)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    func fetchAppointmentData(appointmentID: String, completion: @escaping (AppointmentDataModel?, Error?) -> Void) {
        let db = Firestore.firestore()
        let appointmentRef = db.collection("appointments").document(appointmentID)
        
        appointmentRef.getDocument { (document, error) in
            if let error = error {
                completion(nil, error)
            } else if let document = document, document.exists, let data = document.data() {
                if let appointmentDataModel = AppointmentDataModel(dictionary: data, appointmentID: appointmentID) {
                    completion(appointmentDataModel, nil)
                } else {
                    completion(nil, NSError(domain: "DataParsingError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to parse appointment data."]))
                }
            } else {
                completion(nil, NSError(domain: "DocumentNotFoundError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Appointment document does not exist."]))
            }
        }
    }

    //delete medical Test
    func deleteMedicalTest(for caseID: String) {
        let db = Firestore.firestore()
        let medicalTestRef = db.collection("medicalTestsAppointments")
        
        // Update the notification field in the Firestore document with the matching caseID
        medicalTestRef.document(caseID).delete() { error in
            if let error = error {
                print("Error deleting document: \(error)")
            } else {
                print("Document successfully deleted")
            }
        }
    }
    
    func generateCaseNumber() -> String {
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let numbers = "0123456789"
        
        // Generate 2 random letters
        let randomLetters = String((0..<2).map{ _ in letters.randomElement()! })
        
        // Generate 3 random numbers
        let randomNumbers = String((0..<3).map{ _ in numbers.randomElement()! })
        
        // Combine letters and numbers to form the case number
        let caseNumber = randomLetters + randomNumbers
        
        return caseNumber
    }
    

    // Function to add a prescription to Firestore
    static func addPrescription(appointmentData: AppointmentDataModel, diagnosis: String, symptoms: String, labTest: String, followUp: String, medicines: [Medicine], completion: @escaping (Result<Void, Error>) -> Void) {
        let db = Firestore.firestore()
        
        // Convert medicines array to a format suitable for Firestore
        let medicinesData = medicines.map { medicine -> [String: Any] in
            return [
                "name": medicine.name,
                "morningDose": medicine.morningDose,
                "eveningDose": medicine.eveningDose,
                "nightDose": medicine.nightDose
            ]
        }
        
        // Create a dictionary to represent the prescription data
        let prescriptionData: [String: Any] = [
            "patientId": appointmentData.patientID, // Assuming AppointmentCardData has a patientId field
            "appointmentId": appointmentData.appointmentID,
            "diagnosis": diagnosis,
            "symptoms": symptoms,
            "labTest": labTest,
            "followUp": followUp,
            "medicines": medicinesData
        ]
        
        // Add the prescription data to the "prescriptions" collection
        db.collection("prescriptions").addDocument(data: prescriptionData) { error in
            if let error = error {
                print("Error adding prescription: \(error)")
                completion(.failure(error))
            } else {
                print("Prescription added successfully")
                completion(.success(()))
            }
        }
    }
    
    func assignDoctorsforMedicalTests(caseId : String ,medicalTest : String, date : String , completion: @escaping () -> Void){
        
        let db = Firestore.firestore()
        let docRef = db.collection("doctor_details")
        
        var doctorID : [String] = []
        
        if let specialty = medicalTestDepartments[medicalTest] {
            let query = docRef.whereField("specialty", isEqualTo: specialty)

            // Execute the query
            query.getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    guard let documents = querySnapshot?.documents else {
                        print("No documents found.")
                        return
                    }

                    for document in documents {
                        let documentID = document.documentID
                        doctorID.append(documentID)
                    }
                }
            }
            
            let medicalRef = db.collection("medicalTest")
        } else {
            print("Medical test department not found.")
        }    }
    
    // Function to change the status of an appointment from "upcoming" to "completed"
        func completeAppointment(appointmentID: String, completion: @escaping (Result<Void, Error>) -> Void) {
            let db = Firestore.firestore()

            // Reference to the appointment document
            let appointmentRef = db.collection("appointments").document(appointmentID)

            // Update the status field to "completed"
            appointmentRef.updateData([
                "status": "completed"
            ]) { error in
                if let error = error {
                    print("Error updating appointment status: \(error)")
                    completion(.failure(error))
                } else {
                    print("Appointment status updated to completed successfully.")
                    completion(.success(()))
                }
            }
        }

        // Function to fetch prescription based on the appointment ID
    func fetchPrescription(appointmentID: String, completion: @escaping (Result<PrescriptionModel, Error>) -> Void) {
        let db = Firestore.firestore()
        
        // Reference to the "prescriptions" collection
        let prescriptionsRef = db.collection("prescriptions")
        
        // Create a query to fetch prescriptions where the appointmentId matches the provided appointmentID
        let query = prescriptionsRef.whereField("appointmentId", isEqualTo: appointmentID)
        
        // Execute the query
        query.getDocuments { (querySnapshot, error) in
            if let error = error {
                // If there's an error executing the query, pass the error to the completion handler
                completion(.failure(error))
            } else if let documents = querySnapshot?.documents, !documents.isEmpty {
                // Assuming there's only one prescription per appointment ID
                let document = documents.first!
                let data = document.data()
                
                // Parse the document data into a PrescriptionModel instance
                if let prescription = PrescriptionModel(dictionary: data) {
                    // Pass the prescription model to the completion handler
                    completion(.success(prescription))
                } else {
                    // If parsing fails, pass a custom error to the completion handler
                    completion(.failure(NSError(domain: "DataParsingError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to parse prescription data."])))
                }
            } else {
                // If no documents are found, pass a custom error to the completion handler
                completion(.failure(NSError(domain: "DocumentNotFoundError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Prescription document does not exist for the given appointment ID."])))
            }
        }
    }
}


