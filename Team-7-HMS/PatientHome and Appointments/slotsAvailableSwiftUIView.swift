//
//  slotsAvailableSwiftUIView.swift
//  Team-7-HMS
//
//  Created by Vikashini G on 24/04/24.
//

import SwiftUI

struct slotsAvailableSwiftUIView: View {
    @State private var doctorDetails: [String: Any]? // Optional dictionary
    let doctorName: String
    
    var body: some View {
        VStack {
            if doctorDetails != nil && !doctorDetails!.isEmpty { // Check if doctorDetails is not nil and not empty
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 12){
                        Text(doctorName)
                            .font(CentFont.largeSemiBold)
                        Text(doctorDetails?["speciality"] as? String ?? "")
                            .font(.title2)
                        Text(doctorDetails?["education"] as? String ?? "")   .font(.subheadline)
                        HStack{
                            Text("\(doctorDetails?["experience"] as? Int ?? 0) years of Experience")
                        }
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
            } else {
                Text("Loading...")
            }
            Spacer()
        }
        .padding()
        .background(Color.background)
        .onAppear {
            fetchDoctorsDetails(name: doctorName) { details, error in
                if let error = error {
                    print("Error fetching doctor details: \(error)")
                } else {
                    self.doctorDetails = details // Assign details directly
                }
            }
        }
    }
}


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
#Preview {
    doctorInfoCard()
}

#Preview {
    slotsAvailableSwiftUIView(doctorName: "Dr. Harry Potter")
}
