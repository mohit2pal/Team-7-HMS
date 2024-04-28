//
//  OnBoardingScreen.swift
//  Team-7-HMS
//
//  Created by Himal Pandey on 22/04/2024.
//

import SwiftUI

struct OnBoardingScreen: View {
    @State private var currentPage = 0
    @State private var goToLogin : Bool = false
    var body: some View {
        NavigationView {
            ZStack {
                
                Color("PrimaryColor")
                    .opacity(0.83)
                    .ignoresSafeArea()
                
                VStack {
                    if(currentPage < 2) {
                        Button(action: {
                            
                        }) {
                            NavigationLink(destination:
                                            LoginScreen()
                                .navigationBarBackButtonHidden(true)) {
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
                            NavigationLink(destination: SignUpScreen()) {
                                HStack{
                                    Spacer()
                                    Text("Get Started")
                                        .foregroundColor(Color("SecondaryColor"))
                                        .padding(10)
                                        .padding(.horizontal)
                                        .background(Color.white)
                                        .cornerRadius(20)
                                        .padding()
                                        .customShadow()
                                }
                            }
                        }
                    }
                    
                    TabView(selection: $currentPage) {
                        OnboardingStepView(imageName: "hospitalLogo", title: "Welcome to\nYourCare!", description: "Access your medical records, schedule appointments, and connect with your healthcare team—all in one place\n\nSimplify your healthcare journey with YourCare").tag(0)
                        
                        OnboardingStepView(imageName: "OnBoardScreen2", title: "Book Appointments\nEasily", description: "View available time slots, select preferred doctors, and receive appointment reminders to stay on track with your healthcare needs").tag(1)
                        
                        OnboardingStepView(imageName: "OnBoardScreen3", title: "Lab Reports\nIn a tap", description: "Say goodbye to the hassle of collecting lab reports. With just a tap, access all your lab reports conveniently from anywhere").tag(2)
                        
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
                .frame(width: 200, height: 200)
//                .customShadow()
                .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
            Spacer().frame(height: 40)
            VStack{
                HStack{
                    Text(title)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color("SecondaryColor"))
                    Spacer()
                }
                .padding(.leading, 30)
                .padding(.bottom)
                //                .shadow(color: Color.white.opacity(0.3), radius: 5, x: 0, y: 2)
                
                HStack{
                    Text(description)
                        .foregroundColor(Color("SecondaryColor"))
                        .font(.callout)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }.padding(.leading, 30)
            }
            .padding().padding(.vertical)
            .background(Color.white)
            .cornerRadius(50)
        }
        .padding()
        
    }
}

#Preview {
    OnBoardingScreen()
}
