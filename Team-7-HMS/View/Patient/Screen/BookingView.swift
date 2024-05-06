//
//  BookingView.swift
//  Team-7-HMS
//
//  Created by Subha on 28/04/24.
//

import SwiftUI

struct BookingView: View {
    @State var patientID: String
    @State private var search: String = ""
    @State private var selectedView = 0
    var body: some View {
        NavigationView{
            ZStack {
                VStack(alignment: .leading) {
                    HStack{
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color("PrimaryColor"))
                            .padding(.leading, 8)
                        TextField("Doctors, Specialities or Symptoms", text: $search)
                    }
                        .padding(8)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .foregroundColor(Color.gray)
                        .textFieldStyle(.plain)
                        .textInputAutocapitalization(.never)
                    
                    Picker("Views", selection: $selectedView) {
                        Text("Appointments").tag(0)
                        Text("Lab Test").tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    Spacer()
                    
                    if selectedView == 0 {
                        bookAppointmentSwiftUIView(patientUID: patientID)
//                            .navigationTitle("Book Appointment")
                        
                    } else {
                        BookLabRecordsView()
//                            .navigationTitle("Book Labs")
                    }
                    Spacer()
                }
                .navigationTitle("Book Appointment")
                .padding()
                .background(Color.background)
            }
        }
    }
}

#Preview {
        BookingView(patientID: "hi")
}
