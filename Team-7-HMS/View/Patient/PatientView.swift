//
//  PatientView.swift
//  Team-7-HMS
//
//  Created by Subha on 28/04/24.
//

import SwiftUI

struct PatientView: View {
    @State var patientName: String
    
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
        
    }
}

#Preview {
    PatientView(patientName: "Patient Name")
}
