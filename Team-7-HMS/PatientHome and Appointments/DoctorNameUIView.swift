//
//  DoctorNameUIView.swift
//  Team-7-HMS
//
//  Created by Vikashini G on 24/04/24.
//

import SwiftUI



struct DoctorNameUIView: View {
    var patientUID : String
    @State var doctorName: String
    @State var date : String
    @State var id : String
    var body: some View {
        VStack{
            NavigationLink(destination: slotsAvailableSwiftUIView(patientUID: patientUID ,doctorName: doctorName , date : date, doctorId: id)){
                HStack{
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 80)
                        .foregroundStyle(.gray)
                    Spacer().frame(width: 30)
                    VStack(alignment: .leading){
                        Text(doctorName)
                            .multilineTextAlignment(.leading)
                            .font(CentFont.mediumSemiBold)
                        Text("Available from: ")
                            .font(CentFont.smallReg)
                            .foregroundStyle(.gray)
                    }
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(28)
        .customShadow()
    }
}

#Preview {
    NavigationStack{
        DoctorNameUIView(patientUID: "", doctorName: "Nithin Vakalapudi", date: "15 April 2024", id: "id")
    }
}
