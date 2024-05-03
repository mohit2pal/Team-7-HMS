//
//  ViewPrescription.swift
//  Team-7-HMS
//
//  Created by Ekta  on 30/04/24.
//

import SwiftUI

struct Medicine {
    var name: String
    var morningDose: Bool
    var eveningDose: Bool
    var nightDose: Bool
}

struct addPrescription: View {
    @State private var diagnosis : String = ""
    @State private var symptoms : String = ""
    @State private var labTest : String = ""
    @State private var followUp : String = ""
    @State private var isPrescriptionOn = false
    @State private var isLabTestsOn = false
    @State private var medicineName = ""
    @State private var morningDose:Bool = false
    @State private var eveningDose:Bool = false
    @State private var nightDose:Bool = false
    @State private var medicines: [Medicine] = []
    var body: some View {
        NavigationView {
            VStack{
                HStack{
                    Text("Diagnosis").font(.headline)
                    Spacer()
                }
                TextField("Diagnosis", text: $diagnosis)
                .padding()
                .background(.white)
                .cornerRadius(20)
                .customShadow()
                Spacer().frame(height: 20)
                HStack{
                    Text("Symptoms").font(.headline)
                    Spacer()
                }
                TextField("Symptoms", text: $symptoms)
                .padding()
                .background(.white)
                .cornerRadius(20)
                .customShadow()
                Spacer().frame(height: 20)
                HStack{
                    Text("Prescribe Medicines").font(.headline)
                    Spacer()
                }
                
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
//                    Button(action: {
//                        let newMedicine = Medicine(name: medicineName, morningDose: morningDose, eveningDose: eveningDose, nightDose: nightDose)
//                        medicines.append(newMedicine)
//                        // Reset fields
//                        medicineName = ""
//                        morningDose = false
//                        eveningDose = false
//                        nightDose = false
//                    }) {
//                        HStack{
//                            Spacer()
//                            Text("Done")
//                                .frame(width: 100, height: 44)
//                                .background(Color.myAccent)
//                                .foregroundStyle(Color.white)
//                                .cornerRadius(20)
//                        }
//                        
//                    }
                }
                
                Spacer().frame(height: 20)
                HStack{
                    Text("Lab tests").font(.headline)
                    Spacer()
                }
                HStack{
                    TextField("Lab tests prescribed", text: $labTest)
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
                    TextField("Notes", text: $followUp)
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

#Preview{
    addPrescription()
}
