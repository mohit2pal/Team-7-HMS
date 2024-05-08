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
}

struct AppointmentMockData {
    static let appointmentDataArray = [
        AppointmentCardData(date: "11", day: "Mon", time: "09:30 AM", doctorName: "Dr. Awesome", doctorSpeciality: "Dermatology", appointmentID: "", dateString: Date()),
        AppointmentCardData(date: "12", day: "Tue", time: "10:30 AM", doctorName: "Dr. America", doctorSpeciality: "Urology", appointmentID: "", dateString: Date()),
        AppointmentCardData(date: "11", day: "Mon", time: "09:30 AM", doctorName: "Dr. Awesome", doctorSpeciality: "Dermatology", appointmentID: "", dateString: Date()),
        AppointmentCardData(date: "12", day: "Tue", time: "10:30 AM", doctorName: "Dr. America", doctorSpeciality: "Urology", appointmentID: "", dateString: Date())
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
}
