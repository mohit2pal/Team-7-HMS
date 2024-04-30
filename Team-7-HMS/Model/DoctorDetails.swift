//
//  DoctorDetails.swift
//  Team-7-HMS
//
//  Created by Subha on 29/04/24.
//

import Foundation
import FirebaseFirestore


struct DoctorDetails {
    let name: String
    let email: String
    let specialty: String
    let experience: Int
    let gender: String
    let education: String
    let phoneNumber: String
    let dateOfJoining: Date
    
    // Initialize from a Firestore document
    init?(dictionary: [String: Any]) {
        guard let name = dictionary["name"] as? String,
              let email = dictionary["email"] as? String,
              let specialty = dictionary["specialty"] as? String,
              let experience = dictionary["experience"] as? Int,
              let gender = dictionary["gender"] as? String,
              let education = dictionary["education"] as? String,
              let phoneNumber = dictionary["phoneNumber"] as? String,
              let dateTimestamp = dictionary["dateOfJoining"] as? Timestamp else {
            return nil
        }
        
        self.name = name
        self.email = email
        self.specialty = specialty
        self.experience = experience
        self.gender = gender
        self.education = education
        self.phoneNumber = phoneNumber
        self.dateOfJoining = dateTimestamp.dateValue()
    }
}

// Simulate Firestore Timestamp for the dateOfJoining field
let dateOfJoiningTimestamp = Timestamp(date: Date())

// Create a dictionary that represents a Firestore document
let mockDoctorData: [String: Any] = [
    "name": "Dr. Jane Doe",
    "email": "janedoe@example.com",
    "specialty": "Cardiology",
    "experience": 10,
    "gender": "Female",
    "education": "MD (Doctor of Medicine)",
    "phoneNumber": "123-456-7890",
    "dateOfJoining": dateOfJoiningTimestamp
]
