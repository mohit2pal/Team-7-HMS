//
//  AdminLeaveApproval.swift
//  Team-7-HMS
//
//  Created by Ekta  on 07/05/24.
//

import SwiftUI

struct AdminLeaveList: View {
    let LeaveData: [LeaveCardData]
    @State private var PickerSelection = 0
    var filteredLeaveData: [LeaveCardData] {
        if PickerSelection == 0 {
            // Filter for pending requests
            return LeaveData.filter { $0.status == "Pending" }
        } else {
            // Filter for approved requests
            return LeaveData.filter { $0.status == "Approved" }
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    Color(UIColor(red: 0.98, green: 0.98, blue: 0.99, alpha: 1.00)).edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        Picker("View", selection: $PickerSelection){
                            Text("Pending").tag(0)
                            Text("Approved").tag(1)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                        if filteredLeaveData.isEmpty {
                            Text("No \(PickerSelection == 0 ? "pending" : "approved") requests.")
                                .foregroundColor(.gray)
                                .padding()
                        } else {
                            ForEach(filteredLeaveData) { data in
                                LeaveCard(leaveData: data)
                            }
                            .listStyle(.plain)
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle("Leave Requests")
        }
    }
}

#Preview {
    AdminLeaveList(LeaveData: LeaveMockData.LeaveDataArray)
}
