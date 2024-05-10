//
//  doctorLeaveApplication.swift
//  Team-7-HMS
//
//  Created by Himal Pandey on 07/05/2024.
//

import SwiftUI
import Firebase
struct doctorLeaveApplication: View {
    @State var fromDate = Date()
    @State var toDate = Date()
    @State var subject = ""
    @State var desc = ""
    @State private var selectedReasonIndex = 0
    @State var dateString = ""
    var docId : String {
        Auth.auth().currentUser?.uid ?? ""
    }
    @State var error = false
    // Variables for Total Leaves, Leaves Left, and Leaves Taken
    let totalLeaves = 21
    @State var leavesTaken : Int = 0
    var leavesLeft: Int {
        totalLeaves - leavesTaken
    }
    
    var doctorId : String {
        Auth.auth().currentUser?.uid ?? ""
    }
    
    @State private var showSuccessAnimation: Bool = false
    
    // Variable to store the minimum selectable date
    var minSelectableDate: Date {
        Calendar.current.date(byAdding: .day, value: 7, to: Date()) ?? Date()
    }
    
    // Variable to store the maximum selectable date based on available leaves
    var maxSelectableDate: Date {
        // Calculate the maximum selectable date only if leavesLeft is greater than 0
        guard leavesLeft > 0 else { return Date() } // Use current date as default
        
        return Calendar.autoupdatingCurrent.date(byAdding: .day, value: leavesLeft-1, to: fromDate) ?? Date()
    }
    
    // Variable to determine if the toDate should be disabled
    var isToDateDisabled: Bool {
        // Disable toDate if fromDate is not selected or if leavesLeft is zero
        return fromDate == Date() || leavesLeft == 0
    }
    
    // Calculate the number of days
    @State var numberOfDays: Int?
//    {
//        // Calculate the difference in days between fromDate and toDate
//        let calendar = Calendar.current
//        let components = calendar.dateComponents([.day], from: fromDate, to: toDate)
//
//        // Return the difference including both the start and end dates
//        return (components.day ?? 0) + 1
//    }
        
    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false){
            VStack{
                HStack {
                    VStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color.myAccent)
                            .frame(width: 100, height: 100, alignment: .center)
                            .overlay(
                                VStack {
                                    Text("\(leavesLeft)") // Display leavesLeft variable
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
                            VStack {
                                Text("\(totalLeaves)") // Display totalLeaves variable
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
                                Text("\(leavesTaken)") // Display leavesTaken variable
                                    .font(.title)
                                    .bold()
                                Text("Leaves Taken")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                        }
                        .padding() //Hstack Closes
                        
                    }
                    .background(RoundedRectangle(cornerRadius: 20).foregroundColor(Color.gray.opacity(0.1)).frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/))
                    .padding(.vertical, 10)
                }
                if getDays(fromDate: fromDate, toDate: toDate) == 0{
                    Text("Please select your to Date such that it is after the from date")
                        .foregroundStyle(.red)
                }
                else{
                    
                    Text("")
                }
                
                HStack{
                    Text("From")
                    Spacer()
                    DatePicker("", selection: $fromDate, in: minSelectableDate..., displayedComponents: .date)
                }
                .padding(.horizontal)
                .padding(.vertical, 15)
                .background(.white)
                .cornerRadius(10)
                .customShadow()
                
                HStack{
                    Text("To")
                    Spacer()
                    DatePicker("", selection: $toDate, in: minSelectableDate...maxSelectableDate, displayedComponents: .date)
                        .disabled(isToDateDisabled)
                }
                .padding(.horizontal)
                .padding(.vertical, 15)
                .background(.white)
                .cornerRadius(10)
                .customShadow()
                HStack {
                    Text("Number of days: \(getDays(fromDate: fromDate, toDate: toDate))")
                        .font(.headline)
                        .foregroundColor(.gray)
                    Spacer()
                }
//                .padding(.horizontal)
                TextField("Subject", text: $subject)
                    .padding(.horizontal)
                    .padding(.vertical, 15)
                    .background(.white)
                    .cornerRadius(10)
                    .customShadow()
                TextField("Description", text: $desc, axis: .vertical)
                    .lineLimit(8, reservesSpace: true)
                    .padding()
                    .background(.white)
                    .cornerRadius(10)
                    .customShadow()
                
                Spacer()
                Button(action: {
                    FirebaseHelperFunctions().leaveManagement(doctorID: docId, fromDate: fromDate, toDate: toDate, subject: subject, description: desc)
                    
                    self.showSuccessAnimation = true
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.showSuccessAnimation = false
                        fromDate = Date()
                        toDate = Date()
                        subject = ""
                        desc  = ""
                    }

                }, label: {
                    Text("Submit")
                        .foregroundStyle(Color.white)
                        .font(.headline)
                        .frame(width: 300, height: 50)
                        .background(Color.myAccent)
                        .cornerRadius(20)
                })
                
                
            }
            .background(Color.background)
            
            Spacer(minLength: 90)
        }
            .padding(.bottom , 50)
            
                    }
        .navigationViewStyle(.stack)
        .fullScreenCover(isPresented: $showSuccessAnimation) {
            SuccessAnimationView()
        }
        
        .onAppear(perform: {
            FirebaseHelperFunctions().getDays(doctorID: doctorId) { data, error in
                var total = 0
                if let dates = data {
                    
                    for (fromDate , toDate) in dates {
                        let calendar = Calendar.current
                        let components = calendar.dateComponents([.day], from: fromDate, to: toDate)
                        if let days = components.day {
                            total += days
                        }
                    }
                    self.leavesTaken = total
                }
            }
        })

        
        .onAppear{
            self.fromDate = Calendar.current.date(byAdding: .day, value: 7, to: fromDate) ?? Date()
            
            let fromDate1 = self.fromDate
            self.toDate = fromDate1
            let toDate2 = toDate
            self.numberOfDays = getDays(fromDate: fromDate1 , toDate:  toDate2)
            let formatter  = DateFormatter()
            formatter.dateFormat = "dd-MM-YYYY"
            dateString = formatter.string(from: toDate)
        }
        
    }
    
    private func getDate(date : Date) -> String{
        let formater = DateFormatter()
        formater.dateFormat = "dd-MM-YYYY"
        
        return formater.string(from: date)
    }
    
    private func getDays(fromDate : Date , toDate : Date) -> Int{
        let components = Calendar.current.dateComponents([.day], from: fromDate, to: toDate)
        
        guard let days = components.day else {
            return 0
        }
        var daysLeft = days
        if fromDate == toDate {
            daysLeft += 1
        }
        else if fromDate < toDate {
            daysLeft += 2
        }
        else {
            daysLeft = 0
        }
        
        
        return daysLeft
    }
    

}

#Preview {
    doctorLeaveApplication()
}
