//
//  tester.swift
//  Team-7-HMS
//
//  Created by Meghs on 28/04/24.
//

import SwiftUI

struct AddingSlots: View {
    @State private var doctors: [DoctorInfo] = []
    @State private var selectedDoctor: DoctorInfo? = nil
    @State private var selectedDate = Date()
    @State private var searchText = ""
    @State private var showList = false
    let firebaseHelper = FirebaseHelperFunctions()
    @State private var selectedSlots: [String] = []
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EE\nd"
        return formatter
    }
        
        private var daysOfWeek: [Date] {
            let calendar = Calendar.current
            let today = calendar.startOfDay(for: Date())
            return (0..<7).map { calendar.date(byAdding: .day, value: $0, to: today)! }
        }
    
    // Generate time slots from 9 am to 4 pm
    let timeSlots: [String] = {
        var slots: [String] = []
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        let startDate = Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: Date())!
        let endDate = Calendar.current.date(bySettingHour: 17, minute: 0, second: 0, of: Date())!
        var currentDate = startDate
        while currentDate <= endDate {
            slots.append(formatter.string(from: currentDate))
            currentDate = Calendar.current.date(byAdding: .hour, value: 1, to: currentDate)!
        }
        return slots
    }()
    
    var body: some View {
        VStack {
//            ScrollView(.horizontal) {
//                HStack {
//                    ForEach(doctors, id: \.id) { doctor in
//                        VStack(alignment: .leading) {
//                            Text("Name: \(doctor.name)")
//                            Text("Specialty: \(doctor.specialty)")
//                        }
//                        .padding()
//                        .background(selectedDoctor?.id == doctor.id ? Color.blue.opacity(0.5) : Color.clear)
//                        .cornerRadius(10)
//                        .onTapGesture {
//                            // Set the selected doctor
//                            selectedDoctor = doctor
//                            // Clear the selected slots when the doctor changes
//                            selectedSlots = []
//                        }
//                    }
//                }
//            }
            
            HStack{
                Text("Select Doctor")
                    .font(.headline)
                Spacer()
            }
            VStack {
                SearchBar(text: $searchText, showList: $showList)
                if showList {
                    List {
                        ForEach(doctors.filter {
                            self.searchText.isEmpty ? true : $0.name.localizedCaseInsensitiveContains(searchText)
                        }, id: \.name) { doctor in
                            Button(action: {
                                self.selectedDoctor = doctor
                                self.showList = false
                            }) {
                                Text("\(doctor.name), \(doctor.specialty)")
                            }
                        }
                    }
                    .listStyle(.plain)
                    .background(Color.white)
                    .cornerRadius(20)
                    .customShadow()
                }
                
                // Date picker
                Spacer().frame(height: 30)
                HStack{
                    Text("Select Date")
                        .font(.headline)
                    Spacer()
    //                DatePicker("", selection: $selectedDate, displayedComponents: .date)
    //                    .padding()
                }
                
                //DATES SCROLL
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(daysOfWeek, id: \.self) { date in
                            DateButton(date: date, isSelected: date == selectedDate, action: {
                                selectedDate = date
                            })
                        }
                    }
                }
                Spacer().frame(height: 30)
//                if let selectedDoctor = selectedDoctor {
//                    HStack{
//                        Text("Selected Doctor:")
//                            .font(.headline)
//                        Spacer()
//                        Text("\(selectedDoctor.name)")
//                    }
//                    
//                }
            }
            .background(
                Color.clear
                    .contentShape(Rectangle()) 
                    // Make the background tappable
                    .onTapGesture {self.showList = false}
                    // Hide the list when tapped outside the search bar or the list
            )
            
            
            
            // Display time slots when a doctor is selected
            if let selectedDoctor = selectedDoctor {
                HStack{
                    Text("Set time slots for")
                    Text("\(selectedDoctor.name)")
                        .foregroundStyle(.gray)
                    Spacer()
                }
                .font(.headline)
                .padding(.vertical)
            
                
                // time slots
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 20) {
                    ForEach(timeSlots, id: \.self) { slot in
                        Button(action: {
                            // Toggle the selection of the time slot
                            if selectedSlots.contains(slot) {
                                selectedSlots.removeAll(where: { $0 == slot })
                            } else {
                                selectedSlots.append(slot)
                            }
                        }) {
                            Text(slot)
                                .padding(.horizontal)
                                .padding(.vertical, 10)
                                .background(selectedSlots.contains(slot) ? Color.myAccent : Color.white)
                                .foregroundStyle(selectedSlots.contains(slot) ? Color.white : Color.black)
                                .cornerRadius(8)
                                .customShadow()
                        }
                        .frame(width: 180)
                    }
                }
                .padding(.horizontal)
            }
            Spacer()
            Button(action: {
                // Print details of the selected doctor
                if let selectedDoctor = selectedDoctor {
                    firebaseHelper.createSlots(doctorName: selectedDoctor.name, doctorID: selectedDoctor.id, date: selectedDate, slots: selectedSlots)
                } else {
                    print("No doctor selected.")
                }
            }, label: {
                Text("Press here to submit")
            })
//            .padding()
            .frame(width: 296, height: 44)
            .background(Color.myAccent)
            .foregroundColor(.white)
            .cornerRadius(20)
        }
        .padding()
        .background(Color.background)
        .onAppear {
            // Fetch the list of doctors when the view appears
            firebaseHelper.fetchAllDoctors { result in
                switch result {
                case .success(let doctors):
                    self.doctors = doctors
                case .failure(let error):
                    print("Error fetching doctors: \(error.localizedDescription)")
                }
            }
        }
    }
}

struct SearchBar: View {
    @Binding var text: String
    @Binding var showList: Bool
    
    var body: some View {
        HStack {
            TextField("Search doctors by name", text: $text, onEditingChanged: { editing in
                self.showList = editing
            })
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 8)
        }
        .padding(.vertical, 8)
    }
}
struct DateButton: View {
    let date: Date
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Text(date, formatter: dateFormatter)
            .multilineTextAlignment(.center)
            .frame(width: 75, height: 75)
            .foregroundColor(isSelected ? .white : .black)
            .background(isSelected ? Color.myAccent : Color.white)
            .cornerRadius(50)
            .customShadow()
            .onTapGesture {
                action()
            }
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EE d"
        return formatter
    }
}

#Preview {
    AddingSlots()
}
