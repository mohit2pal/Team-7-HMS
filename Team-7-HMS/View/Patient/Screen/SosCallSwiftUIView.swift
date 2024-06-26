//
//  SosCallSwiftUIView.swift
//  Team-7-HMS
//
//  Created by Vikashini G on 23/04/24.
//

import SwiftUI

struct SosCallSwiftUIView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationStack{
            ZStack{
                Color.background.ignoresSafeArea()
                VStack{
                    Spacer()
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
                    Spacer()
                        .frame(height: 60)
                    Text("+91 93619 09556\n+91 93619 09556")
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.gray)
                    
                    Spacer()
                        .frame(height: 60)
                    Button(action: {
                        guard let phoneURL = URL(string: "tel://9361909556") else { return }
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
                
            }
            .navigationTitle("Call Help")
            .navigationBarBackButtonHidden(true)
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        HStack{
                            Image(systemName: "chevron.left")
                                .bold()
                            Text("Back")
                        }
                    })
                }
            })
        }
        
    }
}

#Preview {
    SosCallSwiftUIView()
}
