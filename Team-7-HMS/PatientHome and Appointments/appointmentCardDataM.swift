import SwiftUI

struct AppointmentCardData : Identifiable{
    var id = UUID()
    var date: String
    var day: String
    var time: String
    var doctorName: String
    var doctorSpeciality: String
}

struct AppointmentMockData {
    static let appointmentDataArray = [
        AppointmentCardData(date: "11", day: "Mon", time: "09:30 AM", doctorName: "Dr. Awesome", doctorSpeciality: "Dermatology"),
        AppointmentCardData(date: "12", day: "Tue", time: "10:30 AM", doctorName: "Dr. America", doctorSpeciality: "Urology"),
        AppointmentCardData(date: "11", day: "Mon", time: "09:30 AM", doctorName: "Dr. Awesome", doctorSpeciality: "Dermatology"),
        AppointmentCardData(date: "12", day: "Tue", time: "10:30 AM", doctorName: "Dr. America", doctorSpeciality: "Urology")
    ]
}
