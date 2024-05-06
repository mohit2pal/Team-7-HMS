//
//  MedicalTestsReminderFunctions.swift
//  Team-7-HMS
//
//  Created by Meghs on 05/05/24.
//

import Foundation
import UserNotifications

func scheduleNotifications(for medicalTest: MedicalTest) {
    let center = UNUserNotificationCenter.current()

    // Request permission to display notifications
    center.requestAuthorization(options: [.alert, .sound]) { granted, error in
        if granted {
            // Define content for the notification
            let content = UNMutableNotificationContent()
            content.title = "Medical Test Reminder"
            content.body = "You have an upcoming \(medicalTest.medicalTest) appointment tomorrow."

            // Parse the date string into a Date object
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            guard let date = dateFormatter.date(from: medicalTest.date) else {
                return
            }

            // Get the current date
            let currentDate = Date()

            // Check if the appointment date is in the future
            if date > currentDate {
                // Get the date components for the day before the appointment
                var dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: date)
                dateComponents.day! -= 1
                dateComponents.hour = 10 // Set the notification time to 10:00 AM
                dateComponents.minute = 0

                // Create a trigger for the notification
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

                // Create a request for the notification
                let request = UNNotificationRequest(identifier: medicalTest.caseID + "1", content: content, trigger: trigger)

                // Schedule the notification
                center.add(request)
            }

            // Parse the time string into a Date object
            dateFormatter.dateFormat = "hh:mm a"
            guard let time = dateFormatter.date(from: medicalTest.time) else {
                return
            }

            // Check if the appointment date is today or in the future
            if date >= currentDate {
                // Get the date and time for 90 minutes before the appointment
                var appointmentTimeComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
                appointmentTimeComponents.minute! -= 90

                // Create a trigger for the notification
                let timeTrigger = UNCalendarNotificationTrigger(dateMatching: appointmentTimeComponents, repeats: false)

                // Create content for the notification
                content.body = "Your \(medicalTest.medicalTest) appointment is in 90 minutes."

                // Create a request for the notification
                let timeRequest = UNNotificationRequest(identifier: medicalTest.caseID + "2", content: content, trigger: timeTrigger)

                // Schedule the notification
                center.add(timeRequest)
            }
        }
    }
}

func removeNotification(for medicalTest: MedicalTest) {
    let center = UNUserNotificationCenter.current()
    center.removePendingNotificationRequests(withIdentifiers: [medicalTest.caseID+"1"])
    center.removePendingNotificationRequests(withIdentifiers: [medicalTest.caseID+"2"])
}
