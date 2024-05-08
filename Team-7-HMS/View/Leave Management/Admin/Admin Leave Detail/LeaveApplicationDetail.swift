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
                                            description: "Feeling unwell and having a lot of pain the head and throat",
                                            fromDate: Date(),
                                            toDate: Date())
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    VStack{
                        Text(leaveApplication.doctorName)
                            .font(.title2)
                            .fontWeight(.semibold)
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
                    }// end of leave view
                    HStack{
                        VStack {
                            HStack{
                                Spacer()
                                Text("From:")
                                Text(" \(formattedDate(leaveApplication.fromDate))")
                                    .fontWeight(.semibold)
                                Spacer()
                    
                            }
                            .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.gray.opacity(0.1)).frame(height: 50))
                        }
                        //.padding(.vertical, 10)
                        Spacer()
                        VStack {
                            HStack{
                                Spacer()
                                Text("To:")
                                Text(" \(formattedDate(leaveApplication.toDate))")
                                    .fontWeight(.semibold)
                                Spacer()
                    
                            }
                            .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.gray.opacity(0.1)).frame(height: 50))
                        }
                        //.padding(.vertical, 10)
                    }
                    Spacer()
                    VStack() {
                        HStack(){
                            
                            Text("Subject:")
                                .padding(.leading)
                                .fontWeight(.semibold)
                            Text("\(leaveApplication.subject)")
                            Spacer()
            
                        }
                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.gray.opacity(0.1)).frame(height: 50))
                    }
                    Spacer()
                    VStack() {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .frame(height: 200)//Change the size here for change the backfround size of desxription
                                .foregroundColor(Color.gray.opacity(0.1))
                                .lineLimit(8)
                            
                            VStack() {
                                HStack{
                                    Text("Description:")
                                        .fontWeight(.semibold)
                                    Spacer()
                                }
                                HStack {
                                    Text("\(leaveApplication.description)")
                                    Spacer()
                                }
                                Spacer()
                            }
                            .padding()
                        }
                    }
//                    VStack(){
//                        HStack(alignment:.top){
//                            
//                            Text("Description:")
//                                .padding(.leading)
//                            Spacer()
//            
//                        }
//                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.gray.opacity(0.1)).frame(height: 50))
//                    }
                    
                    Button(action: {}, label: {
                        Text("Confirm")
                            .frame(width: 300)
                            .padding()
                            .foregroundStyle(Color.white)
                            .background(Color.myAccent)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        
                    })
                    .padding(.leading)
                    
                    Button(action: {}, label: {
                        Text("Reject")
                            .frame(width: 300)
                            .padding()
                            .foregroundStyle(Color.white)
                            .background(Color.red.opacity(0.8))
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        
                    })
                    .padding(.leading)
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
