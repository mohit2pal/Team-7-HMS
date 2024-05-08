//
//  BookLabRecordsView.swift
//  Team-7-HMS
//
//  Created by Meghs on 03/05/24.
//

import SwiftUI
import FirebaseAuth

struct BookLabRecordsView: View {
    
    @State var patientUID : String?
    
    let buttons: [ButtonData] = [
        ButtonData(image: "BloodAnalysis-icon", title: "Blood Analysis"),
        ButtonData(image: "XRay-icon", title: "XRay"),
        ButtonData(image: "CT Scan-icon", title: "CT Scan"),
        ButtonData(image: "MRI-icon", title: "MRI"),
        ButtonData(image: "PET Scan-icon", title: "PET Scan"),
        ButtonData(image: "Ultrasound-icon", title: "Ultrasound"),
        ButtonData(image: "Biopsy-icon", title: "Biopsy"),
        ButtonData(image: "Stool Test-icon", title: "Stool Test")
    ]
    
    
    var body: some View {
        
        NavigationStack{
            ZStack{
                Color.background.ignoresSafeArea()
                ScrollView{
                    VStack{
                        HStack{
                            Text("Book Medical Tests")
                                .font(.title3)
                            Spacer()
                        }
                        
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 4), spacing: 20) {
                            ForEach(buttons.indices, id: \.self) { index in
                                NavigationLink {
                                    MedicalTestsBookingView(patientUID: patientUID ?? "", speciality: buttons[index].title, icon: buttons[index].image)
                                } label: {
                                    VStack{
                                        Image(buttons[index].image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 80, height: 80)
                                            
                                            .background(Color.lightAccentBG)
                                            .clipShape(Circle())
                                        
                                        Text(buttons[index].title)
                                            .multilineTextAlignment(.center)
                                            .font(bookAppFont.smallest)
                                            .foregroundStyle(.gray)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .onAppear{
            if let user = Auth.auth().currentUser {
                self.patientUID = user.uid
            }
        }
    }
}

#Preview {
    BookLabRecordsView()
}
