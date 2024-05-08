////
////  RescheduleAppointmentsView.swift
////  Team-7-HMS
////
////  Created by Meghs on 08/05/24.
////
//
//import SwiftUI
//
//struct RescheduleAppointmentsView: View {
//    @State var appointmentId : String
//    var doctorName : String?
//    var doctorSpeciality : String?
//    var body: some View {
//        NavigationStack{
//            ZStack{
//                Color.background.ignoresSafeArea()
//                ScrollView{
//                    
//                    HStack(alignment: .top) {
//                        VStack(alignment: .leading, spacing: 12){
//                            Text("doctorName")
//                                .font(CentFont.largeSemiBold)
//                            Text("")
//                                .font(.title2)
//                            Text( "")   .font(.subheadline)
//                            HStack{
//                                Text("years of Experience")
//                            }
//                            .font(.subheadline)
//                        }
//                        Spacer()
//                        
//                        Image(systemName: "person.circle.fill")
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 80, height: 80)
//                    }
//                    .padding()
//                    .padding(.vertical)
//                    .foregroundStyle(.white)
//                    .background(Color.myAccent)
//                    .cornerRadius(28)
//                    .customShadow()
//                }
//            }
//            .navigationTitle("Reschedule Appointments")
//            .navigationBarTitleDisplayMode(.inline)
//            .onAppear{
//                FirebaseHelperFunctions().getAppointmentData(appointmentUID: appointmentId) { Appointment, error in
//                    if let drName = Appointment?.doctorName , let doctorSpeciality = Appointment?.doctorSpeciality{
//                        doctorName = doctorName
//                        self.doctorSpeciality =
//                        
//                    }
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    RescheduleAppointmentsView(appointmentId: "4iNknFuD9hGgCq6Z8Jsj")
//}
