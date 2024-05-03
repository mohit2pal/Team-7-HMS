//
//  LabTestCardData.swift
//  Team-7-HMS
//
//  Created by Ekta on 03/05/24.
//

import SwiftUI

struct LabTestCardData: Identifiable {
  let id = UUID()
  let date: String
  let day: String
  let testName: String
  let doctorName: String
}

struct LabTestMockData {
  static let labTestDataArray = [
    LabTestCardData(date: "11", day: "Mon", testName: "Blood Test", doctorName: AppointmentMockData.appointmentDataArray[0].doctorName),
    LabTestCardData(date: "12", day: "Tue", testName: "Urine Test", doctorName: AppointmentMockData.appointmentDataArray[1].doctorName),
    LabTestCardData(date: "10", day: "Sun", testName: "X-Ray", doctorName: AppointmentMockData.appointmentDataArray[2].doctorName),
    LabTestCardData(date: "13", day: "Wed", testName: "MRI", doctorName: AppointmentMockData.appointmentDataArray[3].doctorName),
  ]
}
