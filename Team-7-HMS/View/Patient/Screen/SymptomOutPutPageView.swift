//
//  SymptomOutPutPageView.swift
//  Team-7-HMS
//
//  Created by Meghs on 06/05/24.
//

import SwiftUI
import SDWebImageSwiftUI
import GoogleGenerativeAI

struct SymptomOutPutPageView: View {
    let model = GenerativeModel(name: "gemini-pro", apiKey: APIKey.default)
    
    @State var finalPrompt : String
    
    @State var symptomps : [String]
    @State private var loading = true
    @State private var animatedText: String = ""
    @State private var showText : Bool = false
    @State private var finalText : String = ""
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
                    VStack{
                        Text(animatedText)
                            .multilineTextAlignment(.center)
                            .font(.title3)
                        Spacer()
                    }
                    .padding(.horizontal)
                    .onAppear{
                        animateText()
                    }
                    
                }
            }
            .onAppear{
                finalPrompt += symptomps.joined(separator: " ")
                sendMessage(finalPrompt)
            }
        }
    }
    
    func animateText() {
        for (index, character) in finalText.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.03) {
                animatedText.append(character)
                // You can add haptic feedback to support typing animation.(optional)
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            }
        }
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
                
                loading = false
               
        
            }
        }
    }
}

#Preview {
    SymptomOutPutPageView(finalPrompt: " ", symptomps: ["Pain"])
}
