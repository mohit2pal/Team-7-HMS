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
        NavigationView{
            TabView {
                patientHomeSwiftUIView(patientUID: patientUid, userName: patientName)
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                
                
                BookingView(patientID: patientUid)
                
                    .tabItem {
                        Label("Book Appointment", systemImage: "plus")
                    }
                NavigationStack{
                    PatientMedicalRecordView()
                }
                .tabItem {
                    Label("Medical Tests" , systemImage:  "doc.fill")
                }
            }
            .sheet(isPresented: $showPatientHistory, content: {
                PatientHistory(isPresented: $showPatientHistory, uid: patientUid)
            })
        }
    }
}

#Preview {
    PatientView(patientName: "Patient Name", showPatientHistory: true, patientUid: "Vzo9cLiS9fZTyzpzkeH0Vure5YP2")
}
