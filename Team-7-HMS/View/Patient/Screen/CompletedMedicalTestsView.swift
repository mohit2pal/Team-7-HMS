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
    @State var isLoading = false
    @State private var medicalTests : [MedicalTest] = []

    var body: some View {
        NavigationStack{
            ZStack{
                Color.background.ignoresSafeArea()
                ScrollView{
                   if isLoading{
                        ProgressView()
                    }
                    else{
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
                                                Text("ID : \(medicalTests[index].caseID.suffix(5))")
                                                    .padding(.bottom)
                                                    .foregroundStyle(Color.gray.opacity(0.9))
                                                Spacer()
                                            }
                                        }
                                        Spacer()
                                        
                                        Button(action: {
                                            //downloadAndSavePDFFromURL(pdfURL: URL(string: medicalTests[index].pdfURL)!)
                                            
                                            openURLInSafari(url: URL(string: medicalTests[index].pdfURL)!)
                                        }, label: {
                                            Image(systemName: "arrow.down.circle")
                                                .resizable()
                                                .frame(width: 20 , height: 20)
                                        })
                                        
                                    }
                                    .padding(.vertical)
                                    HStack{
                                        Image(systemName: "calendar")
                                        Text(medicalTests[index].date.replacingOccurrences(of: "_", with: "-"))
                                        Spacer()
                                        Image(systemName: "clock")
                                        Text(medicalTests[index].time)
                                    }
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
                                .multilineTextAlignment(.center)
                                .padding()
                                .foregroundColor(.gray)
                        }
                    }
                }
               
            }
            .onAppear{
                isLoading = true
                FirebaseHelperFunctions().fetchMedicalTests(patientUID: patientUID) { tests in
                    let inProgressTests = tests.filter { $0.status == "finish" }
                    self.medicalTests = inProgressTests.sorted(by: {$0.dateFull > $1.dateFull})
                    isLoading = false
                }
            }
        }
    }
    
}

#Preview {
    CompletedMedicalTestsView()
}
