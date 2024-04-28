import SwiftUI
import FirebaseAuth
import GoogleSignIn
import Firebase

struct SignUpScreen: View {
    @State private var email: String = ""
    @State private var name : String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var StrongPassword : Bool = false
    @State private var showMessage : Bool = false
    @State private var navigatePatientDetails : Bool = false
    @State private var patientUID : String = ""
    var body: some View {
        NavigationStack {
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
                        
                        
                        //name
                        TextField("Name", text: $name)
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
                                    .fill(.white))
                            .shadow(color: Color(.gray).opacity(0.2), radius: 20, x: 2, y: 0)
                        
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("SecondaryColor").opacity(0.1), lineWidth: 0.5)
                            )
                        
                        // Secure Text Field for Confirm Password
                        HStack{
                            SecureField("Confirm Password", text: $confirmPassword)
                                .padding(.horizontal)
                            if !password.isEmpty && (password == confirmPassword) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundStyle(Color.green)
                                
                            }
                            else {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundStyle(.red)
                            }
                        }
                        .frame(width: 312, height: 41)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.white))
                        .shadow(color: Color(.gray).opacity(0.2), radius: 20, x: 2, y: 0)
                        
                        
                        // Sign Up Button
                        
                        Button(action: {
                            StrongPassword = strongPassword(password)
                            showMessage = true
                            
                            if StrongPassword && !name.isEmpty{
                                FirebaseHelperFunctions().registerPatientDetails(email: email, name: name, password: password) { uid in
                                    self.patientUID = uid
                                    navigatePatientDetails = true
                                    print(patientUID)
                                    print(navigatePatientDetails)
                                }
                            }
                        }, label: {
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
                            
                        })
                        
                        NavigationLink(destination: HStack {
                            PatientView(patientName: name, showPatientHistory: true, patientUid: patientUID)
                        }, isActive: $navigatePatientDetails) {
                            EmptyView()
                        }

                        
                        if !StrongPassword && showMessage {
                            Text("Your password should contain uppercase, lowercase letters and numbers")
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                                .foregroundStyle(.red)
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
                        NavigationLink(destination: LoginScreen().navigationBarBackButtonHidden(true)) {
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
        }  .navigationBarBackButtonHidden()
            .navigationBarHidden(true)
        
    }
    
    private func strongPassword(_ password: String) -> Bool{
        guard password.count >= 8 else { return false }
        
        // Check for uppercase letter
        let uppercaseLetterRange = NSRange(location: 0, length: password.utf16.count)
        let uppercaseRegex = try! NSRegularExpression(pattern: "[A-Z]")
        guard uppercaseRegex.firstMatch(in: password, options: [], range: uppercaseLetterRange) != nil else {
            return false
        }
        
        // Check for lowercase letter
        let lowercaseLetterRange = NSRange(location: 0, length: password.utf16.count)
        let lowercaseRegex = try! NSRegularExpression(pattern: "[a-z]")
        guard lowercaseRegex.firstMatch(in: password, options: [], range: lowercaseLetterRange) != nil else {
            return false
        }
        
        // Check for digit
        let digitRange = NSRange(location: 0, length: password.utf16.count)
        let digitRegex = try! NSRegularExpression(pattern: "\\d")
        guard digitRegex.firstMatch(in: password, options: [], range: digitRange) != nil else {
            return false
        }
        
        // If all checks pass
        return true
    }
}

struct SignUpScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignUpScreen()
    }
}

