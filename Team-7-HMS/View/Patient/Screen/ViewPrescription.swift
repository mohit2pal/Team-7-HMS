//
//  ViewPrescription.swift
//  Team-7-HMS
//
//  Created by Ekta  on 30/04/24.
//

import SwiftUI

struct ViewPrescription: View {
    @State var appointmentData: AppointmentCardData
    
    var body: some View {
        NavigationView {
            VStack{
//                Spacer().frame(height: 30)
                HStack{
                    Text("Diagnosis").font(.headline)
                    Spacer()
                }
                HStack{
                    Text("Might be srs")
                    Spacer()
                }
                .foregroundStyle(Color.white)
                .padding()
                .background(.myAccent)
                .cornerRadius(20)
                .customShadow()
                Spacer().frame(height: 20)
                HStack{
                    Text("Symptoms").font(.headline)
                    Spacer()
                }
                HStack{
                    Text("Very very sick")
                    Spacer()
                }
                .padding()
                .background(.white)
                .cornerRadius(20)
                .customShadow()
                Spacer().frame(height: 20)
                HStack{
                    Text("Prescribed Medicines").font(.headline)
                    Spacer()
                }
                HStack {
                    VStack{
                        Text("Allegra 180")
                        Text("(AF for 10 days)").font(.system(size: 12))
                    }
                    
                    Spacer()
                    VStack{
                        HStack{
                            Image(systemName: "sun.max.fill")
                            Spacer()
                            Image(systemName: "sun.horizon.fill")
                            Spacer()
                            Image(systemName: "cloud.moon")
                        }
                        .foregroundColor(.myAccent)
                        .frame(width: 110)
                        HStack{
                            Text("1")
                            Spacer()
                            Text("0")
                            Spacer()
                            Text("1")
                        }
                        .frame(width: 100)
                    }
                }
                .padding()
                .background(.white)
                .cornerRadius(20)
                .customShadow()
                Spacer().frame(height: 20)
                HStack{
                    Text("Lab tests").font(.headline)
                    Spacer()
                }
                HStack{
                    Text("Do this that blah blah")
                    Spacer()
                }
                .padding()
                .background(.white)
                .cornerRadius(20)
                .customShadow()
                Spacer().frame(height: 20)
                HStack{
                    Text("Follow up").font(.headline)
                    Spacer()
                }
                HStack{
                    Text("Do this that blah blah")
                    Spacer()
                }
                .padding()
                .background(.white)
                .cornerRadius(20)
                .customShadow()
                Spacer()
            }
            .padding()
            .background(Color.background)
            .navigationTitle("Prescription")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ViewPrescription(appointmentData: AppointmentMockData.appointmentDataArray[0])
    }
}
