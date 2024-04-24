//
//  OnBoardingScreen.swift
//  Team-7-HMS
//
//  Created by Himal Pandey on 22/04/2024.
//

import SwiftUI

struct OnBoardingDoctor: View {
    @State private var currentPage = 0
    
    var body: some View {
        NavigationView {
            ZStack {
                
                Color("PrimaryColor").ignoresSafeArea()
                
                VStack {
                    if(currentPage < 2) {
                        Button(action: {
                            // Action to perform when the button is tapped
                        }) {
                            NavigationLink(destination: EmptyView()) {
                                Text("Skip")
                                    .foregroundColor(Color("SecondaryColor"))
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .padding([.leading, .trailing])
                            }
                        }
                    } else {
                        Button(action: {
                            // Action to perform when the button is tapped
                        }) {
                            NavigationLink(destination: EmptyView()) {
                                Text("Get Started")
                                    .foregroundColor(Color("SecondaryColor"))
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .padding([.leading, .trailing])
                            }
                        }
                    }
                    
                    TabView(selection: $currentPage) {
                        OnboardingStepView(imageName: "OnBoardScreen1", title: "Welcome Staffs!", description: " Manage patient records, schedule consultations, and collaborate with your healthcare team—all in one intuitive platform. Streamline your practice and enhance patient care with YourCare today!").tag(0)
                        
                        OnboardingStepView(imageName: "OnBoardScreen2", title: "Reschedule your slot!", description: "View your slot duty as well request for a slot change/leave.").tag(1)
                        
                        OnboardingStepView(imageName: "OnBoardScreen3", title: "Patient Medical History", description: "Access patient medical history and laboratory reports through the application.").tag(2)
                        
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                }
            }
        }
        .navigationBarHidden(true)
    
    }
}

struct OnboardingDoctorView: View {
    var imageName: String
    var title: String
    var description: String
    
    var body: some View {
        
        VStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 200)
                .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
            
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .shadow(color: Color.white.opacity(0.3), radius: 5, x: 0, y: 2)
                .foregroundColor(Color("SecondaryColor"))
            
            Text(description)
                .foregroundColor(Color("SecondaryColor"))
                .font(.callout)
                .multilineTextAlignment(.center)
                .padding()
            
        }
        .padding()
    }
}

#Preview {
    OnBoardingDoctor()
}
