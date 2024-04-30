//
//  SosCallSwiftUIView.swift
//  Team-7-HMS
//
//  Created by Vikashini G on 23/04/24.
//

import SwiftUI

struct SosCallSwiftUIView: View {
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    Text("Call Help")
                        .font(CentFont.largeSemiBold)
                    Spacer()
                }
                
                Spacer().frame(height: 100)
                
                Image("AmbulanceImage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 400)
                
                Spacer()
                    .frame(height: 40)
                
                Text("Get Instant Ambulance \n by Calling the following number.")
                    .multilineTextAlignment(.center)
                    .font(CentFont.smallReg)
                
                Spacer()
                    .frame(height: 60)
                
                
    
                Text("+91 98765 43210\n+91 98765 43210")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.gray)
                
                Spacer()
                    .frame(height: 60)
                
                Button(action: {
                    guard let phoneURL = URL(string: "tel://9237498273") else { return }
                    UIApplication.shared.open(phoneURL)
                }) {
                    Image(systemName: "phone.fill")
                        .font(.system(size: 27))
                    Text("Call")
                        .font(CentFont.largeSemiBold)
                }
                .foregroundColor(.white)
                .padding(10)
                .padding(.horizontal)
                .background(Color.red)
                .cornerRadius(20)
            }
            .padding()
        }
        .background(Color.background)
    }
}

#Preview {
    SosCallSwiftUIView()
}
