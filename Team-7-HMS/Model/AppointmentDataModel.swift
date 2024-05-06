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
    let issues: [String]?
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


struct AppointmentDataModelMock {
    static let shared = AppointmentDataModelMock()

    func generateMockAppointmentData() -> [AppointmentDataModel] {
        let mockAppointments = [
            ["date": "2024-05-10", "doctorID": "doc123", "issues": ["Cough", "Cold"], "patientID": "pat456", "slotTime": "09:00 AM"],
            ["date": "2024-05-12", "doctorID": "doc456", "issues": ["Headache"], "patientID": "pat789", "slotTime": "10:30 AM"],
            ["date": "2024-05-15", "doctorID": "doc789", "issues": ["Back Pain"], "patientID": "pat012", "slotTime": "02:00 PM"]
        ]

        return mockAppointments.compactMap { dictionary in
            // Assuming each dictionary has a unique identifier for the appointmentID, which in a real scenario, could be fetched from a database or generated.
            let appointmentID = UUID().uuidString
            return AppointmentDataModel(dictionary: dictionary, appointmentID: appointmentID)
        }
    }
}
