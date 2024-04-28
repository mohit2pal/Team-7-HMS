//
//  PatientView.swift
//  Team-7-HMS
//
//  Created by Subha on 28/04/24.
//

import SwiftUI

struct PatientView: View {
    @State var patientName: String
    @State var showPatientHistory: Bool
    @State var patientUid: String
    
    var body: some View {
        TabView {
            patientHomeSwiftUIView(userName: patientName)
                .tabItem {
                    Label("", systemImage: "house.fill")
                }
            SosCallSwiftUIView()
                .tabItem {
                    Label("", systemImage: "sos")
                }
            BookingView()
                .tabItem {
                    Label("", systemImage: "calendar.badge.plus")
                }
        }
        .sheet(isPresented: $showPatientHistory, content: {
            PatientHistory(isPresented: $showPatientHistory, uid: patientUid)
        })
        
    }
}

#Preview {
    PatientView(patientName: "Patient Name", showPatientHistory: true, patientUid: "hi")
}
