//
//  PatientView.swift
//  Team-7-HMS
//
//  Created by Subha on 28/04/24.
//

import SwiftUI

struct PatientView: View {
    @State var patient: Patient
    
    var body: some View {
        TabView {
            patientHomeSwiftUIView(userName: patient.name)
                .tabItem {
                    Label("", systemImage: "house.fill")
                }
            SosCallSwiftUIView()
                .tabItem {
                    Label("", systemImage: "sos")
                }
            
        }
        
    }
}

#Preview {
    PatientView(patient: Patient(name: "Patient", email: "patient@team7.com"))
}
