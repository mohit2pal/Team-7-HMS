//
//  tester.swift
//  Team-7-HMS
//
//  Created by Meghs on 28/04/24.
//

import SwiftUI

struct AddingSlots: View {
    @State private var doctors: [DoctorInfo] = []
    @State private var selectedDoctor: DoctorInfo? = nil {
        didSet {
            fetchBookedSlots()
        }
    }
    
    @State var isDateInLeaves  = false
    @State var leavesSlot : [Date : Date] = [:]
    
    @State private var selectedDate: Date? = nil {
        didSet{
            fetchBookedSlots()
        }
    }
    @State private var searchText = ""
    @State private var bookedSlots: [String] = []
    @State private var selectedSlots: [String] = []
    @State private var showSuccessAnimation = false // New state variable for showing the tick animation
    
    let firebaseHelper = FirebaseHelperFunctions()
    
    // Add a computed property to check if the submit button should be enabled
    private var isSubmitButtonDisabled: Bool {
        selectedDoctor == nil || selectedSlots.isEmpty
    }
    
    private func fetchBookedSlots() {
        guard let selectedDoctor = selectedDoctor else { return }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd_MM_yyyy"
        let dateString = dateFormatter.string(from: selectedDate ?? Date())
        
        firebaseHelper.fetchSlots(doctorID: selectedDoctor.id, date: dateString) {result, error in
            if let error = error {
                print("Error fetching slots: \(error.localizedDescription)")
                self.bookedSlots = []
            } else if let result = result {
                // Assuming the result is a dictionary with date as key and an array of slots as value
                self.bookedSlots = result[dateString]?.compactMap { $0.keys.first } ?? []
            }
        }
    }
    
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
            if selectedDoctor == nil {
                // Doctor selection view
                doctorSelectionView
                    .transition(.move(edge: .leading))
            } else {
                // Date and slot selection view
                dateAndSlotSelectionView
                    .transition(.move(edge: .trailing))
            }
        }
        .padding()
        .background(Color.background)
        .animation(.easeInOut, value: selectedDoctor)
        .onAppear {
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
    
    // MARK: - Doctor Selection View
    var doctorSelectionView: some View {
        VStack {
            HStack {
                Text("Select Doctor")
                    .font(.headline)
                Spacer()
            }
            SearchBar(text: $searchText)
                .padding(.bottom)
            List {
                ForEach(doctors.filter {
                    self.searchText.isEmpty ? true : $0.name.localizedCaseInsensitiveContains(searchText)
                }, id: \.name) { doctor in
                    Button(action: {
                        self.selectedDoctor = doctor
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
    }
    
    // MARK: - Date and Slot Selection View
    var dateAndSlotSelectionView: some View {
        
        
        return VStack {
            // Include a back button at the top
            HStack {
                Button(action: {
                    // Reset selectedDoctor to nil to go back
                    self.selectedDoctor = nil
                    self.selectedDate = nil
                    self.selectedSlots = []
                }) {
                    Image(systemName: "arrow.left") // Use a suitable image or text
                        .foregroundColor(.blue)
                        .padding()
                }
                if let doctorName = selectedDoctor?.name {
                    Text(doctorName)
                        .font(.headline)
                        .padding()
                }
                Spacer()
            }
            
            // Date picker
            HStack {
                Text("Select Date")
                    .font(.headline)
                Spacer()
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(daysOfWeek, id: \.self) { date in
                        DateButton(date: date, isSelected: date == selectedDate, action: {
                            selectedDate = date
                            self.isDateInLeaves = false
                            
                            guard let selectedDate1 = date as? Date else {
                                return
                            }
                            
                            for (fromDate, toDate) in leavesSlot {
                            
                                if selectedDate1 >= fromDate && selectedDate1 <= toDate {
                                    self.isDateInLeaves = true
                                    break
                                }
                            }
                            
                            
                        })
                    }
                }
            }
            .padding(.vertical)
            
            // Time slots
            if let selectedDoctor = selectedDoctor, selectedDate != nil {
                HStack {
                    Text("Set time slots for")
                    Text("\(selectedDoctor.name)")
                        .foregroundStyle(.gray)
                    Spacer()
                }
                .font(.headline)
                .padding(.vertical)
                
                if isDateInLeaves {
                    Text("The admin has approved a leave on \(getDateString(date: selectedDate ?? Date()))")
                        .font(.callout)
                        .foregroundStyle(.gray)
                        .multilineTextAlignment(.center)
                }
                
                else {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 20) {
                        ForEach(timeSlots, id: \.self) { slot in
                            Button(action: {
                                // Check if the slot is not booked before toggling the selection
                                if !bookedSlots.contains(slot) {
                                    if selectedSlots.contains(slot) {
                                        selectedSlots.removeAll(where: { $0 == slot })
                                    } else {
                                        selectedSlots.append(slot)
                                    }
                                }
                            }) {
                                Text(slot)
                                    .padding()
                                    .background(bookedSlots.contains(slot) ? Color.gray : (selectedSlots.contains(slot) ? Color.myAccent : Color.white))
                                    .foregroundStyle(bookedSlots.contains(slot) ? Color.white : (selectedSlots.contains(slot) ? Color.white : Color.black))
                                    .cornerRadius(12)
                                    .customShadow()
                                    .disabled(bookedSlots.contains(slot))
                            }
                        }
                    }
                }
            }
            
            Spacer()
            submitButton
        }
        .onAppear{
            if let Docid = selectedDoctor?.id {
                FirebaseHelperFunctions().getDays(doctorID: Docid) { data, error in
                    if let data = data {
                        self.leavesSlot = data
                    }
                    else {
                        self.leavesSlot = [:]
                    }
                    
                    print(self.leavesSlot)
                }
            }
        }
    }
    
    
    // MARK: - Submit Button
    var submitButton: some View {
        
        Button(action: {
            if let selectedDoctor = selectedDoctor {
                firebaseHelper.createSlots(doctorName: selectedDoctor.name, doctorID: selectedDoctor.id, date: selectedDate ?? Date(), slots: selectedSlots)
                self.showSuccessAnimation = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.showSuccessAnimation = false
                    self.selectedDoctor = nil
                    self.selectedDate = nil
                    self.selectedSlots = []
                }
            } else {
                print("No doctor selected.")
            }
        }, label: {
            Text("Press here to submit")
        })
        .frame(width: 300, height: 50)
        .background(isSubmitButtonDisabled ? Color.gray : Color.myAccent)
        .foregroundColor(.white)
        .cornerRadius(20)
        .disabled(isSubmitButtonDisabled)
        .fullScreenCover(isPresented: $showSuccessAnimation) {
            // FullScreenCover for success animation
            SuccessAnimationView()
        }
    }
}

struct SuccessAnimationView: View {
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            Image(systemName: "checkmark.circle.fill") // Use a tick mark image or system symbol
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .foregroundColor(.green)
        }
    }
}


struct FailureAnimationView: View {
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            Image(systemName: "multiply.circle.fill") // Use a tick mark image or system symbol
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .foregroundColor(.red)
        }
    }
}

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color("PrimaryColor"))
                .padding(.leading, 8)
            TextField("Search doctors by name", text: $text)
        }
        .padding(8)
        .background(Color(.systemGray6))
        .cornerRadius(8)
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
