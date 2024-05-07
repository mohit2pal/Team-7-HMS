//
//  LeaveApprovalCardData.swift
//  Team-7-HMS
//
//  Created by Ekta  on 07/05/24.
//

import SwiftUI

struct LeaveCard: View {
    var leaveData: LeaveCardData
    
    var body: some View {
        NavigationLink(destination: ForAdminLeaveView()) {
            HStack(spacing: 10){
                Text(leaveData.date)
                    .foregroundColor(.white)
                    .font(.title3)
                    .padding()
                    .frame(width: 90, height: 90)
                    .background(Color.myAccent)
                    .cornerRadius(50)
                    .foregroundColor(.white)
                HStack{
                    VStack(alignment: .leading, spacing: 5){
                        Text(leaveData.DoctorName)
                            .foregroundColor(.black)
                            .font(.title3)
                            .padding(.init(top: 0, leading: 0, bottom: 1, trailing: 0))
                        Text("\(leaveData.status)")
                            .foregroundColor(.black)
                            .font(.title3)
                            .padding(.init(top: 0, leading: 0, bottom: 1, trailing: 0))
                        Text("\(leaveData.nodays) days of leave")
                            .foregroundColor(.black)
                            .font(.title3)
                        
                    }
                    Spacer()
                    NavigationLink(destination: ForAdminLeaveView()) {
                        Image("Arrow")
                            .rotationEffect(.degrees(180))
                            .foregroundColor(Color("PrimaryColor"))
                    }
                }
                .padding()
                .background(.white)
                .cornerRadius(20)
                .customShadow()
            }
        }
    }
}

#Preview {
    NavigationStack{
        LeaveCard(leaveData: LeaveMockData.LeaveDataArray[0])
    }
}
