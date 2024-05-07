//
//  LeaveApprovalCardData.swift
//  Team-7-HMS
//
//  Created by Ekta  on 07/05/24.
//

import Foundation

struct LeaveCardData: Identifiable {
            var id = UUID()
            var date: String
            var year: Int
            var day: String
            var DoctorName: String
            var status: String
            var DoctorID : String
    }
struct LeaveMockData {
    static let LeaveDataArray = [
        LeaveCardData(date: "14 Apr", year: 24, day: "Wed",DoctorName:"Dr. Fog" ,status: "Approved",DoctorID: ""),
        LeaveCardData(date: "16 Apr", year: 24, day: "Fri",DoctorName:"Dr. Aditya",status: "Pending", DoctorID: ""),
        LeaveCardData(date: "17 Apr", year: 24, day: "Sat",DoctorName:"Dr. Fog",status: "Approved",DoctorID: ""),
        LeaveCardData(date: "19 Apr", year: 24, day: "Mon",DoctorName:"Dr. Ekta",status: "Pending",DoctorID: "")
        ]
}

struct LeaveData: Identifiable {
    var id = UUID()
    var date: String
    var year: Int
    var day: String
    var DoctorName: String
    var status: String
    var DoctorID : String
}
