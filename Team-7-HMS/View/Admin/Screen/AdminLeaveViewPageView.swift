//
//  AdminLeaveViewPageView.swift
//  Team-7-HMS
//
//  Created by Meghs on 09/05/24.
//

import SwiftUI
import Firebase

struct AdminLeaveViewPageView: View {
    
    
    @State private var selectedStatus: String = "Pending"
    
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.background.ignoresSafeArea()
                ScrollView{
                    VStack{
                        Picker("Status", selection: $selectedStatus) {
                            Text("Pending").tag("Pending")
                            Text("Completed").tag("Completed")
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.horizontal)
                        
                        if selectedStatus == "Pending" {
                            PendingLeaveRequestsView()
                                
                                .navigationBarTitle("Leave Management" , displayMode: .automatic)
                            
                        } else {
                            
                        }
                    }
                }
            }
        }
        
    }
}


#Preview {
    AdminLeaveViewPageView()
}
