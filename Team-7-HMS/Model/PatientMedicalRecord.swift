////
////  PatientMedicalRecords.swift
////  Team-7-HMS
////
////  Created by Subha on 06/05/24.
////
//
//import Foundation
//import FirebaseFirestore // Import to handle FIRTimestamp
//
//struct PatientMedicalRecord {
//    var allergies: [String]
//    var pastMedicalHistory: [String]
//    var surgeries: [String]
//    var bloodGroup: String
//    var gender: String
//    var height: Double
//    var weight: Double
//    var phoneNumber: String
//    var dateOfBirth: Date // Using Date type to store dateOfBirth
//    
//    // Initializer that takes a dictionary
//    init?(dictionary: [String: Any]) {
//        // Convert NSArrayM to Swift's native [String] array for 'allergies'
//        guard let allergiesNSArray = dictionary["alergies"] as? NSArray,
//              let pastMedicalHistoryNSArray = dictionary["pastMedicalHistory"] as? NSArray,
//              let surgeriesNSArray = dictionary["surgeries"] as? NSArray,
//              let bloodGroup = dictionary["bloodGroup"] as? String,
//              let gender = dictionary["gender"] as? String,
//              let height = dictionary["height"] as? Double,
//              let weight = dictionary["weight"] as? Double,
//              let phoneNumber = dictionary["phoneNumber"] as? String,
//              let dateOfBirthTimestamp = dictionary["dateOfBirth"] as? Timestamp else {
//            return nil
//        }
//        
//        // Convert NSArrayM to Swift's native [String] array
//        let allergies = allergiesNSArray.compactMap { $0 as? String }
//        let pastMedicalHistory = pastMedicalHistoryNSArray.compactMap { $0 as? String }
//        let surgeries = surgeriesNSArray.compactMap { $0 as? String }
//        
//        // Convert FIRTimestamp to Date
//        let dateOfBirth = dateOfBirthTimestamp.dateValue()
//        
//        self.allergies = allergies
//        self.pastMedicalHistory = pastMedicalHistory
//        self.surgeries = surgeries
//        self.bloodGroup = bloodGroup
//        self.gender = gender
//        self.height = height
//        self.weight = weight
//        self.phoneNumber = phoneNumber
//        self.dateOfBirth = dateOfBirth
//    }
//}
