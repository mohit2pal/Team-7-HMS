//
//  AdminHomeView.swift
//  Team-7-HMS
//
//  Created by Subha on 28/04/24.
//

import SwiftUI

struct AdminHomeView: View {
    var body: some View {
        TabView {
            AdminDashboard()
                .tabItem {
                    Label("Dashboard", systemImage: "list.number")
                }
            AddingSlots()
                .tabItem {
                    Label("Add Slots", systemImage: "calendar.badge.plus")
                }
            NavigationView{
                AddDoctorDetails()
            }
            .tabItem {
                Label("Add Doctors", systemImage: "person.badge.plus")
            }
        }
    }
}

#Preview {
    AdminHomeView()
}
