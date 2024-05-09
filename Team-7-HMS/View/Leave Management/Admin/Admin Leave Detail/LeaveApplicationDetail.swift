//
//  LeaveApplicationDetail.swift
//  Team-7-HMS
//
//  Created by Ritwatz on 07/05/24.
//

import SwiftUI

struct LeaveApplicationDetail: View {

    
    @State var leaveData : leaveManagementInfo
    @Environment(\.presentationMode) var presentationMode
    @State private var showSuccessAnimation: Bool = false
    @State private var failSuccessAnimation: Bool = false

    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading){
                        Text(leaveData.doctorName)
                            .font(.title2)
                            .fontWeight(.bold)
                        Text(leaveData.doctorDepartment + " Department")
                            .font(.title2)
                            .bold()
                    }
                    HStack {
                        VStack {
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(Color.myAccent)
                                .frame(width: 100, height: 100, alignment: .center)
                                .overlay(
                                    VStack {
                                        Text("15")
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

                        Spacer()
                        VStack {
                            HStack {
                                Spacer()
                                VStack {
                                    Text("21")
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
                                    Text("15")
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
                                Text(" \(formattedDate(leaveData.fromDate))")
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
                                Text(" \(formattedDate(leaveData.toDate))")
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
                            Text("Leave application")
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
                                    Text("\(leaveData.description)")
                                    Spacer()
                                }
                                Spacer()
                            }
                            .padding()
                        }
                    }
                    Button(action: {
                        FirebaseHelperFunctions().updateLeave(leaveID: leaveData.id, doctorID: leaveData.docID, status: "Approved")
                         showSuccessAnimation = true

                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.showSuccessAnimation = false
                            presentationMode.wrappedValue.dismiss()
                        }
                    }, label: {
                        Text("Confirm")
                            .frame(width: 300)
                            .padding()
                            .foregroundStyle(Color.white)
                            .background(Color.myAccent)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        
                    })
                    .padding(.leading)
                    
                    Button(action: {
                        FirebaseHelperFunctions().updateLeave(leaveID: leaveData.id, doctorID: leaveData.docID, status: "Rejected")
                        
                        failSuccessAnimation = true

                       DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                           self.failSuccessAnimation = false
                           presentationMode.wrappedValue.dismiss()
                       }


                    }, label: {
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
                .fullScreenCover(isPresented: $showSuccessAnimation) {
                    SuccessAnimationView()
                }
                .fullScreenCover(isPresented: $failSuccessAnimation) {
                    FailureAnimationView()
                }
                .toolbar{
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            HStack{
                                Image(systemName: "chevron.left")
                                    .bold()
                                Text("Back")
                            }
                            .foregroundColor(.blue)
                        })
                    }
                }
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
        LeaveApplicationDetail(leaveData: leaveManagementInfo(
            id: "1",
            fromDate: Date(),
            toDate: Date(),
            status: "Pending",
            description: "Family emergency",
            doctorName: "Dr. John Doe",
            doctorDepartment: "Cardiology", docID: " "
        ))
    }
}
