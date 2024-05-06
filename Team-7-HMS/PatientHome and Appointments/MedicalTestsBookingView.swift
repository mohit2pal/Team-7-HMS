//
//  MedicalTestsBookingView.swift
//  Team-7-HMS
//
//  Created by Meghs on 03/05/24.
//

import SwiftUI

struct MedicalTestsBookingView: View {
    var patientUID : String
    @EnvironmentObject var appState : AppState
    @State var speciality: String
    @State var icon: String
    @State private var selectedDayIndex: Int?
    @State private var shouldReloadScrollView = false
    @State private var isLoading : Bool = false
    @State private var booked : Bool = false
    
    let startTime = Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: Date())!
       let endTime = Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: Date())!
       let interval: TimeInterval = 30 * 60 // 30 minutes in seconds
    
    @State private var selectedDateString : String = ""
    @State private var selectedTimeSlot : String = ""
    @State private var colour : [Color] = []
    var presentTimeSlots : [String] {
        timeSlots()
    }
    @State private var slotColors: [Color?] = []
    var body: some View {
        NavigationStack{
            VStack {
                VStack {
                    Image(icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .padding(10)
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
                                        self.shouldReloadScrollView.toggle()
                                        self.selectedDateString = addDaysToDate(days: index)
                                    }

                            }
                        }
                        .padding()
                    }
                    .onAppear{
                        self.selectedDateString = addDaysToDate(days: 0)

                    }
                }
               
                            
                VStack {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 20) {
                        ForEach(presentTimeSlots.indices, id: \.self) { index in
                            Text(presentTimeSlots[index])
                                .onTapGesture {
                                    selectedTimeSlot = presentTimeSlots[index]
                                }
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .background(getColor(timeSlot: presentTimeSlots[index]) ? Color.accentColor : .gray.opacity(0.2))
                                .foregroundStyle(getColor(timeSlot: presentTimeSlots[index]) ? .white : .black)
                                .cornerRadius(15)
                        }
                    }
                }
                .id(shouldReloadScrollView)
                
                if selectedTimeSlot != "" {
                    Text("Please arrive 10-15 minutes before your selected time for easy testing.")
                          .font(.caption)
                          .foregroundColor(.gray)
                          .padding(.vertical)
                }
                Spacer()
                
                
                Button(action: {
                    isLoading = true
                    FirebaseHelperFunctions().bookMedicalTest(patientUID: patientUID, medicalTest: speciality, timeSlot: selectedTimeSlot, date: selectedDateString) {
                        isLoading = false
                        booked = true
                    }
                  
                }, label: {
                    if isLoading {
                        ProgressView()
                            .padding()
                            .frame(width: 300)
                            .background(Color.accentColor)
                            .foregroundStyle(Color.white)
                            .cornerRadius(15)
                    }
                    else {
                        if booked{
                            Image(systemName: "checkmark.circle.fill")
                                .padding()
                                .frame(width: 300)
                                .background(Color.accentColor)
                                .foregroundStyle(Color.green)
                                .cornerRadius(15)
                        }
                        else {
                            Text("Book Slot")
                                .padding()
                                .frame(width: 300)
                                .background(Color.accentColor)
                                .foregroundStyle(Color.white)
                                .cornerRadius(15)
                        }
                    }
                    
                })
            }
            .padding()
            .background(Color.background)
            .navigationBarTitle("Book Medical Test", displayMode: .inline)
            .onAppear {
                // Select today's date index when the view appears
                selectedDayIndex = daysInCurrentWeek().firstIndex(of: currentDayString())
                fetchSlotColors()
                self.shouldReloadScrollView.toggle()
                
            }
            .onChange(of: selectedDayIndex) { _ in
                selectedTimeSlot = ""
                self.shouldReloadScrollView.toggle()
            }
        }
    }
    
    



    // Function to get the current day string (e.g., "Mon")
    func currentDayString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE\nd"
        return dateFormatter.string(from: Date())
    }
    
    func fetchSlotColors() {
            // Reset slotColors array
            slotColors = Array(repeating: nil, count: presentTimeSlots.count)
            
            for (index, timeSlot) in presentTimeSlots.enumerated() {
                FirebaseHelperFunctions().fetchSlotColorForDateAndTimeSlot(date: selectedDateString, timeSlot: timeSlot, medicalTest: speciality) { count in
                    // Determine color based on count (or any other condition)
                    let color: Color = count > 0 ? .accentColor : .gray.opacity(0.4)
                    // Update slotColors array
                    slotColors[index] = color
                }
            }
        }
    

    // Function to get the selected date based on the selectedDayIndex
    func selectedDate() -> String {
        
        guard let selectedDayIndex = selectedDayIndex else { return "" }
        
        //get todays date
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd_MM_yyyy"
        
        // Get today's date
        var currentDate = Date()
        
        // Iterate to the specified index
        for _ in 0..<selectedDayIndex {
            // Move to the next day
            if let nextDate = calendar.date(byAdding: .day, value: 1, to: currentDate) {
                currentDate = nextDate
            } else {
                // Error occurred while adding days
                return ""
            }
        }
        
        // Convert the final date to the desired format
        return dateFormatter.string(from: currentDate)
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
    
    func timeSlots() -> [String] {
            var timeSlots: [String] = []
            var currentTime = startTime

            while currentTime <= endTime {
                let formatter = DateFormatter()
                formatter.dateFormat = "hh:mm a"
                timeSlots.append(formatter.string(from: currentTime))
                currentTime += interval
            }

            return timeSlots
        }
    
    private func getColor(timeSlot : String) -> Bool{
        if timeSlot == self.selectedTimeSlot {
            return true
        }
        return false
    }
}

#Preview {
    MedicalTestsBookingView(patientUID: "", speciality:
                                "Cardiology", icon: "Ent-icon")
}
