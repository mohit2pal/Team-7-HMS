//
//  PatientLoginInView.swift
//  Team-7-HMS
//
//  Created by Himal Pandey on 22/04/2024.
//

import SwiftUI

struct PatientLogInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var shouldNavigate: Bool = false
    @State private var secureFieldIsVisible = false
    
    var body: some View {
        ZStack {
            Color("BgColor").edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                
                VStack {
                    
                    Image("AppLogo")
                        .resizable()
                        .frame(width: 60, height: 80, alignment: .center)
                    
                    Text("Log In")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 30)
                    
                    TextField("Email Id", text: $email)
                        .font(.title3)
                        .padding(12)
                        .autocapitalization(.none)
                        .foregroundColor(Color("TextColor"))
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(20)
                        .padding(.horizontal, 5)
                        .padding(.bottom, 5)
                        .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
                    
                    ZStack {
                        if secureFieldIsVisible {
                            TextField("Password", text: $password)
                                .font(.title3)
                                .padding(12)
                                .autocapitalization(.none)
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .cornerRadius(20)
                                .padding(.horizontal, 5)
                                .padding(.bottom, 5)
                                .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
                        } else {
                            SecureField("Password", text: $password)
                                .font(.title3)
                                .padding(12)
                                .autocapitalization(.none)
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .cornerRadius(20)
                                .padding(.horizontal, 5)
                                .padding(.bottom, 5)
                                .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
                        }
                        HStack{
                            Spacer()
                            Button(action: {
                                secureFieldIsVisible.toggle()
                            }) {
                                Image(systemName: secureFieldIsVisible ? "eye.slash.fill": "eye.fill")
                                    .opacity(0.6)
                                    .foregroundColor(Color("TextColor"))
                                    .padding(.trailing)
                                .padding()
                            }
                        }
                    }
                    
                    Text("Forgot your password?")
                        .font(.caption)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                        .padding()
                    
                    Button(action: {
                        if !email.isEmpty, !password.isEmpty {
                            // You can handle login here if needed
                            print("Login action here")
                            shouldNavigate = true
                        }
                    }) {
                        Text("Log In")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color("PrimaryColor"))
                            .cornerRadius(50)
                    }
                    .disabled(email.isEmpty || password.isEmpty)
                    .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
                    
                    NavigationLink("", destination: EmptyView(), isActive: $shouldNavigate)
                        .hidden() // Hide the navigation link
                    
                }.padding()
                
                Spacer()
                
                HStack{
                    Text("Already have an account?")
                    NavigationLink(destination: EmptyView()){
                        Text("SIGN UP")
                            .foregroundColor(Color("PrimaryColor"))
                    }
                }
                .padding([.leading, .trailing, .top])
                .navigationBarHidden(true)
                
            }
        }
    }
}

#Preview {
    PatientLogInView()
}
