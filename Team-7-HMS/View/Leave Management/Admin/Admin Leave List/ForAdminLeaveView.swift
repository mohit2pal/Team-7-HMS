//
//  LeaveApprovalCardData.swift
//  Team-7-HMS
//
//  Created by Ekta  on 07/05/24.
//

import Foundation
import SwiftUI

// Defining the view for admin leave details
struct ForAdminLeaveView: View {
    @State private var leaveData: LeaveCardData? //to store leave data
    @State private var isLoading = true
    @State private var errorMessage: String?
    
    @State private var showMedicalHistorySheet: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.background.ignoresSafeArea()
                VStack {
                    if let leaveData = leaveData {
                        // Display leave details if available
                        Text("Leave Details")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding()
                        
                        Text("Date: \(leaveData.date)")
                        Text("Day: \(leaveData.day)")
                        Text("Year: \(leaveData.year)")
                        Text("Doctor Name: \(leaveData.DoctorName)")
                        Text("Status: \(leaveData.status)")
                        
                    } else if isLoading {
                        ProgressView("Loading...")
                    } else if let errorMessage = errorMessage {
                        Text(errorMessage)
                    } else {
                        Text("No leave data available")
                    }
                }
                .padding([.top, .leading, .trailing], 25)
                .onAppear {
                    fetchLeaveData()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Leave Details")
        }
    }
    
    // Function to fetch leave data
    private func fetchLeaveData() {
        // Simulated data fetching delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // Simulated leave data
            let leaveData = LeaveMockData.LeaveDataArray.first
            isLoading = false
            self.leaveData = leaveData
        }
    }
}
#Preview {
    ForAdminLeaveView()
}
