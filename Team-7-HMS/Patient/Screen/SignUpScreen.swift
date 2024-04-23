import SwiftUI
import FirebaseAuth
import GoogleSignIn
import Firebase

struct SignUpScreen: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    var body: some View {
        ZStack {
            Color("PrimaryColor")
                .opacity(0.83)
                .ignoresSafeArea()
            
            // Rectangle
            ZStack {
                RoundedRectangle(cornerRadius: 40)
                    .fill(Color(.white))
                    .frame(width: 361, height: 520) // Increased height to accommodate additional text field and space for "Forgot password?" text
                
                // Sign Up
                VStack {
                    Text("Sign Up")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundColor(Color("PrimaryColor"))
                        .tracking(-0.41)
                        .multilineTextAlignment(.center)
                    
                    // Email TextField
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
                    
                    // Secure Text Field for Password
                    SecureField("Password", text: $password)
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
                    
                    // Secure Text Field for Confirm Password
                    SecureField("Confirm Password", text: $confirmPassword)
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
                    // Sign Up Button
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color("PrimaryColor").opacity(0.83))
                            .frame(width: 312, height: 41)
                        
                        Text("Sign Up")
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .foregroundColor(.white)
                            .tracking(-0.41)
                            .multilineTextAlignment(.center)
                    }
                    
                    HStack {
                        // Google Login Button
                        Button {
                            guard let clientID = FirebaseApp.app()?.options.clientID else { return }
                            
                            // Create Google Sign In configuration object.
                            let config = GIDConfiguration(clientID: clientID)
                            GIDSignIn.sharedInstance.configuration = config
                            
                            // Start the sign in flow!
                            GIDSignIn.sharedInstance.signIn(withPresenting: getRootViewController()) { result, error in
                                guard error == nil else {
                                    // Handle error
                                    return
                                }
                                
                                guard let user = result?.user,
                                      let idToken = user.idToken?.tokenString
                                else {
                                    // Handle error
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
                                    if let user = authResult?.user {
                                        print("User's email: \(user.email ?? "No email")")
                                        print("User's number: \(user.phoneNumber ?? "No Number")")
                                        print("UUID: \(user.uid)")
                                    }
                                }
                            }
                        } label: {
                            Image(uiImage: #imageLiteral(resourceName: "Google-removebg-preview 2"))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 79, height: 79)
                                .clipped()
                        }
                    }
                    
                    // Or Text
                    HStack {
                        RoundedRectangle(cornerRadius: 50)
                            .fill(Color("SecondaryColor").opacity(0.6))
                            .frame(width: 88, height: 2)
                        
                        Text("or")
                            .font(.system(size: 13, weight: .regular, design: .rounded))
                            .foregroundColor(Color("SecondaryColor"))
                            .tracking(-0.41)
                        
                        RoundedRectangle(cornerRadius: 50)
                            .fill(Color("SecondaryColor").opacity(0.6))
                            .frame(width: 88, height: 2)
                    }
                    
                    // Already have an account? Log in
                    NavigationLink(destination: LoginScreen()) {
                        Text("Already have an account? ")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(Color("SecondaryColor"))
                            .tracking(-0.41)
                        +
                        Text("Log in")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(Color("PrimaryColor"))
                            .bold()
                            .tracking(-0.41)
                    }
                }
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("SecondaryColor").opacity(0.1), lineWidth: 0.5)
            )
        }
    }
}

struct SignUpScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignUpScreen()
    }
}
