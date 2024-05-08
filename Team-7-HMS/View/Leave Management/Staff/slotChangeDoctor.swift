//
//  slotChangeDoctor.swift
//  Team-7-HMS
//
//  Created by Vikashini G on 07/05/24.
//

import SwiftUI

struct slotChangeDoctor: View {
    @State var doctor: DoctorDetails
    @State var changeDate = Date()
    @State var doctorUid: String
    @State var reason = ""
    @State private var slotNotavail: Bool = false
    @State private var slotAvail: Bool = false
    
    @State private var doctorDetails: [String: Any]? // Optional dictionary
    @State private var slotDetails : [String : Any]?
//    @State private var selectedSlot: String?
    
    @State private var bookedSlots: [String] = []
    @State private var selectedSlots: [String] = []
    
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
            HStack{
                Text(doctor.name)
                Spacer()
            }
            .foregroundStyle(Color.gray)
            .padding(.horizontal)
            .padding(.vertical, 15)
            .background(.white)
            .cornerRadius(10)
            .customShadow()
            HStack{
                Text("Slot change for")
                Spacer()
                DatePicker("", selection: $changeDate, displayedComponents: .date)
                    .datePickerStyle(.compact)
            }
            .padding(.horizontal)
            .padding(.vertical, 15)
            .background(.white)
            .cornerRadius(10)
            .customShadow()
            HStack{
                Text("Slots not available")
                Spacer()
                Button(action: {
                    slotNotavail.toggle()
                }){
                    Image(systemName: "chevron.down")
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 15)
            .background(.white)
            .cornerRadius(10)
            .customShadow()
            //fetch slots already booked for that day
            if slotNotavail{
                if let slotDetails = slotDetails as? [String: [[String: String]]] {
                    ForEach(slotDetails.sorted(by: { $0.key < $1.key }), id: \.key) { date, slots in
                        VStack {
                            LazyVGrid(columns: Array(repeating: GridItem(), count: 3), spacing: 10) {
                                ForEach(slots, id: \.self) { slot in
                                    let time = slot.keys.first ?? ""
                                    Text(time)
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .padding()
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(15)
                                        
                                }
                            }
                        }
                    }
                } else {
                    Text("No slots available")
                        .foregroundStyle(Color.gray)
                        .padding()
                }
            }
            TextField("Reason for request", text: $reason, axis: .vertical)
                .lineLimit(2, reservesSpace: true)
                .padding(.horizontal)
                .padding(.vertical, 15)
                .background(.white)
                .cornerRadius(10)
                .customShadow()
            HStack{
                Text("Slots available")
                Spacer()
                Button(action: {
                    slotAvail.toggle()
                }){
                    Image(systemName: "chevron.down")
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 15)
            .background(.white)
            .cornerRadius(10)
            .customShadow()
            //fetch all slots for the day
            if slotAvail{
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 10) {
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
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .background(bookedSlots.contains(slot) ? Color.gray : (selectedSlots.contains(slot) ? Color.myAccent : Color.white))
                                .foregroundStyle(bookedSlots.contains(slot) ? Color.white : (selectedSlots.contains(slot) ? Color.white : Color.black))
                                .cornerRadius(15)
                                .customShadow()
                                .disabled(bookedSlots.contains(slot))
                        }
                    }
                }
            }
            Spacer()
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Text("Submit")
                    .foregroundStyle(Color.white)
                    .font(.headline)
                    .frame(width: 300, height: 50)
                    .background(Color.myAccent)
                    .cornerRadius(20)
            })
        }
        .background(Color.background)
        .onAppear {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd_MM_yyyy"
            let formattedDate = dateFormatter.string(from: changeDate)
            fetchDoctorsDetails(name: doctor.name) { details, error in
                if let error = error {
                    print("Error fetching doctor details: \(error)")
                } else {
                    self.doctorDetails = details
                }
                //fetching free slots for the doctor
                FirebaseHelperFunctions().fetchSlots(doctorID: doctorUid, date: formattedDate) { slots, error in
                    if let error = error {
                        print("Error fetching slots: \(error)")
                    } else {
                        if let slots = slots {
                            // Slots are present, assign them to the state variable
                            self.slotDetails = slots
                            print(slots)
                        } else {
                            // Slots are not present
                            print("No slots available for this doctor.")
                        }
                    }
                }
            }
            
            
        }//on appear end
    }
}

#Preview {
    slotChangeDoctor(doctor: DoctorDetails(dictionary: mockDoctorData)!, doctorUid: "3npmgJzI3gSWiBpnTdTRTCEBPtX2")
}
