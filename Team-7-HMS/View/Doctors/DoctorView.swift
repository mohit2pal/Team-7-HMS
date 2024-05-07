//
//  DoctorView.swift
//  Team-7-HMS
//
//  Created by Subha on 30/04/24.
//

import SwiftUI

struct DoctorView : View {
    @State var doctorUid: String
    @State var doctorDetails: DoctorDetails
    @State var doctorName: String
    var body: some View {
        NavigationView{
            TabView {
                DoctorHomeSwiftUI(doctorUid: doctorUid, doctor: doctorDetails, doctorName: doctorName)
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                
                ReportsListView()
                
                    .tabItem {
                        Label("Upload Reports", systemImage: "doc.text.magnifyingglass")
                    }
            }
        }
    }
}

#Preview {
    DoctorView(doctorUid: "hi", doctorDetails: DoctorDetails(dictionary: mockDoctorData)!, doctorName: "Harish")
}
