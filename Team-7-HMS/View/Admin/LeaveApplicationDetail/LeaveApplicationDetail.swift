//
//  LeaveApplicationDetail.swift
//  Team-7-HMS
//
//  Created by Ritwatz on 07/05/24.
//

import SwiftUI

struct LeaveApplicationDetail: View {
    // Example LeaveApplication data
    let leaveApplication = LeaveApplication(doctorName: "Dr. Smith",
                                            leavesAvailable: 20,
                                            totalLeavesTaken: 5,
                                            subject: "Sick Leave",
                                            description: "Feeling unwell",
                                            fromDate: Date(),
                                            toDate: Date())
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    VStack{
                        Text(leaveApplication.doctorName)
                            .font(.title3)
                    }
                    HStack {
                        VStack {
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(Color.myAccent)
                                .frame(width: 100, height: 100, alignment: .center)
                                .overlay(
                                    VStack {
                                        Text("\(leaveApplication.leavesAvailable - leaveApplication.totalLeavesTaken)")
                                            .font(.title)
                                            .foregroundColor(.white)
                                            .bold()
                                        Text("Leaves Left")
                                            .font(.caption)
                                            .foregroundColor(.white)
                                    }
                                )
                                .padding(.vertical, 10)
                        }
                        Spacer()
//                        RoundedRectangle(cornerRadius: 50)
//                            .foregroundColor(.gray)
//                            .frame(width: 2, height: 33)
                        Spacer()
                        VStack {
                            HStack {
                                Spacer()
                                VStack {
                                    Text("\(leaveApplication.leavesAvailable)")
                                        .font(.title)
                                        .bold()
                                    Text("Total Leaves")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                RoundedRectangle(cornerRadius: 50)
                                    .foregroundColor(.gray)
                                    .frame(width: 2, height: 33)
                                Spacer()
                                VStack {
                                    Text("\(leaveApplication.totalLeavesTaken)")
                                        .font(.title)
                                        .bold()
                                    Text("Leaves Taken")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                            }
                            .padding()//Hstack Closes
                            
                        }
                        .background(RoundedRectangle(cornerRadius: 20).foregroundColor(Color.gray.opacity(0.1)).frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/))
                        .padding(.vertical, 10)
                    }
                    HStack{
                        
                    }
                    Text("Subject: \(leaveApplication.subject)")
                    Text("Description: \(leaveApplication.description)")
                    Text("Leave From Date: \(formattedDate(leaveApplication.fromDate))")
                    Text("Leave To Date: \(formattedDate(leaveApplication.toDate))")
                }
                .padding()
                .navigationTitle("Leave Approval")
            }
        }
    }
    
    // Helper function to format date
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

// Preview
struct LeaveApplicationDetail_Previews: PreviewProvider {
    static var previews: some View {
        LeaveApplicationDetail()
    }
}

