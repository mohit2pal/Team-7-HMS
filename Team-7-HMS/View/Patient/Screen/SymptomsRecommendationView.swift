//
//  SymptomsRecommendationView.swift
//  Team-7-HMS
//
//  Created by Meghs on 06/05/24.
//

import SwiftUI
import GoogleGenerativeAI
import Firebase

struct SymptomsRecommendationView: View {
    @Environment(\.presentationMode) var presentationMode
    
    let model = GenerativeModel(name: "gemini-pro", apiKey: APIKey.default)
    @State private var responseGiven = ""
    @State private var prompt = "You are a medical based agent. There are some symptms given to you, and you need to find the best suitable specialist the user can go to. There are a total of 8 specialists, they are General Physician, Obstetrics & Gynaecology, Orthopaedics, ENT, Urology, Pediatrics, Cardiology, Dermatology. Tell me based on the symptoms which department i can go to and what might be the problem based on the symptoms. You will also be provided the medical History of the user. STICK TO ONLY THE GIVEN SPECIALITES. GIVE THE SPECIALISTS NAME AND 30 WORDS SUMMARY OF WHAT THE PROBLEM MIGHT BE. I only want a summary possible problem based on the symptoms in around 20 words, explaing the symptoms to the problem and only one specialist. No other data is needed. Dont give information that might scare the patient, and dont mention pregency in any of the possible problems. I want the possible problem given first, then the specialist.STICK ONLY TO THE MENTIIONED 8 SPECIALISTS. DONT GIVE ANY OTHER SPECIALISTS WHICH IS NOT MENTIONED. Give it in the specified format. `Problem : \n Specialist Suggested : `. DONT GIVE SPECIALITS NOT PRESENT. IF THE MOST PROBABLE SPECIALIST IS NOT PRESENT, GIVE GENERAL PHYSICIAN AS THE SPECIALIST. The symptoms given are :"
    
    @State var finalPrompt : String = ""
    let buttons2: [ButtonData] = [
        ButtonData(image: "Cough-icon", title: "Cough"),
        ButtonData(image: "RunnyNose-icon", title: "Cold"),
        ButtonData(image: "Stress-icon", title: "Headache"),
        ButtonData(image: "ThroatPain-icon", title: "Throat Pain"),
        ButtonData(image: "Fever-icon", title: "Fever"),
        ButtonData(image: "StomachPain-icon", title: "Stomach Pain"),
        ButtonData(image: "Nausea-icon", title: "Nausea"),
        ButtonData(image: "Rash-icon", title: "Rash")
    ]
    
    @State private var selectedSymptoms: [String] = []
    @State private var enteredSymptom : String = ""
    @State private var medicalHistory : String = "The Medical history is given below :"
    let columns = Array(repeating: GridItem(.flexible()), count: 4)
    
    @State var changePage  = false
    var patientUID : String? {
        Auth.auth().currentUser?.uid
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.background.ignoresSafeArea()
                VStack {
                    
                    ScrollView{
                        Text("What symptoms are you facing ?")
                        
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(buttons2.indices, id: \.self) { index in
                                VStack {
                                    Image(buttons2[index].image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 40, height: 40)
                                        .padding()
                                        .background(Color.white)
                                        .cornerRadius(15)
                                        .shadow(color: .black.opacity(0.5), radius: 1, x: 0.0, y: 0.0)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 15)
                                                .stroke(selectedSymptoms.contains(buttons2[index].title) ? Color.blue : Color.black, lineWidth: 1)
                                        )
                                        .onTapGesture {
                                            toggleSelection(buttons2[index].title)
                                        }
                                    Text(buttons2[index].title)
                                        .font(.caption)
                                        .foregroundColor(.black)
                                }
                            }
                        }
                        .padding(.horizontal)
                        
                        
                        if !selectedSymptoms.isEmpty {
                            ForEach(selectedSymptoms , id : \.self){ symptom in
                                HStack{
                                    Text(symptom)
                                    Spacer()
                                    Button(action: {
                                        removeSymptom(symptom)
                                    }) {
                                        Image(systemName: "trash")
                                            .foregroundStyle(.red)
                                    }
                                }
                                .padding()
                                .font(.title3)
                                .frame(width: 350)
                                .background(.white)
                                .cornerRadius(15)
                            }
                        }
                        
            
                        Text("Add more symptoms")
                            .padding(.vertical)
                        
                        HStack{
                            TextField("Add Symptom", text: $enteredSymptom)
                            
                            Button(action: {
                                addSymptom()
                            }, label: {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundStyle(.blue)
                            })
                        }
                        .padding()
                        .font(.title3)
                        .frame(width: 350)
                        .background(.white)
                        .cornerRadius(15)
                        
                        NavigationLink {
                            SymptomOutPutPageView(finalPrompt: prompt, symptomps: selectedSymptoms)
                        } label: {
                            Text("Submit")
                                .foregroundStyle(.white)
                                .frame(width: 300)
                                .padding()
                                .background(.accent)
                                .cornerRadius(15)
                        }
                        .disabled(selectedSymptoms.isEmpty)
                    }
                }
            }
            .navigationBarTitle("Symptoms")
            .navigationBarBackButtonHidden(true)

            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        HStack{
                            Image(systemName: "chevron.left")
                                .bold()
                            Text("Back")
                        }
                    })
                }
  

            }
            
        }
    }
    

    
    private func toggleSelection(_ symptom: String) {
        if let index = selectedSymptoms.firstIndex(of: symptom) {
            selectedSymptoms.remove(at: index)
        } else {
            selectedSymptoms.append(symptom)
        }
    }
    
    private func removeSymptom(_ symptom: String) {
        if let index = selectedSymptoms.firstIndex(of: symptom) {
            selectedSymptoms.remove(at: index)
        }
    }
    
    private func addSymptom(){
        if enteredSymptom.count > 0 {
            selectedSymptoms.append(enteredSymptom)
            enteredSymptom = ""
        }
    
    }
}

#Preview {
    SymptomsRecommendationView()
}
