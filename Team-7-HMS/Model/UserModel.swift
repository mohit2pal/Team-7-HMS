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

func addDaysToDate( days: Int ) -> String {
    let date = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "dd_MM_yyyy"
    let newDate = Calendar.current.date(byAdding: .day, value: days, to: date) ?? date
    return formatter.string(from: newDate)
}


struct MedicalTest{
    let caseID : String
    let medicalTest : String
    let date : String
    let time : String
    let status : String
    let notifications : Bool
    let pdfURL : String
    let dateFull : Date
}

let medicalTestInformation: [String: String] = [
    "Blood Analysis": "Fast for 12 hours before giving a blood test to ensure accurate results.",
    "XRay": "Remove any metal objects, jewelry, or clothing with metal zippers or snaps before the X-ray procedure.",
    "CT Scan": "Avoid eating or drinking for a few hours before the CT scan, especially if contrast dye will be used.",
    "MRI": "Inform the technician if you have any metal implants or devices in your body before undergoing an MRI scan.",
    "PET Scan": "Limit physical activity and avoid caffeine for 24 hours before a PET scan to improve image quality.",
    "Ultrasound": "Drink plenty of water and avoid urinating before the ultrasound exam to ensure a full bladder, which helps with imaging.",
    "Biopsy": "Inform your healthcare provider about any medications you're taking, as some may need to be temporarily stopped before a biopsy.",
    "Stool Test": "Follow any specific dietary or medication instructions provided by your healthcare provider before collecting the stool sample."
]

let medicalTestDepartments: [String: String] = [
    "XRay": "Radiology",
    "CT Scan": "Radiology",
    "PET Scan": "Radiology",
    "Stool Test": "Pathology",
    "Biopsy": "Pathology",
    "Ultrasound": "Radiology",
    "Blood Analysis": "Phlebotomy",
    "MRI": "Radiology"
]

let daysDict: [Int: String] = [
    1: "Sun", // Sunday
    2: "Mon", // Monday
    3: "Tue", // Tuesday
    4: "Wed", // Wednesday
    5: "Thu", // Thursday
    6: "Fri", // Friday
    7: "Sat"  // Saturday
]

struct LeaveManagementCard {
    var id : String
    var status : String
    var appliedDate : String
}

struct leaveManagementInfo {
    var id : String
    var fromDate : Date
    var toDate : Date
    var status : String
    var description :  String
    var doctorName : String
    var doctorDepartment : String
    var docID : String
}
