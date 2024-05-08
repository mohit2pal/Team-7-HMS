//
//  PrescriptionModel.swift
//  Team-7-HMS
//
//  Created by Subha on 06/05/24.
//

import Foundation

// Prescription model
struct PrescriptionModel {
    let patientId: String
    let appointmentId: String
    let diagnosis: String
    let symptoms: String
    let labTest: String
    let followUp: String
    let medicines: [Medicine]

    // Initializer to create a PrescriptionModel instance from a dictionary
    init?(dictionary: [String: Any]) {
        guard let patientId = dictionary["patientId"] as? String,
              let appointmentId = dictionary["appointmentId"] as? String,
              let diagnosis = dictionary["diagnosis"] as? String,
              let symptoms = dictionary["symptoms"] as? String,
              let labTest = dictionary["labTest"] as? String,
              let followUp = dictionary["followUp"] as? String,
              let medicinesArray = dictionary["medicines"] as? [Any] else { // Changed to [Any] to accommodate NSArray
            return nil
        }

        self.patientId = patientId
        self.appointmentId = appointmentId
        self.diagnosis = diagnosis
        self.symptoms = symptoms
        self.labTest = labTest
        self.followUp = followUp
        self.medicines = medicinesArray.compactMap { element in
            guard let medicineDict = element as? [String: Any] else {
                return nil
            }
            return Medicine(dictionary: medicineDict)
        }
    }
}
