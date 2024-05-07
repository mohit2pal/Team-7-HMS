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
    center.requestAuthorization(options: [.alert, .sound , .badge] ) { granted, error in
        if granted {
            print("Notifications Granted")
            // Define content for the notification
            let content = UNMutableNotificationContent()
            content.title = "Medical Test Reminder"
            content.body = "You have an upcoming \(medicalTest.medicalTest) appointment tomorrow."
            
            // Parse the date string into a Date object
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            guard let date = dateFormatter.date(from: medicalTest.date.replacingOccurrences(of: "_", with: "-")) else {
                print("error in date")
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
                UNUserNotificationCenter.current().add(request ){ (error) in
                    if let error = error {
                        print("Error scheduling notification: \(error.localizedDescription)")
                    } else {
                        print("Notification scheduled successfully.")
                    }
                }

            }
            
            // Parse the time string into a Date object
            dateFormatter.dateFormat = "hh:mm a"
            guard let time = dateFormatter.date(from: medicalTest.time) else {
                print("Error")
                return
            }
            
            var appointmentTimeComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
            appointmentTimeComponents.minute! -= 90
            // Create a trigger for the notification
            let timeTrigger = UNCalendarNotificationTrigger(dateMatching: appointmentTimeComponents, repeats: false)
            
            // Create content for the notification
            content.body = "Your \(medicalTest.medicalTest) appointment is in 90 minutes."
            
            // Create a request for the notification
            let timeRequest = UNNotificationRequest(identifier: medicalTest.caseID + "2", content: content, trigger: timeTrigger)
            
            // Schedule the notification
            UNUserNotificationCenter.current().add(timeRequest ){ (error) in
                if let error = error {
                    print("Error scheduling notification: \(error.localizedDescription)")
                } else {
                    print("Notification scheduled successfully.")
                }
            }
        }
    }
}

func removeNotification(for medicalTest: MedicalTest) {
    let center = UNUserNotificationCenter.current()
    center.removePendingNotificationRequests(withIdentifiers: [medicalTest.caseID+"1"])
    center.removePendingNotificationRequests(withIdentifiers: [medicalTest.caseID+"2"])
}
