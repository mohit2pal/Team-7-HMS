//
//  bookAppointmentSwiftUIView.swift
//  Team-7-HMS
//
//  Created by Vikashini G on 23/04/24.
//

import SwiftUI

enum bookAppFont {
    static let smallest: Font = .system(size: 12, weight: .regular)
}


struct bookAppointmentSwiftUIView: View {
    let patientUID : String

    //buttons by speciality
    let buttons: [ButtonData] = [
        ButtonData(image: "Doctor-icon", title: "General Physician"),
        ButtonData(image: "Obstetrics & Gynaecology-icon", title: "Obstetrics & Gynaecology"),
        ButtonData(image: "Orthopaedics-icon", title: "Orthopaedics"),
        ButtonData(image: "ENT-icon", title: "ENT"),
        ButtonData(image: "Urology-icon", title: "Urology"),
        ButtonData(image: "Paediatrics-icon", title: "Pediatrics"),
        ButtonData(image: "Cardiology-icon", title: "Cardiology"),
        ButtonData(image: "Dermatology-icon", title: "Dermatology")
    ]
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack {
                    //Book appointment
                    
                    HStack {
                        Text("Search by Specialities")
                            .font(.title3)
                        Spacer()
                    }
                    //list of specialities
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 4), spacing: 20) {
                        ForEach(buttons.indices, id: \.self) { index in
                            NavigationLink(destination: SpecialitySwiftUIView(patientUID: patientUID, speciality: buttons[index].title, icon: buttons[index].image)) {
                                VStack {
                                    Image(buttons[index].image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50, height: 50)
                                        .padding(10)
                                        .background(Color.lightAccentBG)
                                        .cornerRadius(50)
                                    Text(buttons[index].title)
                                        .font(bookAppFont.smallest)
                                        .foregroundStyle(.gray)
                                }
                            }
                        }
                    }
                    
                    Spacer()
                        .frame(height: 30)
                    
                    HStack {
//                        Spacer()
                        Text("Unsure which specialist to visit?")
                            .font(.title3)
                            
                        Spacer()
                    }
                    
                   
                    .padding(.vertical)
                    
                    VStack{
                       
                        HStack{
                            NavigationLink {
                                SymptomsRecommendationView()
                                    .navigationBarBackButtonHidden()
                            } label: {
                                HStack{
                                    Text("Click here to analyse for symptoms!")
                                    Image(systemName: "chevron.right")
                                        .bold()
                                }
                                .foregroundStyle(.white)
                                .padding()
                                .background(.accent)
                                .cornerRadius(15)
                            }
                            
                        }
                    }
                    .offset(y:25)
                    
                }
            }
            .background(Color.background)
        }
        .navigationViewStyle(.stack)
    }
}

#Preview {
    bookAppointmentSwiftUIView(patientUID: "")
    
}
