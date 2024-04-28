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
                patientHomeSwiftUIView(userName: "Person")
                    .tabItem {
                        Label("Home", systemImage: "house")
                            .padding(.top)
                    }

                NavigationStack{
                    bookAppointmentSwiftUIView()
                }
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
