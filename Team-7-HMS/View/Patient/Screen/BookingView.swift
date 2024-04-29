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
        ZStack {
            VStack(alignment: .leading) {
                Text("Book appointment").font(.system(size: 32, weight: .bold)).tracking(-0.41)
                
                TextField("Search for Doctors, Specialities or Symptoms", text: $search)
                    .font(.system(size: 13, weight: .regular)).foregroundColor(Color(#colorLiteral(red: 0.11, green: 0.11, blue: 0.11, alpha: 0.6))).tracking(-0.41)
                    .foregroundColor(Color.gray)
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.never)
                
                Picker("Views", selection: $selectedView) {
                    Text("Appointments").tag(0)
                    Text("Lab Test").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                Spacer()
                
                if selectedView == 0 {
                    bookAppointmentSwiftUIView(patientUID: patientID)
                        
                } else {
                    EmptyView()
                }
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    BookingView(patientID: "hi")
}
