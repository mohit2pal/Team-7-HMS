//
//  LeaveApprovalCardData.swift
//  Team-7-HMS
//
//  Created by Ekta  on 07/05/24.
//

import Foundation
import SwiftUI

// Define the view for admin leave details
struct ForAdminLeaveView: View {
    @State private var leaveData: LeaveCardData? // State to store leave data
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
                        // Show loading indicator while data is being fetched
                        ProgressView("Loading...")
                    } else if let errorMessage = errorMessage {
                        // Show error message if data fetching fails
                        Text(errorMessage)
                    } else {
                        // Show a message when no data is available
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
            let leaveData = LeaveMockData.LeaveDataArray.first // Assuming you have leave data
            
            // Updating state variables
            isLoading = false
            self.leaveData = leaveData
        }
    }
}

// Preview code
#Preview {
    ForAdminLeaveView()
}
