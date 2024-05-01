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
            ZStack{
                Color(red: 245 / 255, green: 245 / 255, blue: 245 / 255)
                    .ignoresSafeArea()
                VStack(alignment: .leading) {
                    HStack {
                        
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color("PrimaryColor"))
                            .padding(.leading, 8)
                        
                        TextField("Search tests & Specialities", text: $searchText)
                            .padding(.trailing)
                            .padding(.vertical, 8)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(.white))
                            .shadow(radius: 2)
                            .frame(width: 355)
                    )
                    Spacer(minLength: 20)
                    Picker("View", selection: $selectedPicker){
                        Text("Appointments").tag(0)
                        Text("Lab test").tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .background(Color("PrimaryColor").opacity(0.6))
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
            }
        }
    }
}

#Preview {
    PickerView()
}
