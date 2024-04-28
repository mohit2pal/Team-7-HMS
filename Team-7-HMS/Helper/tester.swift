//
//  tester.swift
//  Team-7-HMS
//
//  Created by Meghs on 28/04/24.
//

import SwiftUI

struct tester: View {
    @State var doctors: [DoctorInfo] = []
    @State var selectedDoctor: DoctorInfo? = nil
    let firebaseHelper = FirebaseHelperFunctions()
    
    @State var selectedSlots: [String] = []
    
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
        VStack{
            ScrollView(.horizontal) {
                HStack {
                    ForEach(doctors, id: \.id) { doctor in
                        VStack(alignment: .leading) {
                            Text("Name: \(doctor.name)")
                            Text("Specialty: \(doctor.specialty)")
                        }
                        .padding()
                        .background(selectedDoctor?.id == doctor.id ? Color.blue.opacity(0.5) : Color.clear)
                        .cornerRadius(10)
                        .onTapGesture {
                            // Set the selected doctor
                            selectedDoctor = doctor
                            // Clear the selected slots when the doctor changes
                            selectedSlots = []
                        }
                    }
                }
            }
            
            // Display time slots when a doctor is selected
            if let selectedDoctor = selectedDoctor {
                Text("Time Slots for \(selectedDoctor.name):")
                    .font(.headline)
                    .padding(.top)
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(timeSlots, id: \.self) { slot in
                            Text(slot)
                                .padding()
                                .background(selectedSlots.contains(slot) ? Color.green.opacity(0.5) : Color.gray.opacity(0.2))
                                .cornerRadius(8)
                                .onTapGesture {
                                    // Toggle the selection of the time slot
                                    if selectedSlots.contains(slot) {
                                        selectedSlots.removeAll(where: { $0 == slot })
                                    } else {
                                        selectedSlots.append(slot)
                                    }
                                }
                        }
                    }
                }
                .padding(.horizontal)
            }
            
            Button(action: {
                // Print details of the selected doctor
                if let selectedDoctor = selectedDoctor {
                    print("Selected Doctor Details:")
                    print("Name: \(selectedDoctor.name)")
                    print("Specialty: \(selectedDoctor.specialty)")
                    print("ID: \(selectedDoctor.id)")
                } else {
                    print("No doctor selected.")
                }
            }, label: {
                Text("Press here to submit")
            })
            .padding(.top)
        }
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

#Preview {
    tester()
}
