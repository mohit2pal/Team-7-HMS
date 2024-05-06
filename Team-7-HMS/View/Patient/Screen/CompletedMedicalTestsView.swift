//
//  CompletedMedicalTestsView.swift
//  Team-7-HMS
//
//  Created by Meghs on 05/05/24.
//

import SwiftUI
import Firebase

struct CompletedMedicalTestsView: View {
    var patientUID : String {
        Auth.auth().currentUser?.uid ?? ""
    }
    
    @State private var medicalTests : [MedicalTest] = []
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.background.ignoresSafeArea()
                ScrollView{
                    if !medicalTests.isEmpty {
                        
                        ForEach(medicalTests.indices , id : \.self){ index in
                
                        VStack(alignment: .leading){
                            HStack{
                                VStack{
                                    HStack{
                                        Text(medicalTests[index].medicalTest)
                                            .font(.title2)
                                            .bold()
                                        Spacer()
                                    }
                                    
                                    HStack{
                                        Text("ID : \(medicalTests[index].caseID)")
                                            .padding(.bottom)
                                            .foregroundStyle(Color.gray.opacity(0.9))
                                        Spacer()
                                    }
                                }
                                Spacer()
                                Image(systemName: "arrow.down.circle")
                                    .resizable()
                                    .frame(width: 20 , height: 20)
                            }
                            .padding(.vertical)
                            HStack{
                                Image(systemName: "calendar")
                                Text(medicalTests[index].date.replacingOccurrences(of: "_", with: "-"))
                                Spacer()
                                Image(systemName: "clock")
                                Text(medicalTests[index].time)
                            }
                            .padding(.bottom)
                        }
                        .frame(width: 330 ,alignment: .leading)
                        .padding()
                        .multilineTextAlignment(.leading)
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 1)
                        }
                    }
                    else {
                        Text("There are no completed Medical Documents")
                            .padding(.horizontal)
                    }
                }
               
            }
            .onAppear{
                FirebaseHelperFunctions().fetchMedicalTests(patientUID: patientUID) { tests in
                    let inProgressTests = tests.filter { $0.status == "Completed" }
                    self.medicalTests = inProgressTests
                }
            }
        }
    }
}

#Preview {
    CompletedMedicalTestsView()
}
