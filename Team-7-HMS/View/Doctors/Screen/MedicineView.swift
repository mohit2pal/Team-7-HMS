//
//  MedicineView.swift
//  Team-7-HMS
//
//  Created by Subha on 06/05/24.
//

import SwiftUI

struct MedicineView: View {
    @State private var medicineName = ""
    @State private var morningDose:Bool = false
    @State private var eveningDose:Bool = false
    @State private var nightDose:Bool = false
    @Binding var medicines: [Medicine]
    
    
    var body: some View {
        if !medicines.isEmpty{
            List{
                ForEach(medicines.indices , id: \.self){ index in
                    HStack{
                        Text(medicines[index].name)
                        Spacer()
                        
                        //morning Dose
                        VStack{
                            if medicines[index].morningDose{
                                VStack{
                                    Image(systemName: "sun.max.fill")
                                        .foregroundColor(.myAccent)
                                    
                                }
                            }
                            else{
                                VStack{
                                    Image(systemName: "sun.max.fill")
                                        .foregroundColor(.gray)
                                    
                                }
                            }
                        }
                        
                        //afternoon dose
                        
                        VStack{
                            if medicines[index].eveningDose{
                                VStack{
                                    Image(systemName: "sun.horizon.fill")
                                        .foregroundColor(.myAccent)
                                    
                                }
                            }
                            else{
                                VStack{
                                    Image(systemName: "sun.horizon.fill")
                                        .foregroundColor(.gray)
                                    
                                }
                            }
                        }
                        
                        //night Dose
                        
                        VStack{
                            if medicines[index].nightDose{
                                VStack{
                                    Image(systemName: "cloud.moon")
                                        .foregroundColor(.myAccent)
                                }
                            }
                            else{
                                VStack{
                                    Image(systemName: "cloud.moon")
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        
                        //delete
                        Button {
                            medicines.remove(at: index)
                        } label: {
                            Image(systemName: "trash")
                                .foregroundStyle(Color.accentColor)
                                .padding(.leading)
                        }
                    }
                }
                .onDelete(perform: { indexSet in
                    medicines.remove(atOffsets: indexSet)
                })
            }
            .listStyle(.plain)
            .background(Color.background)
            .cornerRadius(20)
            .frame(height : CGFloat(medicines.count * 50))
            
        }                 
        VStack{
            HStack{
                TextField("Medicine Name", text: $medicineName)
                Spacer()
                HStack {
                    Button(action: {
                        morningDose.toggle()
                    }) {
                        if morningDose{
                            VStack{
                                Image(systemName: "sun.max.fill")
                                    .foregroundColor(.myAccent)
                                Text("1")
                                    .foregroundColor(.black)
                            }
                        }
                        else{
                            VStack{
                                Image(systemName: "sun.max.fill")
                                    .foregroundColor(.gray)
                                Text("0")
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    Button(action: {
                        eveningDose.toggle()
                    }) {
                        if eveningDose{
                            VStack{
                                VStack{
                                    Image(systemName: "sun.horizon.fill")
                                        .foregroundColor(.myAccent)
                                    Text("1")
                                        .foregroundColor(.black)
                                }
                            }
                        }
                        else{
                            VStack{
                                Image(systemName: "sun.horizon.fill")
                                    .foregroundColor(.gray)
                                Text("0")
                                    .foregroundColor(.black)
                            }
                            
                        }
                    }
                    Button(action: {
                        nightDose.toggle()
                    }) {
                        if nightDose {
                            VStack{
                                Image(systemName: "cloud.moon")
                                    .foregroundColor(.blue)
                                Text("1")
                                    .foregroundColor(.black)
                            }
                            
                        } else {
                            VStack{
                                Image(systemName: "cloud.moon")
                                    .foregroundColor(.gray)
                                Text("0")
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    
                    Button {
                        if !medicineName.isEmpty{
                            let medicineData = Medicine(name: medicineName, morningDose: morningDose, eveningDose: eveningDose, nightDose: nightDose)
                            
                            medicines.append(medicineData)
                            
                            medicineName = ""
                            morningDose = false
                            eveningDose = false
                            nightDose = false
                        }
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding(.leading)
                    }

                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .customShadow()
        }
    }
}
