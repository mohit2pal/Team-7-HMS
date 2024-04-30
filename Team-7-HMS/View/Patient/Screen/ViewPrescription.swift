//
//  ViewPrescription.swift
//  Team-7-HMS
//
//  Created by Ekta  on 30/04/24.
//

import SwiftUI

struct ViewPrescription: View {
    @State var appointmentData: AppointmentCardData
    
    var body: some View {
        NavigationView {
            List {
                
                patientAppointmentCard(appointmentData: appointmentData).buttonBorderShape(.roundedRectangle).cornerRadius(30)
                            
                   .frame(maxWidth: .infinity, alignment: .center)
                Section(header: Text("Symptoms")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(Color.black)) {
                    Text("Rashes, Fever")
                }
                Section(header: Text("Diagnosis")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(Color.black)) {
                    Text("Medicine Allergy")
                }
                Section(header: Text("Prescribed Medicines")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(Color.black)) {
                    HStack {
                        Text("Allegra 180")
                        Spacer()
                        VStack{
                            HStack{
                                Text("1")
                                Spacer()
                                Text("0")
                                Spacer()
                                Text("1")
                            }
                            .frame(width: 100)
                            HStack{
                                Text("M")
                                Spacer()
                                Text("A")
                                Spacer()
                                Text("N")
                            }
                            .frame(width: 100)
                        }
                        
                    }
                }
                Section(header: Text("Lab Tests")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(Color.black)) {
                    Text("Serum IgE, CBC")
                }
                Section(header: Text("Follow Up")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(Color.black)) {
                    Text("After 10 days with the mentioned reports")
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Prescription")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {}) {
                        Image(systemName: "chevron.left")
                    }
                }
            }
        }
        .tabViewStyle(DefaultTabViewStyle())
        .tabItem {
            Image(systemName: "house")
            Text("Home")
        }
        .tabItem {
            Image(systemName: "book")
            Text("Booking")
        }
        .tabItem {
            Image(systemName: "doc.text")
            Text("Records")
        }
        .tabItem {
            Image(systemName: "person")
            Text("Profile")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ViewPrescription(appointmentData: AppointmentMockData.appointmentDataArray[0])
    }
}
