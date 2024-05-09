//
//  DoctorDetailsView.swift
//  Team-7-HMS
//
//  Created by Subha on 09/05/24.
//

import SwiftUI

struct DoctorDetailsView: View {
    let doctorName: String
    let speciality: String
    let education: String
    let experience: Int

    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 12) {
                Text(doctorName)
                    .font(CentFont.largeSemiBold)
                Text(speciality)
                    .font(.title2)
                Text(education)
                    .font(.subheadline)
                Text("\(experience) years of Experience")
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
