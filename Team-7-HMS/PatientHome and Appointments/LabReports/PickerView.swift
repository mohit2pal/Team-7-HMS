//
//  PickerView.swift
//  Team-7-HMS
//
//  Created by Ekta  on 29/04/24.
//

import Foundation
import SwiftUI

struct PickerView: View {
    @State private var searchText = ""
    @State private var selectedPicker = 0
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color("PrimaryColor"))
                        .padding(.leading, 8)
                    
                    TextField("Search Specialities & Tests", text: $searchText)
                        .padding(.trailing)
                }
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                Spacer(minLength: 20)
                Picker("View", selection: $selectedPicker){
                    Text("Appointments").tag(0)
                    Text("Lab test").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Spacer(minLength: 20)
                if selectedPicker == 0 {
                    BookAppointment()
                        .navigationBarTitle("Book Appointments", displayMode: .large)
                } else {
                    BookLab()
                        .navigationBarTitle("Book lab tests", displayMode: .large)
                }
                
            }
            .padding()
            .background(Color.background)
        }
    }
}

#Preview {
    PickerView()
}
