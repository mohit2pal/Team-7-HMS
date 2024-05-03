//
//  LabRecords.swift
//  Team-7-HMS
//
//  Created by Ekta  on 03/05/24.
//

import SwiftUI

struct LabRecords: View {
    let labTestData: [LabTestCardData]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor(red: 0.98, green: 0.98, blue: 0.99, alpha: 1.00)).edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    Text("Lab Reports")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.top, 20)
                    
                    List {
                        ForEach(labTestData) { data in
                            LabTestCard(labTestData: data)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    LabRecords(labTestData: LabTestMockData.labTestDataArray)
}

