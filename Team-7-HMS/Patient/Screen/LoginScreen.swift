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
    var body: some View {
        ZStack{
            Color("PrimaryColor")
                .ignoresSafeArea()
        
        //Rectangle 2626
        ZStack {
            RoundedRectangle(cornerRadius: 40)
                .fill(Color(#colorLiteral(red: 0.9803921580314636, green: 0.9803921580314636, blue: 0.9960784316062927, alpha: 1)))
                .frame(width: 361, height: 433)
            
            
            //Welcome back
            VStack {
                //Google-removebg-preview 2
                Text("Welcome back").font(.system(size: 32, weight: .bold, design: .rounded)).foregroundColor(Color(#colorLiteral(red: 0.49, green: 0.59, blue: 1, alpha: 1))).tracking(-0.41).multilineTextAlignment(.center)
                
                
                //Rectangle 2627
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    .frame(width: 312, height: 41)
                    .shadow(color: Color(#colorLiteral(red: 0.48627451062202454, green: 0.5882353186607361, blue: 1, alpha: 0.05000000074505806)), radius:20, x:2, y:0)
                
                //Rectangle 2629
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    .frame(width: 312, height: 41)
                    .shadow(color: Color(#colorLiteral(red: 0.48627451062202454, green: 0.5882353186607361, blue: 1, alpha: 0.05000000074505806)), radius:20, x:2, y:0)
                
                //Forgot password?
                Text("Forgot password?").font(.system(size: 13, weight: .regular, design: .rounded)).foregroundColor(Color(#colorLiteral(red: 0.5, green: 0.5, blue: 0.5, alpha: 1))).tracking(-0.41).multilineTextAlignment(.center)
                
                //Rectangle 2638
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color(#colorLiteral(red: 0.48627451062202454, green: 0.5882353186607361, blue: 1, alpha: 1)))
                        .frame(width: 312, height: 41)
                    
                    
                    //Log In
                    Text("Log In ").font(.system(size: 16, weight: .medium, design: .rounded)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))).tracking(-0.41).multilineTextAlignment(.center)
                }
                
                HStack{
                    //Rectangle 2630
                    RoundedRectangle(cornerRadius: 50)
                        .fill(Color(#colorLiteral(red: 0.501960813999176, green: 0.501960813999176, blue: 0.501960813999176, alpha: 1)))
                    .frame(width: 88, height: 2)
                    
                    //or
                    Text("or").font(.system(size: 13, weight: .regular, design: .rounded)).foregroundColor(Color(#colorLiteral(red: 0.5, green: 0.5, blue: 0.5, alpha: 1))).tracking(-0.41).multilineTextAlignment(.center)
                    
                    //Rectangle 2630
                    RoundedRectangle(cornerRadius: 50)
                        .fill(Color(#colorLiteral(red: 0.501960813999176, green: 0.501960813999176, blue: 0.501960813999176, alpha: 1)))
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
                Text("Don’t have an account? ").font(.system(size: 16, weight: .regular)).foregroundColor(Color(#colorLiteral(red: 0.11, green: 0.11, blue: 0.11, alpha: 1))).tracking(-0.41) + Text("Sign up").font(.system(size: 16, weight: .regular)).foregroundColor(Color(#colorLiteral(red: 0.49, green: 0.59, blue: 1, alpha: 1))).tracking(-0.41)
                }
            }
        }
    }
}

#Preview{
    LoginScreen()
}
