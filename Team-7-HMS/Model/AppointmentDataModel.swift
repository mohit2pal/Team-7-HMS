//
//  AppointmentDataModel.swift
//  Team-7-HMS
//
//  Created by Subha on 03/05/24.
//

import Foundation

struct AppointmentDataModel {
    let appointmentID: String
    let date: String
    let doctorID: String
    let issues: [String]
    let patientID: String
    let slotTime: String

    init?(dictionary: [String: Any], appointmentID: String) {
        guard let date = dictionary["date"] as? String,
              let doctorID = dictionary["doctorID"] as? String,
              let issues = dictionary["issues"] as? [String],
              let patientID = dictionary["patientID"] as? String,
              let slotTime = dictionary["slotTime"] as? String else {
            return nil
        }

        self.appointmentID = appointmentID
        self.date = date
        self.doctorID = doctorID
        self.issues = issues
        self.patientID = patientID
        self.slotTime = slotTime
    }
}
