//
//  loginScreen.swift
//  Team-7-HMS
//
//  Created by Subha on 22/04/24.
//

import SwiftUI
import FirebaseAuth
import GoogleSignIn
import Firebase

struct LoginScreen: View {
    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
        
        ZStack{
            Color("PrimaryColor")
                .opacity(0.83)
                .ignoresSafeArea()
        
        //Rectangle 2626
        ZStack {
            RoundedRectangle(cornerRadius: 40)
                .fill(Color(.white))
                .frame(width: 361, height: 433)
            
            
            //Welcome back
            VStack {
                Text("Welcome back").font(.system(size: 32, weight: .bold, design: .rounded)).foregroundColor(Color("PrimaryColor")).tracking(-0.41).multilineTextAlignment(.center)
                
                
                //Email TextField
                TextField("Email", text: $email)
                    .padding(.horizontal)
                    .frame(width: 312, height: 41)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.white)
                            .shadow(color: Color(.gray).opacity(0.2), radius: 20, x: 2, y: 0)
                        
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("SecondaryColor").opacity(0.1), lineWidth: 0.5)
                    )
                
                
                
                //Secure Text Field
                SecureField("Password", text: $password)
                    .padding(.horizontal)
                    .frame(width: 312, height: 41)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.white))
                    .shadow(color: Color(.gray).opacity(0.2), radius: 20, x: 2, y: 0)
                
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("SecondaryColor").opacity(0.1), lineWidth: 0.5)
                    )
                
                //Forgot password?
                Text("Forgot password?").font(.system(size: 13, weight: .regular, design: .rounded)).foregroundColor(Color("SecondaryColor").opacity(0.6)).tracking(-0.41).multilineTextAlignment(.trailing)
                
                //Rectangle 2638
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color("PrimaryColor").opacity(0.83))
                        .frame(width: 312, height: 41)
                    
                    
                    //Log In
                    Text("Log In ").font(.system(size: 16, weight: .medium, design: .rounded)).foregroundColor(.white).tracking(-0.41).multilineTextAlignment(.center)
                }
                
                HStack{
                    //Rectangle 2630
                    RoundedRectangle(cornerRadius: 50)
                        .fill(Color("SecondaryColor").opacity(0.6))
                        .frame(width: 88, height: 2)
                    
                    //or
                    Text("or").font(.system(size: 13, weight: .regular, design: .rounded)).foregroundColor(Color("SecondaryColor")).tracking(-0.41).multilineTextAlignment(.center)
                    
                    
                    RoundedRectangle(cornerRadius: 50)
                        .fill(Color("SecondaryColor").opacity(0.6))
                        .frame(width: 88, height: 2)
                }
                Button {
                    guard let clientID = FirebaseApp.app()?.options.clientID else { return }
                    
                    // Create Google Sign In configuration object.
                    let config = GIDConfiguration(clientID: clientID)
                    GIDSignIn.sharedInstance.configuration = config
                    
                    // Start the sign in flow!
                    GIDSignIn.sharedInstance.signIn(withPresenting: getRootViewController()) {result, error in
                        guard error == nil else {
                            // ...
                            return
                        }
                        
                        guard let user = result?.user,
                              let idToken = user.idToken?.tokenString
                        else {
                            // ...
                            return
                        }
                        
                        let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                                       accessToken: user.accessToken.tokenString)
                        
                        Auth.auth().signIn(with: credential) { authResult, error in
                            if let error = error {
                                // Handle error
                                print(error.localizedDescription)
                                return
                            }
                            
                            // User is signed in
                            // Here you can access the authResult.user object to get user information
                            if let user = authResult?.user {
                                print("User's email: \(user.email ?? "No email")")
                                print("User's number: \(user.phoneNumber ?? "No Number")")
                                print("UUID: \(user.uid)")
                                
                                let email = user.email ?? ""
                                let uuid = user.uid
                                let phoneNumber = user.phoneNumber ?? ""
                                let name = user.displayName ?? ""
                            
                                FirebaseHelperFunctions().addPatientDetails(email: email, name: name, uuid: uuid, phoneNumber: phoneNumber) { _ in
                                    print("Patient Details  added")
                                }
                                
                                // You can access more user information here
                            }
                        }
                    }
                } label: {
                    Image(uiImage: #imageLiteral(resourceName: "Google-removebg-preview 2"))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 79, height: 79)
                        .clipped()
                        .frame(width: 79, height: 79)
                }
                
                //Don’t have an account? Sign up
                NavigationLink(destination: SignUpScreen()) {
                    Text("Don’t have an account? ").font(.system(size: 16, weight: .regular)).foregroundColor(Color("SecondaryColor")).tracking(-0.41) + Text("Sign up").font(.system(size: 16, weight: .regular)).foregroundColor(Color("PrimaryColor"))
                        .bold()
                        .tracking(-0.41)
                }
            }
            }
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color("SecondaryColor").opacity(0.1), lineWidth: 0.5)
        )
        }
    }
}

#Preview{
    LoginScreen()
}
