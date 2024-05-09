//
//  AdminDashboard.swift
//  Team-7-HMS
//
//  Created by Ritwatz on 02/05/24.
//

import SwiftUI
import FirebaseAuth

struct AdminDashboard: View {
    let dashboardData: DashboardData = DashboardData(
        date: Date(),
        staffInfo: StaffInformation(doctorsCount: 10, nursesCount: 20, sanitaryStaffCount: 5),
        amenities: Amenities(totalStaffCount: 35, totalBedsCount: 100, otCount: 3, ambulanceCount: 2),
        patientInfo: PatientInformation(totalPatientsCount: 50, doctorsAttendingPatientsCount: 15, appointmentsScheduledCount: 30, appointmentsCancelledCount: 5)
    )
    var activeStaffCount: Int {
        return dashboardData.staffInfo.doctorsCount +
        dashboardData.staffInfo.nursesCount +
        dashboardData.staffInfo.sanitaryStaffCount
    }
    @State private var shouldNavigateToLogin = false
    var body: some View {
        NavigationView {
            HStack {
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        // Header
                        HStack(alignment: .top) {
                            Button{
                                signOut()
                            } label: {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(.gray)
                                    .padding(.trailing)
                            }
                            NavigationLink(destination: LoginScreen().navigationBarBackButtonHidden(true), isActive: $shouldNavigateToLogin) {
                                EmptyView()
                            }
                            
                            VStack(alignment: .leading) {
                                Text("Hello 👋")
                                    .font(CentFont.mediumReg)
                                Text("Admin")
                                    .font(.title)
                                    .fontWeight(.semibold)
                            }
                            Spacer()
                            NavigationLink(destination: patientNotificationSwiftUIView()) {
                                Image(systemName: "bell.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 24)
                                    .foregroundColor(.myAccent)
                            }
                        }
                        // .frame(width: 400,height: 400)
                        .padding()
                        Text("Today's Numbers")
                        HStack {
                            VStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(Color.myAccent)
                                    .frame(width: 100, height: 100, alignment: .center)
                                    .overlay(
                                        VStack {
                                            Text("\(activeStaffCount)")
                                                .font(.title)
                                                .foregroundColor(.white)
                                                .bold()
                                            Text("Active Staff")
                                                .font(.caption)
                                                .foregroundColor(.white)
                                        }
                                    )
                                    .padding(.vertical, 10)
                            }
                            Spacer()
                            RoundedRectangle(cornerRadius: 50)
                                .foregroundColor(.gray)
                                .frame(width: 2, height: 33)
                            Spacer()
                            VStack {
                                HStack {
                                    VStack {
                                        Text("\(dashboardData.staffInfo.doctorsCount)")
                                            .font(.title)
                                            .bold()
                                        Text("Doctors")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                    Spacer()
                                    RoundedRectangle(cornerRadius: 50)
                                        .foregroundColor(.gray)
                                        .frame(width: 2, height: 33)
                                    Spacer()
                                    VStack {
                                        Text("\(dashboardData.staffInfo.nursesCount)")
                                            .font(.title)
                                            .bold()
                                        Text("Nurses")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                    Spacer()
                                    RoundedRectangle(cornerRadius: 50)
                                        .foregroundColor(.gray)
                                        .frame(width: 2, height: 33)
                                    Spacer()
                                    VStack {
                                        Text("\(dashboardData.staffInfo.sanitaryStaffCount)")
                                            .font(.title)
                                            .bold()
                                        Text("Sanitary Staff")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                }
                                .padding()//Hstack Closes
                                
                            }
                            .background(RoundedRectangle(cornerRadius: 20).foregroundColor(Color.gray.opacity(0.1)).frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/))
                            .padding(.vertical, 10)
                        }
                        Text("Amenities")
                        // Amenities Information
                        VStack {
                            HStack {
                                VStack {
                                    Text("\(dashboardData.amenities.totalStaffCount)")
                                        .font(.title)
                                        .bold()
                                    Text("Staff")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                RoundedRectangle(cornerRadius: 50)
                                    .foregroundColor(.gray)
                                    .frame(width: 2, height: 33)
                                Spacer()
                                VStack {
                                    Text("\(dashboardData.amenities.totalBedsCount)")
                                        .font(.title)
                                        .bold()
                                    Text("Beds")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                RoundedRectangle(cornerRadius: 50)
                                    .foregroundColor(.gray)
                                    .frame(width: 2, height: 33)
                                Spacer()
                                VStack {
                                    Text("\(dashboardData.amenities.otCount)")
                                        .font(.title)
                                        .bold()
                                    Text("OTs")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                RoundedRectangle(cornerRadius: 50)
                                    .foregroundColor(.gray)
                                    .frame(width: 2, height: 33)
                                Spacer()
                                VStack {
                                    Text("\(dashboardData.amenities.ambulanceCount)")
                                        .font(.title)
                                        .bold()
                                    Text("Ambulances")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding()//Hstack Closes
                        }
                        .background(RoundedRectangle(cornerRadius: 20).foregroundColor(Color.gray.opacity(0.1)).frame(height: 100))
                        .padding(.vertical, 10)
                        Text("Patients")
                        HStack {
                            VStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(Color.myAccent)
                                    .frame(width: 100, height: 100, alignment: .center)
                                    .overlay(
                                        VStack {
                                            Text("\(dashboardData.patientInfo.totalPatientsCount)")
                                                .font(.title)
                                                .foregroundColor(.white)
                                                .bold()
                                            Text("Patients")
                                                .font(.caption)
                                                .foregroundColor(.white)
                                        }
                                    )
                                    .padding(.vertical, 10)
                            }
                            Spacer()
                            RoundedRectangle(cornerRadius: 50)
                                .foregroundColor(.gray)
                                .frame(width: 2, height: 33)
                            Spacer()
                            VStack {
                                HStack {
                                    VStack {
                                        Text("\(dashboardData.patientInfo.appointmentsScheduledCount)")
                                            .font(.title)
                                            .bold()
                                        Text("Scheduled")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                    Spacer()
                                    RoundedRectangle(cornerRadius: 50)
                                        .foregroundColor(.gray)
                                        .frame(width: 2, height: 33)
                                    Spacer()
                                    VStack {
                                        Text("\(dashboardData.patientInfo.doctorsAttendingPatientsCount)")
                                            .font(.title)
                                            .bold()
                                        Text("Doctors")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                    Spacer()
                                    RoundedRectangle(cornerRadius: 50)
                                        .foregroundColor(.gray)
                                        .frame(width: 2, height: 33)
                                    Spacer()
                                    VStack {
                                        Text("\(dashboardData.staffInfo.sanitaryStaffCount)")
                                            .font(.title)
                                            .bold()
                                        Text("Cancelled")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                }
                                .padding()//Hstack Closes
                                
                            }
                            .background(RoundedRectangle(cornerRadius: 20).foregroundColor(Color.gray.opacity(0.1)).frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/))
                            .padding(.vertical, 10)
                        }
                    }
                    .padding()
                }
            }
            .onAppear{
                FirebaseHelperFunctions().fetchLeaveData(){slots , error in
                    print(slots)
                    
                }
            }
        }
    }
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.shouldNavigateToLogin = true
            print("User signed out successfully")
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError.localizedDescription)")
        }
    }
}

struct AdminDashboard_Previews: PreviewProvider {
    static var previews: some View {
        AdminDashboard()
    }
}


