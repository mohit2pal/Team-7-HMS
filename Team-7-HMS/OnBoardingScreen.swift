//
//  OnBoardingScreen.swift
//  Team-7-HMS
//
//  Created by Himal Pandey on 22/04/2024.
//

import SwiftUI

struct OnBoardingScreen: View {
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
                        OnboardingStepView(imageName: "OnBoardScreen1", title: "Welcome to YourCare!", description: "Welcome to YourCare! Access your medical records, schedule appointments, and connect with your healthcare team—all in one place. Simplify your healthcare journey with YourCare today!").tag(0)
                        
                        OnboardingStepView(imageName: "OnBoardScreen2", title: "Book an appointment!", description: "Book an appointment with hospital associated doctors by one tap.").tag(1)
                        
                        OnboardingStepView(imageName: "OnBoardScreen3", title: "Lab Reports In One tap", description: "Avoid endless hussle to collect Lab Reports, now you can access them in one tap.").tag(2)
                        
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                }
            }
        }
        .navigationBarHidden(true)
    
    }
}

struct OnboardingStepView: View {
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
    OnBoardingScreen()
}
