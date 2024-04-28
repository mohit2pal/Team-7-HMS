import SwiftUI

struct appointmentCardDataM {
    @State var date: String
    @State var day: String
    @State var time: String
    @State var doctorName: String
    @State var doctorSpeciality: String
}

struct appointmentMockData{
    static let appointmentMockDatas = [
        appointmentCardDataM(date: "11", day: "Mon", time: "09:30 AM", doctorName: "Dr. Awesome", doctorSpeciality: "Dermatology"),
        appointmentCardDataM(date: "12", day: "Tue", time: "10:30 AM", doctorName: "Dr. America", doctorSpeciality: "Urology"),
        appointmentCardDataM(date: "11", day: "Mon", time: "09:30 AM", doctorName: "Dr. Awesome", doctorSpeciality: "Dermatology"),
        appointmentCardDataM(date: "12", day: "Tue", time: "10:30 AM", doctorName: "Dr. America", doctorSpeciality: "Urology")
    ]
}
