import SwiftUI

struct AppointmentCardData : Identifiable{
    var id = UUID()
    var date: String
    var day: String
    var time: String
    var doctorName: String
    var doctorSpeciality: String
    var appointmentID : String
    var dateString : Date
    let status: String // Add this line to include the status of the appointment
}

struct AppointmentMockData {
    static let appointmentDataArray = [
        AppointmentCardData(date: "11_03_2025", day: "Mon", time: "09:30 AM", doctorName: "Dr. Awesome", doctorSpeciality: "Dermatology", appointmentID: "3e23d445rcw4rwc34c2", dateString: Date(), status: "Upcoming"),
        AppointmentCardData(date: "12", day: "Tue", time: "10:30 AM", doctorName: "Dr. America", doctorSpeciality: "Urology", appointmentID: "", dateString: Date(), status: "completed"),
        AppointmentCardData(date: "11", day: "Mon", time: "09:30 AM", doctorName: "Dr. Awesome", doctorSpeciality: "Dermatology", appointmentID: "", dateString: Date(), status: "Upcoming"),
        AppointmentCardData(date: "12", day: "Tue", time: "10:30 AM", doctorName: "Dr. America", doctorSpeciality: "Urology", appointmentID: "", dateString: Date(), status: "completed")
    ]
}


struct AppointmentData : Identifiable{
    var id = UUID()
    var appointmentID : String
    var doctorName: String
    var doctorSpeciality: String
    var date: String
    var time: String
    var issues : [String]
    var status: String
}
