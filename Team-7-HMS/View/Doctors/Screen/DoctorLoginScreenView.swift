import SwiftUI
import FirebaseAuth
import Firebase

struct DoctorLoginScreenView: View {
    
    @State var emailAddress : String = ""
    @State var password : String = ""
    @State var isLoggedIn = false // State variable to track login status
    @State var authFail = false
    @State var isAdmin = false
    @State private var currentUser: User? = nil
    @State private var doctor: DoctorDetails? = nil
    
    @State private var uuid : String = ""
    
    @State var isLoading = false
    var body: some View {
        NavigationView {
            ZStack{
                Color("PrimaryColor")
                    .opacity(0.83)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    //Rectangle 2626
                    ZStack {
//                        RoundedRectangle(cornerRadius: 40)
//                            .fill(Color(#colorLiteral(red: 0.9803921580314636, green: 0.9803921580314636, blue: 0.9960784316062927, alpha: 1)))
//                            .frame(width: 361, height: 400)
                        
                        VStack {
                            HStack{
                                Image("doctor-icon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 55)
                                    .padding(15)
                                    .background(.white)
                                    .cornerRadius(50)
                                    .customShadow()
                                Text("Welcome back").font(.system(size: 32, weight: .bold, design: .rounded)).foregroundColor(Color("PrimaryColor")).tracking(-0.41).multilineTextAlignment(.center)
                            }
                            TextField("Email Address", text: $emailAddress)
                                .foregroundColor(Color.gray)
                            //                            .textFieldStyle(.roundedBorder)
                                .textInputAutocapitalization(.never)
                            //                            .padding(.horizontal , 40)
                                .textFieldStyle(.plain)
                                .padding(.horizontal)
                                .padding(.vertical, 15)
                                .background(.white)
                                .cornerRadius(10)
                                .frame(width: 320)
                                .customShadow()
                            
                            
                            SecureField("Password", text: $password)
                            //                            .frame(height: 45)
                            //                            .textFieldStyle(.roundedBorder)
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
                            Text("Forgot password?")
                                .font(.system(size: 13, weight: .regular, design: .rounded))
                                .foregroundColor(Color(#colorLiteral(red: 0.5, green: 0.5, blue: 0.5, alpha: 1))).tracking(-0.41).multilineTextAlignment(.center)
                            
                            
                            
                            if isLoggedIn {
                                
                                if let doctor = doctor {
                                    navigationDestination(isPresented: $isLoggedIn, destination: {
                                        DoctorView(doctorUid: uuid, doctorDetails: doctor, doctorName: doctor.name)
                                            .navigationBarBackButtonHidden(true)
                                    })
                                }
                            }
                            
                            NavigationLink(destination: AdminHomeView().navigationBarBackButtonHidden(true), isActive: $isAdmin) {
                                EmptyView()
                            }
                            
                            Spacer()
                                .frame(height: 30)
                            
                            // NavigationLink to DoctorHomePage
                            Button(action: {
                                
                                isLoading = true
                                
                                // Check if credentials are for admin
                                if emailAddress == "admin" && password == "admin" {
                                    isLoggedIn = false
                                    isLoading = false
                                    // Additional state to differentiate between admin and doctor login
                                    isAdmin = true // You need to declare this @State var isAdmin = false at the top with other @State variables
                                } else {
                                    // Proceed with the regular authentication process
                                    FirebaseHelperFunctions().authenticateDoctor(email: emailAddress, password: password,
                                                                                 onSuccess: { _ in
                                        fetchCurrentUserAndData()
                                        isLoggedIn = true
                                        isLoading = false
                                        isAdmin = false
                                    }, onFail: {
                                        authFail = true
                                        isLoading = false
                                    })
                                }
                                
                            }, label: {
                                if isLoading {
                                    ProgressView()
                                }
                                else {
                                    Text("Log In ")
                                        .font(.system(size: 16, weight: .medium, design: .rounded))
                                        .frame(width: 300, height: 50)
                                        .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))).tracking(-0.41).multilineTextAlignment(.center)
                                        .background((Color(#colorLiteral(red: 0.48627451062202454, green: 0.5882353186607361, blue: 1, alpha: 1))))
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                }
                            })
                            if authFail {
                                Text("Invalid email or password.")
                                    .foregroundStyle(Color.red)
                            }
                            
                        }//vend
                        .padding()
                        .background(Color.background)
                        .cornerRadius(40)
                    }//zend
                    
                    Spacer()
                    
                    NavigationLink(destination: LoginScreen(), label: {
                        HStack{
                            Text("Are you a patient?")
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
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func fetchCurrentUserAndData() {
        if let user = Auth.auth().currentUser {
            self.currentUser = user
            self.uuid = user.uid
            
            let doctorRef = Firestore.firestore().collection("doctor_details").document(user.uid)
            doctorRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    // User UID is in the doctor_details collectio
                    // Here, you might want to fetch doctor-specific data similarly
                    FirebaseHelperFunctions().fetchDoctorDetails(by: user.uid) { doctor, error in
                        if let doctor = doctor {
                            self.doctor = doctor
                            print(self.doctor!)
                        } else {
                            print(error?.localizedDescription ?? "Failed to fetch doctor data")
                        }
                    }
                }
            }
        } else {
            self.currentUser = nil
        }
    }
}

#Preview {
    DoctorLoginScreenView()
}
