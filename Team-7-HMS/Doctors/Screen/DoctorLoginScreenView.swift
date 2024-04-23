import SwiftUI
import FirebaseAuth
import Firebase

struct DoctorLoginScreenView: View {
    @State var emailAddress : String = ""
    @State var password : String = ""
    @State var isLoggedIn = false // State variable to track login status
    @State var authFail = false
    
    @State var isLoading = false
    var body: some View {
        NavigationStack {
            ZStack{
                Color("PrimaryColor")
                    .ignoresSafeArea()
                
                //Rectangle 2626
                ZStack {
                    RoundedRectangle(cornerRadius: 40)
                        .fill(Color(#colorLiteral(red: 0.9803921580314636, green: 0.9803921580314636, blue: 0.9960784316062927, alpha: 1)))
                        .frame(width: 361, height: 433)
                    
                    VStack {
                        Text("Welcome back").font(.system(size: 32, weight: .bold, design: .rounded)).foregroundColor(Color(#colorLiteral(red: 0.49, green: 0.59, blue: 1, alpha: 1))).tracking(-0.41).multilineTextAlignment(.center)
                        
                        TextField("Email Address", text: $emailAddress)
                            .foregroundColor(Color.gray)
                            .textFieldStyle(.roundedBorder)
                            .textInputAutocapitalization(.never)
                            .padding(.horizontal , 40)
                        
                        
                        SecureField("Password", text: $password)
                            .frame(height: 45)
                            .textFieldStyle(.roundedBorder)
                            .textInputAutocapitalization(.never)
                            .padding(.horizontal , 40)
                        
                        //Forgot password?
                        Text("Forgot password?")
                            .font(.system(size: 13, weight: .regular, design: .rounded))
                            .foregroundColor(Color(#colorLiteral(red: 0.5, green: 0.5, blue: 0.5, alpha: 1))).tracking(-0.41).multilineTextAlignment(.center)
                        
                        
                        //Submit Button
                        NavigationLink(destination: DoctorHomePage(), isActive: $isLoggedIn) { // NavigationLink to DoctorHomePage
                            Button(action: {
                                
                                isLoading = true
                                
                                FirebaseHelperFunctions().authenticateDoctor(email: emailAddress, password: password,
                                    onSuccess: { _ in
                                    isLoggedIn = true
                                    isLoading = false
                                    
                                }, onFail: {
                                    authFail = true
                                    isLoading = false
                                    
                                })
                                
                            }, label: {
                                if isLoading {
                                    ProgressView()
                                }
                                else {
                                    Text("Log In ")
                                        .font(.system(size: 16, weight: .medium, design: .rounded))
                                        .frame(width: 312, height: 41)
                                        .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))).tracking(-0.41).multilineTextAlignment(.center)
                                        .background((Color(#colorLiteral(red: 0.48627451062202454, green: 0.5882353186607361, blue: 1, alpha: 1))))
                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                }
                            })
                        }
                        
                        
                        if authFail {
                            Text("Invalid email or password.")
                                .foregroundStyle(Color.red)
                        }
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct DoctorHomePage: View {
    var body: some View {
        NavigationStack {
            Text("Doctor Home Page")
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    DoctorLoginScreenView()
}
