//
//  PatientDetails.swift
//  Team-7-HMS
//
//  Created by Meghs on 29/04/24.
//

import SwiftUI
import FirebaseAuth
import Firebase

struct PatientDetails: View {
    @State var name : String
    @Binding var flag  : Bool
    @Binding var closePage : Bool
    var body: some View {
        
        NavigationStack{
            HStack{
                Spacer()
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 100 , height: 100
                    )
                Spacer()
            }
            .navigationTitle("User Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        closePage = false
                    }, label: {
                        Text("Cancel")
                    })
                }
            })
            List{
                Section("User Information") {
                    Text(name)
                    Text("Age")
                }
                Section("Medical Information") {
                    Text("Height")
                    Text("Weight")
                    Text("Gender")
                    Text("Blood Group")
                }
                Section("Medical History") {
                    NavigationLink {
                        Text("In medical History")
                    } label: {
                        Text("Medical History")
                    }
                }
                
                Section {
                    Button(action: {
                        signOut()
                    }
                           , label: {
                        Text("Logout")
                            .foregroundStyle(Color.red)
                    })
                }
                
            }
        }
        .onAppear{
            if let userUID = Auth.auth().currentUser?.uid {
            } else {
                print("User not authenticated")
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            flag = true
            print("User signed out successfully")
            closePage = false
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError.localizedDescription)")
        }
    }
}

#Preview {
    PatientDetails(name: "Bose", flag: .constant(true), closePage: .constant(true))
}
