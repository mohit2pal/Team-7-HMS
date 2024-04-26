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
    var body: some View {
        VStack{
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
                        HStack(spacing: 25) {
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
                                        selectedDayIndex = index
                                    }
                            }
                        }
                    }
                    .padding()
                }
                //FOR SAMPLE VIEW OF CARDS
                ScrollView(.vertical) {
                    VStack(spacing: 15) {
                        // Display the DoctorNameUIView instances using fetched names
                        ForEach(doctorNames, id: \.self) { name in
                            DoctorNameUIView(doctorName: name)
                        }
                    }
                    .onAppear {
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
//                    .onAppear {
//                        fetchDoctorsBySpeciality(speciality: speciality) { fetchedNames, error in
//                            if let error = error {
//                                print("Error fetching doctor names: \(error)")
//                            } else {
//                                if let fetchedNames = fetchedNames {
//                                    self.names = fetchedNames
//                                } else {
//                                    print("No names found.")
//                                }
//                            }
//                        }
//                    }
                }
            }
            Spacer()
        }
        .padding()
        .background(Color.background)
        .navigationBarTitle("Book Appointment", displayMode: .inline)
    }
    
    func daysInCurrentWeek() -> [String] {
            var days = [String]()
            let calendar = Calendar.current
            let currentDate = Date()
            let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: currentDate))!
            
            for dayOffset in 0..<7 {
                if let date = calendar.date(byAdding: .day, value: dayOffset, to: startOfWeek) {
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
    SpecialitySwiftUIView(speciality: "ENT", icon: "Ent-icon")
}
