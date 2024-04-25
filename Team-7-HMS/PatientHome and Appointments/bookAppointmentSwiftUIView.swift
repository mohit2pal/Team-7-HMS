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
    struct ButtonData{
        let image: String
        let title: String
    }
        
    //buttons by speciality
    let buttons: [ButtonData] = [
        ButtonData(image: "Doctor-icon", title: "General Physician"),
        ButtonData(image: "gynaecology-icon", title: "Obstetrics & Gynaecology"),
        ButtonData(image: "Orthopaedics-icon", title: "Orthopaedics\n"),
        ButtonData(image: "Ent-icon", title: "ENT\n"),
        ButtonData(image: "Urology-icon", title: "Urology"),
        ButtonData(image: "Paediatrics-icon", title: "Paediatrics"),
        ButtonData(image: "Cardiology-icon", title: "Cardiology"),
        ButtonData(image: "Dermatology-icon", title: "Dermatology")
    ]
    
    //buttons by symptoms
    let buttons2: [ButtonData] = [
        ButtonData(image: "Cough-icon", title: "General Physician"),
        ButtonData(image: "RunnyNose-icon", title: "Obstetrics & Gynaecology"),
        ButtonData(image: "Stress-icon", title: "Orthopaedics\n"),
        ButtonData(image: "ThroatPain-icon", title: "ENT\n"),
        ButtonData(image: "Fever-icon", title: "Urology"),
        ButtonData(image: "Periods-icon", title: "Paediatrics"),
        ButtonData(image: "HairFall-icon", title: "Cardiology"),
        ButtonData(image: "Acne-icon", title: "Dermatology")
    ]
    
    
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    Text("Book Appointment")
                        .font(CentFont.largeSemiBold)
                    Spacer()
                }
                
                Spacer().frame(height: 30)
                
                HStack{
                    Text("Search by Specialities")
                        .font(CentFont.mediumReg)
                    Spacer()
                }
                
                //list of specialities
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 4), spacing: 20) {
                    ForEach(buttons.indices, id: \.self) { index in
                        NavigationLink(destination: SpecialitySwiftUIView(speciality: buttons[index].title, icon: buttons[index].image)) {
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
                
                HStack{
                    Text("Search by symptoms")
                        .font(CentFont.mediumReg)
                    Spacer()
                }
                
                //list of symptoms
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 4), spacing: 20) {
                    ForEach(buttons.indices, id: \.self) { index in
                        NavigationLink(destination: SpecialitySwiftUIView(speciality: buttons[index].title, icon: buttons[index].image)) {
                            VStack {
                                Image(buttons2[index].image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40, height: 40)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(15)
                                Text(buttons2[index].title)
                                    .font(bookAppFont.smallest)
                                    .foregroundStyle(.gray)
                            }
                            .customShadow()
                        }
                    }
                }
                
                Spacer()
            }
            .padding()
            .background(Color.background)
            .navigationTitle("") // Set an empty title
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    bookAppointmentSwiftUIView()
}
