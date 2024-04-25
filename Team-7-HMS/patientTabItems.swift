//
//  patientTabItems.swift
//  Team-7-HMS
//
//  Created by Vikashini G on 25/04/24.
//

import SwiftUI

struct patientTabItems: View {
    var body: some View {
        NavigationStack {
            TabView {
                patientHomeSwiftUIView(userName: "Person", userHeight: 123, userWeight: 32, userHeart: 12, userSleep: 8)
                    .tabItem {
                        Label("Home", systemImage: "house")
                            .padding(.top)
                    }

                bookAppointmentSwiftUIView()
                    .tabItem {
                        Label("Book" , systemImage: "plus.circle.fill")
                    }
                
                SosCallSwiftUIView()
                    .tabItem {
                        Label("Call Help" , systemImage: "phone.fill")
                    }
            }
        }
        .tint(Color.accent)
        .accentColor(Color.accent)
    }
}

#Preview {
    patientTabItems()
}
