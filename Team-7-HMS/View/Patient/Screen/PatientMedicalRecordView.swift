//
//  PatientMedicalRecordView.swift
//  Team-7-HMS
//
//  Created by Meghs on 05/05/24.
//

import SwiftUI
import Firebase

struct PatientMedicalRecordView: View {
    @State private var selectedSegmentIndex : Int = 0
    let segments : [String] = ["Upcoming" , "Completed"]
    var body: some View {
        NavigationView{
            ZStack{
                Color.background.ignoresSafeArea()
                VStack{
                    Picker(selection: $selectedSegmentIndex, label: Text("")) {
                                   ForEach(0..<2) { index in
                                       Text(segments[index])
                                           .tag(index)
                            }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    if selectedSegmentIndex == 0 {
                        UpcomingMedicalRecodsView()
                    }
                    else {
                        CompletedMedicalTestsView()
                    }
                }
                .padding(.horizontal)
            }
            
            .navigationTitle("Medical Records")
        }
    }
}

#Preview {
    PatientMedicalRecordView()
}
