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
    @State private var isUserLoggedIn : Bool = false
    @State private var oldUserLoggedIn: Bool = false
    @State private var doFetchData : Bool = false {
        didSet {
            if doFetchData {
                fetchCurrentUserAndData()
            }
        }
    }
    @State private var uuid : String = ""
    @State private var currentUser: User? = nil
    @State private var patient: Patient? = nil // Add this line to store fetched patient data
    
    @State private var loginError : Bool = false
    var body: some View {
        NavigationView{
            ZStack{
                Color("PrimaryColor")
                    .opacity(0.83)
                    .ignoresSafeArea()
                
                //Rectangle 2626
                VStack {
                    
                    Spacer()
                    ZStack {
//                        RoundedRectangle(cornerRadius: 40)
//                            .fill(Color(.background))
//                            .frame(width: 361, height: 483)
                        
                        
                        //Welcome back
                        VStack {
                            HStack{
                                Image("patient-icon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 55)
                                    .padding(15)
                                    .background(.white)
                                    .cornerRadius(50)
                                    .customShadow()
                                Text("Welcome back").font(.system(size: 32, weight: .bold, design: .rounded)).foregroundColor(Color("PrimaryColor")).tracking(-0.41).multilineTextAlignment(.center)
                            }
                            
                            //Email TextField
                            TextField("Email", text: $email)
                                .foregroundColor(Color.gray)
                                .textInputAutocapitalization(.never)
                                .textFieldStyle(.plain)
                                .padding(.horizontal)
                                .padding(.vertical, 15)
                                .background(.white)
                                .cornerRadius(10)
                                .frame(width: 320)
                                .customShadow()
                            
                            //Secure Text Field
                            SecureField("Password", text: $password)
                                .textInputAutocapitalization(.never)
                                .foregroundColor(Color.gray)
                                .textInputAutocapitalization(.never)
                                .textFieldStyle(.plain)
                                .padding(.horizontal)
                                .padding(.vertical, 15)
                                .background(.white)
                                .cornerRadius(10)
                                .frame(width: 320)
                                .customShadow()
                            
                            
                            //Forgot password?
                            Text("Forgot password?").font(.system(size: 13, weight: .regular, design: .rounded)).foregroundColor(Color("SecondaryColor").opacity(0.6)).tracking(-0.41).multilineTextAlignment(.trailing)
                            
                            Spacer().frame(height: 30)
                            //Rectangle 2638
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color("PrimaryColor").opacity(0.83))
                                    .frame(width: 300, height: 50)
                                
                                
                                //Log In
                                Text("Log In ").font(.headline).foregroundColor(.white).tracking(-0.41).multilineTextAlignment(.center)
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
                                            loginError = true
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
                                            
                                            self.uuid = user.uid
                                            
                                            FirebaseHelperFunctions().addPatientDetails(email: email, name: name, uuid: uuid, phoneNumber: phoneNumber) { result in
                                                switch result {
                                                case .success(let message):
                                                    print(message) // Document added successfully!
                                                    // Handle success
                                                    
                                                case .failure(let error):
                                                    print("Error: \(error.localizedDescription)")
                                                    // Handle failure
                                                }
                                            } present: {
                                                self.doFetchData = true
                                                self.oldUserLoggedIn = true
                                                print("UUID exists")
                                                
                                            } added: {
                                                self.doFetchData = true
                                                self.isUserLoggedIn = true
                                                print("Data added successfully")
                                            }
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
                            
                            if isUserLoggedIn {
                                
                                if let patient = patient {
                                    navigationDestination(isPresented: $isUserLoggedIn, destination: {
                                        PatientView(patientName: patient.name, showPatientHistory: true, patientUid: uuid)
                                            .navigationBarHidden(true)
                                            .navigationBarBackButtonHidden(true)
                                    })
                                }
                            }
                            
                            if loginError {
                                Text("Looks like there is an error, please try again")
                                    .foregroundStyle(Color.red)
                            }
                            if oldUserLoggedIn {
                                if let patient = patient {
                                    navigationDestination(isPresented: $oldUserLoggedIn, destination: {
                                        PatientView(patientName: patient.name, showPatientHistory: false, patientUid: uuid)
                                            .navigationBarHidden(true)
                                            .navigationBarBackButtonHidden(true)
                                    })
                                }
                            }
                            
                            
                            //Don’t have an account? Sign up
                            NavigationLink(destination: SignUpScreen()) {
                                Text("Don’t have an account? ").font(.system(size: 16, weight: .regular)).foregroundColor(Color("SecondaryColor")).tracking(-0.41) + Text("Sign up").font(.system(size: 16, weight: .regular)).foregroundColor(Color("PrimaryColor"))
                                    .bold()
                                    .tracking(-0.41)
                            }
                        }//vend
                        .padding()
                        .background(Color.background)
                        .cornerRadius(40)
                    }//zend
                    
                    Spacer()
                    
                    NavigationLink(destination: DoctorLoginScreenView(), label: {
                        HStack{
                            Text("Are you a doctor?")
                                .foregroundStyle(.black)
                            Text("Log in")
                                .foregroundStyle(.myAccent)
                        }
//                        .font(.title3)
                        .font(.system(size: 16, weight: .regular))
                        .frame(width: 300, height: 50)
                        .background(.white)
                        .cornerRadius(50)
                    })
                                        
                }
                .onChange(of: doFetchData) { newValue in
                    if newValue {
                        fetchCurrentUserAndData()
                    }
                }
            }
            
            
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func fetchCurrentUserAndData() {
        if let user = Auth.auth().currentUser {
            self.currentUser = user
            
            // Fetch patient data using the user's UID
            FirebaseHelperFunctions().fetchPatientData(by: user.uid) { patient, error in
                if let patient = patient {
                    self.patient = patient // Store fetched patient data
                } else {
                    print(error?.localizedDescription ?? "Failed to fetch patient data")
                }
            }
        } else {
            self.currentUser = nil
        }
    }
}

#Preview{
    LoginScreen()
}
