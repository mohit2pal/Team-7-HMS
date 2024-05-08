//
//  SymptomOutPutPageView.swift
//  Team-7-HMS
//
//  Created by Meghs on 06/05/24.
//

import SwiftUI
import SDWebImageSwiftUI
import GoogleGenerativeAI
import Firebase

struct SymptomOutPutPageView: View {
    let model = GenerativeModel(name: "gemini-pro", apiKey: APIKey.default)
    
    @State var finalPrompt : String
    @State private var dataFetched = false
    @State var symptomps : [String]
    @State private var loading = true
    @State private var animatedText: String = ""
    @State private var showText : Bool = false
    @State private var finalText : String = ""
    @State private var selectedSpecialist : String = ""
    @State var viewLink = false
    var patientUID : String {
        Auth.auth().currentUser?.uid ?? "Vzo9cLiS9fZTyzpzkeH0Vure5YP2"
    }
    var body: some View {
        NavigationStack{
            ZStack{
                Color.background.ignoresSafeArea()
                if loading {
                    AnimatedImage(name: "loadingScreen.gif")
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50 , height: 50)
                        .ignoresSafeArea()
                        
                } else {
                    ScrollView{
                        VStack{
                            if !selectedSpecialist.isEmpty{
                                VStack{
                                    Circle()
                                        .fill(Color.white)
                                        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 2)
                                        .frame(width: 100 , height: 100)
                                        .overlay(
                                            Image(selectedSpecialist+"-icon")
                                                .resizable()
                                                .frame(width: 80 , height: 80)
                                                .padding()
                                        )
                                    Text(selectedSpecialist + " Department")
                                        .font(.title3)
                                        .bold()
                                    
                                    Divider()
                                }
                                .padding(.bottom)
                                
                                
                            }
                            
                            Text(animatedText)
                                .multilineTextAlignment(.center)
                                .font(.headline)
                                

                            Spacer()
                        }
                        .padding(.horizontal)
                        .onAppear{
                            if dataFetched{
                                print("no animate")
                            }
                            else{
                                animateText()
                            }
                        }
                                      
                        Divider()
                            .padding(.vertical)
                            .padding(.bottom , 50)
                        if viewLink {
                            NavigationLink {
                                SpecialitySwiftUIView(patientUID: patientUID, speciality: selectedSpecialist, icon: selectedSpecialist+"-icon")
                            } label: {
                                HStack{
                                    Text("Click here to book an appointment")
                                    Image(systemName: "chevron.right")
                                        .bold()
                                }
                                .foregroundStyle(.white)
                                .padding()
                                .frame(width: 330)
                                .background(Color.accentColor)
                                .cornerRadius(15)
                            }
                        }
                        
                    }
                }
            }
            .onAppear{
                if animatedText.isEmpty {
                    finalPrompt += symptomps.joined(separator: " ")
                    sendMessage(finalPrompt)
                }
                else if !animatedText.isEmpty {
                    dataFetched = true
                }
            }
        }
    }
    
    func animateText() {
        for (index, character) in finalText.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.02) {
                animatedText.append(character)
                // You can add haptic feedback to support typing animation.(optional)
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            }
                    }
        viewLink = true

    }
    
    func sendMessage(_ finalPrompt : String) {
        Task {
            do{
                let response = try await model.generateContent(finalPrompt)
                
                guard let text = response.text else{
                    loading = false
                    return
                }
                
                let textPrefix = "Thank you for providing your symptoms.\nBased on the information provided,here are the entered symptoms : \n\n"
                
                let symptomsString = symptomps.joined(separator: "\n")
                
                finalText = textPrefix + symptomsString + "\nBased on the given symptoms, this is the possible suggestions : \n\n\n"  + text.replacingOccurrences(of: "*", with: "")
                
                if let lastIndex = finalText.lastIndex(of: ":") {
                    let slicedString = finalText.suffix(from: finalText.index(after: lastIndex))
                        .trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    self.selectedSpecialist = slicedString
                }
                loading = false
               
        
            }
        }
    }
}

#Preview {
    SymptomOutPutPageView(finalPrompt: " ", symptomps: ["Pain"])
}
