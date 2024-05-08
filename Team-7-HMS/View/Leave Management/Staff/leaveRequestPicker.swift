//
//  leaveRequestPicker.swift
//  Team-7-HMS
//
//  Created by Vikashini G on 07/05/24.
//

import SwiftUI

struct leaveRequestPicker: View {
    @State var doctor: DoctorDetails
    @State var doctorUid: String
    @State private var searchText = ""
    @State private var selectedPicker = 0
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Picker("View", selection: $selectedPicker){
                    Text("Leave Application").tag(0)
                    Text("Slot Change").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                Spacer(minLength: 20)
                if selectedPicker == 0 {
                    doctorLeaveApplication()
                        .navigationBarTitle("Leave Application", displayMode: .inline)
                } else {
                    slotChangeDoctor(doctor: doctor, doctorUid: doctorUid)
                        .navigationBarTitle("Slot Change", displayMode: .inline)
                }
                
            }
            .padding()
            .background(Color.background)
        }
    }
}

#Preview {
    leaveRequestPicker(doctor: DoctorDetails(dictionary: mockDoctorData)!, doctorUid: "3npmgJzI3gSWiBpnTdTRTCEBPtX2")
}
