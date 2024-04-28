//
//  SpecialitySwiftUIView.swift
//  Team-7-HMS
//
//  Created by Vikashini G on 23/04/24.
//

import SwiftUI

struct SpecialitySwiftUIView: View {
    @State var speciality: String
    @State var icon: String
    @State private var selectedDayIndex: Int?
    @State private var doctorNames: [String] = []
    @State private var shouldReloadScrollView = false // New state variable

    var body: some View {
        VStack {
            VStack {
                Image(icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .padding(10)
                    .background(Color.lightAccentBG)
                    .cornerRadius(50)
                Text(speciality)
                    .font(bookAppFont.smallest)
                    .foregroundStyle(.gray)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(daysInCurrentWeek().indices, id: \.self) { index in
                            let day = daysInCurrentWeek()[index]
                            Text(day)
                                .multilineTextAlignment(.center)
                                .frame(width: 75, height: 75)
                                .background(selectedDayIndex == index ? Color.myAccent : Color.white)
                                .foregroundColor(selectedDayIndex == index ? .white : .black)
                                .cornerRadius(50)
                                .customShadow()
                                .onTapGesture {
                                    self.selectedDayIndex = index
                                    self.shouldReloadScrollView.toggle() // Toggle state variable
                                }
                        }
                    }
                    .padding()
                }
                
                ScrollView(.vertical) {
                    VStack(spacing: 15) {
                        ForEach(doctorNames, id: \.self) { name in
                            DoctorNameUIView(doctorName: name, date: selectedDate())
                        }
                    }
                    .id(shouldReloadScrollView) // Reload ScrollView when state changes
                }
            }
            Spacer()
        }
        .padding()
        .background(Color.background)
        .navigationBarTitle("Book Appointment", displayMode: .inline)
        .onAppear {
            // Select today's date index when the view appears
            selectedDayIndex = daysInCurrentWeek().firstIndex(of: currentDayString())
            // Fetch doctors' names for today's date
            fetchDoctorsNames(forSpeciality: speciality) { names, error in
                if let error = error {
                    print("Error: \(error)")
                } else if let names = names {
                    self.doctorNames = names
                } else {
                    print("No doctors found with the specified speciality.")
                }
            }
        }
        .onChange(of: selectedDayIndex) { _ in
            print("day changed")
            // Fetch doctors' names for the newly selected date
            fetchDoctorsNames(forSpeciality: speciality) { names, error in
                if let error = error {
                    print("Error: \(error)")
                } else if let names = names {
                    self.doctorNames = names
                } else {
                    print("No doctors found with the specified speciality.")
                }
            }
        }
    }

    // Function to get the current day string (e.g., "Mon")
    func currentDayString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE\nd"
        return dateFormatter.string(from: Date())
    }

    // Function to get the selected date based on the selectedDayIndex
    func selectedDate() -> String {
        guard let selectedDayIndex = selectedDayIndex else { return "" }
        return daysInCurrentWeek()[selectedDayIndex]
    }
    
    // Function to get the days of the current week as strings (e.g., ["Mon", "Tue", ...])
    func daysInCurrentWeek() -> [String] {
        var days = [String]()
        let calendar = Calendar.current
        let currentDate = Date()
        for dayOffset in 0..<7 {
            if let date = calendar.date(byAdding: .day, value: dayOffset, to:  currentDate) {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "EE\nd"
                let dateString = dateFormatter.string(from: date)
                days.append(dateString)
            }
        }
        return days
    }
}

#Preview {
    NavigationStack{
        SpecialitySwiftUIView(speciality: "Pediatrics", icon: "Ent-icon")
    }
}
