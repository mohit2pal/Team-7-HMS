//
//  PendingLeaveRequestsView.swift
//  Team-7-HMS
//
//  Created by Meghs on 09/05/24.
//

import SwiftUI

struct PendingLeaveRequestsView: View {
    @State var leaveInfo : [leaveManagementInfo]?
    var body: some View {
        NavigationView{
            ZStack{
                Color.background.ignoresSafeArea()
                ScrollView{
                    VStack{
                        if let leaveInfo = leaveInfo {
                            ForEach(leaveInfo.indices , id : \.self){ index in
                               
                                NavigationLink {
                                    LeaveApplicationDetail(leaveData: leaveInfo[index])
                                        .navigationBarBackButtonHidden()
                                } label: {
                                    
                                    HStack{
                                        VStack(alignment : .leading){
                                            HStack{
                                                Text("Leave ID : " )
                                                Text(leaveInfo[index].id.suffix(5))
                                            }
                                            .font(.title3)
                                            .bold()
                                            Text("Dr. " + leaveInfo[index].doctorName)
                                                .font(.title3)
                                                .bold()
                                            Text(leaveInfo[index].doctorDepartment + " Deparment")
                                            HStack{
                                                Text("\(getDateString(date: leaveInfo[index].fromDate)) -> \(getDateString(date: leaveInfo[index].toDate))")
                                            }
                                        }
                                        Spacer()
                                        VStack{
                                            Spacer()
                                            Image(systemName: "chevron.right")
                                            Spacer()
                                        }
                                    }
                                    .foregroundStyle(.black)
                                    .frame(width: 300)
                                    .padding()
                                    .background(.white)
                                    .cornerRadius(15)
                                    .customShadow()
                                }
                                    
                                
                                
                            }
                        }
                     
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
        .onAppear {
            FirebaseHelperFunctions().fetchLeaveData { data, error in
                if let data = data {
                    // Filter leave data for pending requests
                    let pendingRequests = data.filter { $0.status == "Pending" }
                    self.leaveInfo = pendingRequests
                } else if let error = error {
                    print("Error fetching leave data: \(error.localizedDescription)")
                }
            }
        }
    }
}

#Preview {
    PendingLeaveRequestsView()
}
