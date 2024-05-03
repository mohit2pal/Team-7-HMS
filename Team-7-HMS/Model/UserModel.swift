//
//  UserModel.swift
//  Team-7-HMS
//
//  Created by Subha on 25/04/24.
//

import Foundation

struct Patient: Codable {
    var name: String
    var email: String
}

struct PatientInfo : Codable {
    var name : String
    var email : String
    var height : String
    var weight : String
    var gender : String
    var blood : String
    
}

struct PatientMedicalRecords : Codable {
    var alergies : [String]
    var pastMedical : [String]
    var surgeries : [String]
    var bloodGroup : String
    var gender : String
    var height : String
    var weight : String
    var phoneNumber : String
}

struct ButtonData{
    let image: String
    let title: String
}
