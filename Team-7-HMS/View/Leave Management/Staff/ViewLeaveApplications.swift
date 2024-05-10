//
//  ViewLeaveApplications.swift
//  Team-7-HMS
//
//  Created by Meghs on 09/05/24.
//

import SwiftUI
import Firebase
struct ViewLeaveApplications: View {
    var docID : String {
        Auth.auth().currentUser?.uid ?? "ZP7zbZTBrsRNoSS4xd6NoZw60uG2"
    }
    @State var isLoading = false
    
    @State var LeaveData : [LeaveManagementCard] = []
    var body: some View {
        NavigationView{
            ZStack{
                Color.background.ignoresSafeArea()
                ScrollView{
                    if isLoading {
                        ProgressView()
                    }
                    else{
                        if !LeaveData.isEmpty{
                            ForEach(LeaveData.indices , id : \.self){ index in
                                HStack{
                                    VStack(alignment : .leading){
                                        HStack{
                                            Text("Leave Application ID : ")
                                            Text(LeaveData[index].id.suffix(5))
                                        }
                                        .font(.title3)
                                        .bold()
                                        
                                        HStack{
                                            Text("Date Applied")
                                                .bold()
                                            Text(LeaveData[index].appliedDate)
                                        }
                                        HStack{
                                            Text("Days since applied: ")
                                            Text("\(calculateWaitingDays(appliedDateString: LeaveData[index].appliedDate)) Days")
                                        }
                                        .font(.callout)
                                        
                                        
                                        HStack{
                                            Text("Status of Approval :")
                                                .bold()
                                            Text(LeaveData[index].status + " " )
                                                .foregroundStyle(LeaveData[index].status == "Pending" ? .red : LeaveData[index].status == "Rejected" ? .red : .green)
                                            if LeaveData[index].status == "Pending" {
                                                ProgressView()
                                                    .progressViewStyle(CircularProgressViewStyle(tint: .red))
                                            }
                                            else if LeaveData[index].status == "Approved"{
                                                Image(systemName: "checkmark.circle")
                                                    .foregroundStyle(.green)
                                            }
                                            else {
                                                Image(systemName: "multiply.circle.fill")
                                                    .foregroundStyle(.red)
                                            }
                                        }
                                    }
                                    
                                    Spacer()
                                    
                                    VStack{
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                        Spacer()
                                    }
                                    
                                }
                                .frame(width: 330)
                                .padding()
                                .background(.white)
                                .cornerRadius(15)
                                .shadow(color: .black.opacity(0.3), radius: 0.5 , x:1 , y: 1)
                                
                            }
                        }
                        else{
                            
                        }
                    }
                }
            }
            .onAppear{
                isLoading = true
                FirebaseHelperFunctions().fetchLeaveManagementData(docID: docID) { dataCards, error in
                    if let data = dataCards {
                        self.LeaveData = data
                        isLoading = false
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

#Preview {
    ViewLeaveApplications()
}

func calculateWaitingDays(appliedDateString: String) -> Int {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd-MM-yyyy"
    
    guard let appliedDate = dateFormatter.date(from: appliedDateString) else {
        return 0 // Return 0 if the applied date cannot be parsed
    }
    
    let currentDate = Date()
    let calendar = Calendar.current
    let components = calendar.dateComponents([.day], from: appliedDate, to: currentDate)
    
    if let days = components.day {
        return days
    } else {
        return 0
    }
}
