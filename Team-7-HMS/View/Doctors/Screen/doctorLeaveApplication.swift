//
//  doctorLeaveApplication.swift
//  Team-7-HMS
//
//  Created by Vikashini G on 06/05/24.
//

import SwiftUI

struct doctorLeaveApplication: View {
    @State var fromDate = Date()
    @State var toDate = Date()
    @State var subject: String
    @State var desc: String
    @State private var selectedReasonIndex = 0
    let leaveReasons = ["On Duty", "Personal Reasons"]
        
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Text("From")
                    Spacer()
                    DatePicker("", selection: $fromDate, displayedComponents: .date)
                        .datePickerStyle(.compact)
                }
                .padding(.horizontal)
                .padding(.vertical, 15)
                .background(.white)
                .cornerRadius(10)
                .customShadow()
                HStack{
                    Text("To")
                    Spacer()
                    DatePicker("", selection: $toDate, displayedComponents: .date)
                        .datePickerStyle(.compact)
                }
                .padding(.horizontal)
                .padding(.vertical, 15)
                .background(.white)
                .cornerRadius(10)
                .customShadow()
                HStack{
                    Text("Type of leave")
                    Spacer()
                    Picker(selection: $selectedReasonIndex, label: Text("Leave Reason")) {
                        ForEach(0 ..< 2) {
                            Text(self.leaveReasons[$0])
                        }
                    }
                    .pickerStyle(.menu)
                }
                .padding(.horizontal)
                .padding(.vertical, 15)
                .background(.white)
                .cornerRadius(10)
                .customShadow()
                TextField("Subject", text: $subject)
                    .padding(.horizontal)
                    .padding(.vertical, 15)
                    .background(.white)
                    .cornerRadius(10)
                    .customShadow()
                TextField("Description", text: $desc, axis: .vertical)
                    .lineLimit(5, reservesSpace: true)
                    .padding()
                    .background(.white)
                    .cornerRadius(10)
                    .customShadow()
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Submit")
                        .foregroundStyle(Color.white)
                        .font(.headline)
                        .frame(width: 300, height: 50)
                        .background(Color.myAccent)
                        .cornerRadius(20)
                })
            }
            .padding()
            .background(Color.background)
            .navigationBarTitle("Leave Application")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    doctorLeaveApplication(subject: "sdf", desc: "sdsdfa")
}
