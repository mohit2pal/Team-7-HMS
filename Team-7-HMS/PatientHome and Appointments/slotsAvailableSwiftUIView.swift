//
//  slotsAvailableSwiftUIView.swift
//  Team-7-HMS
//
//  Created by Vikashini G on 24/04/24.
//

import SwiftUI

struct slotsAvailableSwiftUIView: View {
    
    @State private var isBooking = false
    @State private var bookingCompleted = false
    
    var patientUID : String
    @State private var doctorDetails: [String: Any]? // Optional dictionary
    @State private var slotDetails : [String : Any]?
    @State private var selectedSlot: String?
    let doctorName: String
    let date : String
    @State var doctorId : String
    var body: some View {
        VStack {
          
            
            if doctorDetails != nil && !doctorDetails!.isEmpty { // Check if doctorDetails is not nil and not empty
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 12){
                        Text(doctorName)
                            .font(CentFont.largeSemiBold)
                        Text(doctorDetails?["speciality"] as? String ?? "")
                            .font(.title2)
                        Text(doctorDetails?["education"] as? String ?? "")   .font(.subheadline)
                        HStack{
                            Text("\(doctorDetails?["experience"] as? Int ?? 0) years of Experience")
                        }
                        .font(.subheadline)
                    }
                    Spacer()
                    
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                }
                .padding()
                .padding(.vertical)
                .foregroundStyle(.white)
                .background(Color.myAccent)
                .cornerRadius(28)
                .customShadow()
            } else {
                ProgressView()
            }
                        
            VStack {
                if let slotDetails = slotDetails as? [String: [[String: String]]] {
                    ForEach(slotDetails.sorted(by: { $0.key < $1.key }), id: \.key) { date, slots in
                        HStack{
                            Text("Selected date: ")
                                .font(.headline)
                            Text(date.replacingOccurrences(of: "_", with: "-"))
                                .foregroundStyle(Color.gray)
                                .font(.headline)
                        }
                        .padding()

                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(slots, id: \.self) { slot in
                                    let time = slot.keys.first ?? ""
                                    Text(time)
                                        .padding()
                                        .background(slotColor(slot))
                                        .cornerRadius(8)
                                        .onTapGesture {
                                            // Handle slot selection
                                            selectedSlot = time
                                            print(selectedSlot!)
                                            print(self.doctorId)
                                        }
                                    
                                }
                            }
                        }.scrollIndicators(.hidden)
                        
                    }
                } else {
                    Text("No slots available")
                        .foregroundStyle(Color.gray)
                        .padding()
                }
            }

            Spacer()
            
            Button {
                isBooking = true
                // Ensure a slot is selected before attempting to book
                guard let selectedSlot = selectedSlot else {
                    print("No slot selected")
                    return
                }
                
                // Call the bookSlot function
                FirebaseHelperFunctions.bookSlot(doctorUID: doctorId, date: date, slotTime: selectedSlot, patientUID: patientUID) { result in
                    switch result {
                    case .success(let successMessage):
                        print(successMessage)
                        // Handle successful booking, e.g., show an alert or update the UI
                        
                    case .failure(let error):
                        print("Failed to book slot: \(error)")
                        // Handle failure, e.g., show an error message
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // 2 seconds delay
                    self.isBooking = false
                    self.bookingCompleted = true
                }
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(#colorLiteral(red: 0.48627451062202454, green: 0.5882353186607361, blue: 1, alpha: 1)))
                        .frame(width: 296, height: 44)
                    
                    if isBooking {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(0.5)
                    } else if bookingCompleted {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                            .scaleEffect(1.5)
                            .transition(.scale)
                    } else {
                            //PATIENT
                            Text("Book Selected Slots").font(.system(size: 20, weight: .regular))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                    }
                }
            }
            
            
        }
        .padding()
        .background(Color.background)
        .onAppear {
            fetchDoctorsDetails(name: doctorName) { details, error in
                if let error = error {
                    print("Error fetching doctor details: \(error)")
                } else {
                    self.doctorDetails = details
                }
                
                //fetching free slots for the doctor
                FirebaseHelperFunctions().fetchSlots(doctorID: doctorId, date: date) { slots, error in
                    if let error = error {
                        print("Error fetching slots: \(error)")
                    } else {
                        if let slots = slots {
                            // Slots are present, assign them to the state variable
                            self.slotDetails = slots
                            print(slotDetails ?? "")
                        } else {
                            // Slots are not present
                            print("No slots available for this doctor.")
                        }
                    }
                }

            }
            
            
        }
    }
    
    private func slotColor(_ slot: [String: String]) -> Color {
        let time = slot.keys.first ?? ""
        return time == selectedSlot ? .myAccent : .gray.opacity(0.2)
    }
}


struct doctorInfoCard: View{
    var body: some View {
        HStack(alignment: .top){
            VStack(alignment: .leading, spacing: 18){
                Text("Dr. Harry Potter")
                    .font(CentFont.largeSemiBold)
                Text("General Physician")
                    .font(.title2)
                Text("(MBBS, Ph.D, Fellow, International College of Surgeons)")
                    .font(.subheadline)
                Text("15 years of Experience")
                    .font(.subheadline)
            }
            Spacer()
            Image(systemName: "person.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
        }
        .padding()
        .padding(.vertical)
        .foregroundStyle(.white)
        .background(Color.myAccent)
        .cornerRadius(28)
        .customShadow()
        
        
    }
    
    
}

#Preview {
    slotsAvailableSwiftUIView(patientUID: "", doctorName: "Nithin Reddy", date: "28_04_2024", doctorId: "3npmgJzI3gSWiBpnTdTRTCEBPtX2")

}
