//
//  StaffData.swift
//  Team-7-HMS
//
//  Created by Ritwatz on 02/05/24.
//

import Foundation

struct StaffInformation {
    var doctorsCount: Int
    var nursesCount: Int
    var sanitaryStaffCount: Int
    var totalActiveStaffToday: Int {
            return doctorsCount + nursesCount + sanitaryStaffCount
        }
}

struct Amenities {
    var totalStaffCount: Int
    var totalBedsCount: Int
    var otCount: Int
    var ambulanceCount: Int
}

struct PatientInformation {
    var totalPatientsCount: Int
    var doctorsAttendingPatientsCount: Int
    var appointmentsScheduledCount: Int
    var appointmentsCancelledCount: Int
}

struct DashboardData {
    var date: Date
    var staffInfo: StaffInformation
    var amenities: Amenities
    var patientInfo: PatientInformation
}

let staffInfo = StaffInformation(doctorsCount: 10, nursesCount: 20, sanitaryStaffCount: 5)
let amenities = Amenities(totalStaffCount: 35, totalBedsCount: 100, otCount: 3, ambulanceCount: 2)
let patientInfo = PatientInformation(totalPatientsCount: 50, doctorsAttendingPatientsCount: 15, appointmentsScheduledCount: 30, appointmentsCancelledCount: 5)

let dashboardData = DashboardData(date: Date(), staffInfo: staffInfo, amenities: amenities, patientInfo: patientInfo)
