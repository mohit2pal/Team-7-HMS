//
//  DoctorNameUIView.swift
//  Team-7-HMS
//
//  Created by Vikashini G on 24/04/24.
//

import SwiftUI



struct DoctorNameUIView: View {
    @State var doctorName: String
    var body: some View {
        HStack{
            Image(systemName: "person.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 80)
                .foregroundStyle(.gray)
            Spacer().frame(width: 30)
            VStack(alignment: .leading){
                Text(doctorName)
                    .font(CentFont.mediumSemiBold)
                Text("Available from: ")
                    .font(CentFont.smallReg)
                    .foregroundStyle(.gray)
            }
            Spacer()
            NavigationLink(destination: slotsAvailableSwiftUIView()){
                Image("Arrow")
                    .rotationEffect(.degrees(180))
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(28)
        .customShadow()
    }
}

#Preview {
    DoctorNameUIView(doctorName: "Dr. Harry Potter")
}
