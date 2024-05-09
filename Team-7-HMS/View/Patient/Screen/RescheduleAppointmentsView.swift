//
//  RescheduleAppointmentsView.swift
//  Team-7-HMS
//
//  Created by Meghs on 08/05/24.
//

import SwiftUI
import Firebase
struct RescheduleAppointmentsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var appointmentId : String
    @State var isLoading2 = false
    @State var doctorName : String = ""
    @State var doctorSpeciality : String = ""
    @State var deparmtentImage : String = ""
    @State var daySlots : [Date] = []
    @State var doctorID = ""
    @State var selectedDateIndex : Int = 0
    @State private var slotDetails : [String : Any] = [:]
    @State private var selectedSlot: String?
    @State private var isLoading = false
    @State var prevTime : String
    @State var date : String
    @State var previousDate : String
    
    @Binding var shouldDismiss: Bool
    
    @State private var showSuccessAnimation: Bool = false
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.background.ignoresSafeArea()
                VStack{
                    ScrollView{
                        HStack{
                            Image(deparmtentImage)
                                .resizable()
                                .frame(width: 50 , height: 50)
                                .padding()
                                .background(.white)
                            
                                .clipShape(Circle())
                                .customShadow()
                            
                            VStack(alignment: .leading){
                                Text(doctorName)
                                    .font(.title)
                                    .bold()
                                
                                Text(doctorSpeciality + " Department")
                                    .font(.callout)
                            }.padding(.leading, 30)
                        }
                        .frame(width: 320)
                        
                        Text("Appointment ID : " + appointmentId.suffix(5))
                            .foregroundStyle(.gray)
                        Divider()
                            .padding(.bottom)
                        
                        HStack{
                            Text("Avaliable Slots for Dr." + doctorName)
                                .font(.title3)
                            Spacer()
                        }
                        
                        VStack{
                            ScrollView(.horizontal) {
                                HStack(spacing: 20) {
                                    ForEach(daySlots.indices, id: \.self) { index in
                                        VStack {
                                            Text("\(Calendar.current.component(.day, from: daySlots[index]))")
                                                .font(.headline)
                                            
                                            // Optionally, you can display other information like day of the week
                                            Text(daysDict[Calendar.current.component(.weekday, from: daySlots[index])] ?? "Unknown")                                        .font(.subheadline)
                                        }
                                        
                                        .frame(width: 40, height: 50 )
                                        .padding()
                                        .clipShape(Rectangle())
                                        
                                        .background(pressed(index) ? Color.accentColor : .gray.opacity(0.2))
                                        .cornerRadius(15)
                                        .onTapGesture {
                                            selectedDateIndex = index
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                            .scrollIndicators(.hidden)
                            
                        }
                        
                        if !daySlots.isEmpty {
                            HStack{
                                Text("Selected Date")
                                Text(daySlots[selectedDateIndex], style : .date)
                            }
                            .padding()
                            
                        }
                        
                        if isLoading {
                            ProgressView()
                        }
                        else {
                            if slotDetails.isEmpty {
                                Text("There are no slots avaliable the selected day")
                            }
                            VStack {
                                if let slotDetails = slotDetails as? [String: [[String: String]]] {
                                    ForEach(slotDetails.sorted(by: { $0.key < $1.key }), id: \.key) { date, slots in
                                        VStack {
                                            
                                            LazyVGrid(columns: Array(repeating: GridItem(), count: 3), spacing: 10) {
                                                ForEach(slots, id: \.self) { slot in
                                                    let time = slot.keys.first ?? ""
                                                    Text(time)
                                                        .frame(minWidth: 0, maxWidth: .infinity)
                                                        .padding()
                                                        .background(Date() > getDateLiteral(date: date, time: time) ? .gray :slotColor(slot))
                                                        .cornerRadius(15)
                                                        .foregroundStyle(Date() > getDateLiteral(date: date, time: time) ? .white : .black)
                                                        .disabled( Date() > getDateLiteral(date: date, time: time))
                                                        .onTapGesture{
                                                            selectedSlot = time
                                                        }
                                                    
                                                }
                                            }
                                        }
                                    }
                                }
                                else {
                                }
                            }
                            .onChange(of: selectedDateIndex) { oldValue, newValue in
                                selectedSlot = ""
                                isLoading = true
                                let date = selectedDateIndex
                                
                                let dateF = DateFormatter()
                                dateF.dateFormat = "dd_MM_yyyy"
                                let dateString = dateF.string(from: daySlots[date])
                                
                                slotDetails.removeAll()
                                
                                FirebaseHelperFunctions().fetchSlots(doctorID: doctorID, date: dateString) { slots, error in
                                    if let slots = slots {
                                        self.slotDetails = slots
                                        isLoading = false
                                    } else {
                                        // Slots are not present
                                        self.slotDetails = [:]
                                        isLoading = false
                                    }
                                }
                            }
                        }
                        
                    }
                    .padding(.horizontal)
                    
                    Button(action: {
                        isLoading2 = true
                        print(previousDate.replacingOccurrences(of: "-", with: "_"))
                        if let selectedSlot = selectedSlot {
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "dd_MM_yyyy"
                            let date = dateFormatter.string(from: daySlots[selectedDateIndex])
                            print(date)
                            print(selectedSlot)
                            print(appointmentId)
                            self.showSuccessAnimation = true
                            FirebaseHelperFunctions().rescheduleAppointment(appointmentID: appointmentId, doctorID: doctorID, newTime: selectedSlot, newDate: date, prevDate: previousDate.replacingOccurrences(of: "-", with: "_"), prevTime: prevTime) { error in
                                
                                isLoading2 = false
                                presentationMode.wrappedValue.dismiss()
                                self.shouldDismiss = true
                            }
                        }

                    }, label: {
                        if isLoading2{
                            ProgressView()
                                .foregroundStyle(.white)
                                .frame(width: 300)
                                .padding()
                                .background(Color.accentColor)
                                .cornerRadius(15)
                        }
                        else{
                            Text("Reschedule Appointment")
                                .foregroundStyle(.white)
                                .frame(width: 300)
                                .padding()
                                .background(Color.accentColor)
                                .cornerRadius(15)
                        }
                    })
                    .disabled(selectedSlot == nil)

                }
            }
            .navigationTitle("Reschedule Appointments")
            .navigationBarTitleDisplayMode(.inline)
            .fullScreenCover(isPresented: $showSuccessAnimation) {
                // FullScreenCover for success animation
                SuccessAnimationView()
            }
            .onAppear{
                FirebaseHelperFunctions().getAppointmentData(appointmentUID: appointmentId) { Appointment, error in
                    if let drName = Appointment?.doctorName , let drSpeciality = Appointment?.doctorSpeciality{
                        doctorName = drName
                        doctorSpeciality = drSpeciality
                        deparmtentImage = drSpeciality+"-icon"
                        daySlots = getDaySlots(from: returnToday() )
                    }
                    FirebaseHelperFunctions().getDoctorID(from: appointmentId) { docID, error in
                        if let id = docID{
                            self.doctorID = id
                            
                            FirebaseHelperFunctions().fetchSlots(doctorID: doctorID, date: returnToday().replacingOccurrences(of: "-", with: "_")) { slots, error in
                                if let slots = slots {
                                    self.slotDetails = slots
                                    print(slotDetails)
                                } else {
                                    // Slots are not present
                                    print("No slots available for this doctor.")
                                }
                            }
                            
                        }
                    }
                }
            }
        }
    }
    
    func getDaySlots(from appDate: String) -> [Date] {
        var slots: [Date] = []
        
        // Create a date formatter to parse the string
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        // Parse the string to get the initial date
        guard let initialDate = dateFormatter.date(from: appDate.replacingOccurrences(of: "_", with: "-")) else {
            return slots // Return empty array if unable to parse the date
        }
        
        // Get the current calendar
        let calendar = Calendar.current
        
        // Generate dates for the next 7 days from the given date
        for i in 0..<7 {
            if let date = calendar.date(byAdding: .day, value: i, to: initialDate) {
                slots.append(date)
            }
        }
        
        return slots
    }
    
    private func slotColor(_ slot: [String: String]) -> Color {
        let time = slot.keys.first ?? ""
        return time == selectedSlot ? .myAccent : .gray.opacity(0.2)
    }
    
    func pressed(_ index : Int) -> Bool {
        if selectedDateIndex == index {
            return true
        }
        return false
    }
    
    func returnToday() ->  String{
        let datef = DateFormatter()
        datef.dateFormat = "dd-MM-yyyy"
        return datef.string(from: Date())
    }
    
    private func addNewSlot( newDate : String , newTime : String , appointmentID : String){
        let db = Firestore.firestore()
        let slotDocRef = db.collection("slots").document(doctorID)
                    
                    slotDocRef.getDocument{ document, error in
                        if let error = error {
                            print("Error fetching document: \(error)")
                            return
                        }
                        
                        guard let document = document, document.exists, var slotsData = document.data() as? [String: [[String: String]]] else {
                            print("Document does not exist or data format is incorrect.")
                            return
                        }
                        
                       
                        // Check if there are slots for the specified date and modify the slot if found
                        if var slotsForDate = slotsData[newDate] {
                            var slotFound = false
                            for i in 0..<slotsForDate.count {
                                if slotsForDate[i].keys.contains(newTime), slotsForDate[i][newTime] == "Empty"  {
                                    // Mark the slot as booked by changing its value
                                    slotsForDate[i][newTime] = appointmentID // Or "Booked" if you prefer not to use patientUID
                                    slotFound = true
                                    
                                    break
                                }
                            }
                            
                            if slotFound {
                                // Update the slots data with the modified slots for the date
                                slotsData[newDate] = slotsForDate
                                print(slotsForDate)
                                // Update the document with the new slots data
                                slotDocRef.setData(slotsData) { error in
                                    if let error = error {
                                        print("Error updating document: \(error)")
                                        
                                    } else {
                                        print("Slot booked successfully! 2" )
                                    }
                                }
                            } else {
                                print("Slot not found or already booked. 2")
                                
                            }
                        } else {
                            print("No slots available for the specified date. 2")
                        }
                    }
    }
}

//#Preview {
//    RescheduleAppointmentsView(appointmentId: "4iNknFuD9hGgCq6Z8Jsj", date: "03_05_2024")
//}

