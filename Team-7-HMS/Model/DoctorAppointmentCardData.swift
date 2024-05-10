//
//  DoctorAppointmentCardData.swift
//  Team-7-HMS
//
//  Created by Ritwatz on 24/04/24.
//

import Foundation

struct DoctorAppointmentCardData : Identifiable {
    var id = UUID()
    var appointmentID: String
    var date: String
    var year: Int
    var day: String
    var time: String
    var patientName: String
    var gender: String
    var status: String
    var patientID : String
}

struct DoctorAppointmentMockData {
    static let doctorAppointmentDataArray = [
        DoctorAppointmentCardData(appointmentID: "A1", date: "14 Apr", year: 24, day: "Wed", time: "10 AM", patientName: "Ms. Radhika", gender: "Female",  status: "Upcoming", patientID: ""),
        DoctorAppointmentCardData(appointmentID: "A2", date: "14 Apr", year: 24, day: "Wed", time: "11 AM", patientName: "Ms. Ekta", gender: "Female",  status: "Completed", patientID: ""),
        DoctorAppointmentCardData(appointmentID: "A3", date: "15 Apr", year: 24, day: "Thu", time: "10 AM", patientName: "Mr. Raghav", gender: "Male",  status: "Upcoming", patientID: ""),
        DoctorAppointmentCardData(appointmentID: "A4", date: "15 Apr", year: 24, day: "Thu", time: "11 AM", patientName: "Ms. Ishita", gender: "Female", status: "Completed", patientID: ""),
        DoctorAppointmentCardData(appointmentID: "A5", date: "16 Apr", year: 24, day: "Fri", time: "10 AM", patientName: "Mr. Sameer", gender: "Other", status: "Upcoming", patientID: ""),
        DoctorAppointmentCardData(appointmentID: "A6", date: "16 Apr", year: 24, day: "Fri", time: "11 AM", patientName: "Ms. Srishti", gender: "Female",  status: "Completed", patientID: ""),
        DoctorAppointmentCardData(appointmentID: "A7", date: "17 Apr", year: 24, day: "Sat", time: "10 AM", patientName: "Mr. Akshat", gender: "Male",  status: "Upcoming", patientID: ""),
        DoctorAppointmentCardData(appointmentID: "A8", date: "17 Apr", year: 24, day: "Sat", time: "11 AM", patientName: "Ms. Abhigna", gender: "Female" , status: "Completed", patientID: ""),
    ]
}
