//
//  DoctorCArdView.swift
//  Team-7-HMS
//
//  Created by Subha on 09/05/24.
//

import SwiftUI

struct doctorInfoCard: View{
    var body: some View {
        HStack(alignment: .top){
            VStack(alignment: .leading, spacing: 18){
                Text("Dr. Harry Potter")
                    .font(CentFont.largeSemiBold)
                Text("General Physician")
                    .font(.title2)
                Text("(MBBS, Ph.D, Fellow, International College of Surgeons)")
                    .font(.subheadline)
                Text("15 years of Experience")
                    .font(.subheadline)
            }
            Spacer()
            Image(systemName: "person.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
        }
        .padding()
        .padding(.vertical)
        .foregroundStyle(.white)
        .background(Color.myAccent)
        .cornerRadius(28)
        .customShadow()
    }
}
