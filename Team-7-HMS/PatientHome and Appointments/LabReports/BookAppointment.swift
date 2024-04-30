//
//  PatientBookLab.swift
//  Team-7-HMS
//
//  Created by Ekta on 25/04/24.
//
import SwiftUI

struct BookAppointment: View {
    
    
    let specialities = [
        "General Physician", "Obstretics", "Orthopaedics", "ENT",
        "Urology", "Paediatrics", "Cardiology", "Dermatology"]
    let SearchBySymptoms = [
        "Cough","Acne", "Ear Pain",
        "Joint Pain", "Pimple", "Children", "HairFall", "Fever"]
    
    var body: some View {
        
        ScrollView {
            
            VStack(alignment: .leading) {
                Text("Health Checks")
                    .font(.headline)
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))], spacing: 1) {
                    Button(action: {
                        // Action to perform when the button is tapped
                        print("Speciality selected: \(specialities[0])")
                    }) {
                        VStack{
                            Image("bl1")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 70, height: 70)
                            
                            Text("Full Body CheckUp")
                                .font(.caption)
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: 80, height: 100)
                    }
                    Button(action: {
                        // Action to perform when the button is tapped
                        print("Speciality selected: \(specialities[1])")
                    }) {
                        VStack {
                            Image("bl2")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 70, height: 70)
                            
                            Text("Obstretrics")
                                .font(.caption)
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: 80, height: 100)
                    }
                    Button(action: {
                        // Action to perform when the button is tapped
                        print("Speciality selected: \(specialities[2])")
                    }) {
                        VStack{
                            Image("bl3")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 70, height: 70)
                            
                            Text("Orthopedics")
                                .font(.caption)
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: 80, height: 100)
                    }
                    Button(action: {
                        // Action to perform when the button is tapped
                        print("Speciality selected: \(specialities[3])")
                    }) {
                        VStack {
                            Image("bl4")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 70, height: 70)
                            
                            Text("ENT")
                                .font(.caption)
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: 80, height: 100)
                    }
                    Button(action: {
                        // Action to perform when the button is tapped
                        print("Speciality selected: \(specialities[4])")
                    }) {
                        VStack{
                            Image("bl5")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 70, height: 70)
                            
                            Text("Urology")
                                .font(.caption)
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: 80, height: 100)
                    }
                    Button(action: {
                        // Action to perform when the button is tapped
                        print("Speciality selected: \(specialities[5])")
                    }) {
                        VStack{
                            Image("bl6")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 70, height: 70)
                            
                            Text("Paediatrics")
                                .font(.caption)
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: 80, height: 100)
                    }
                    Button(action: {
                        // Action to perform when the button is tapped
                        print("Speciality selected: \(specialities[6])")
                    }) {
                        VStack{
                            Image("bl7")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 70, height: 70)
                            
                            Text("Cardiology")
                                .font(.caption)
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: 80, height: 100)
                    }
                    Button(action: {
                        // Action to perform when the button is tapped
                        print("Speciality selected: \(specialities[7])")
                    }) {
                        VStack{
                            Image("bl8")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 70, height: 70)
                            
                            Text("Dermatology")
                                .font(.caption)
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: 80, height: 100)
                    }
                }
            }
            
            VStack(alignment: .leading) {
                Spacer(minLength: 20)
                Text("Popular Categories")
                    .font(.headline)
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))], spacing: 1) {
                    Button(action: {
                        // Action to perform when the button is tapped
                        print("Symptom selected: \(SearchBySymptoms [0])")
                    }) {
                        VStack(spacing: -10) {
                            Image("bl9")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 90, height: 90)
                            
                            Text(SearchBySymptoms [0])
                                .font(.caption)
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: 80, height: 100)
                    }
                    Button(action: {
                        // Action to perform when the button is tapped
                        print("Symptom selected: \(SearchBySymptoms [1])")
                    }) {
                        VStack (spacing: -10) {
                            Image("bl10")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 90, height: 90)
                            
                            Text(SearchBySymptoms [1])
                                .font(.caption)
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: 80, height: 100)
                    }
                    Button(action: {
                        // Action to perform when the button is tapped
                        print("Symptom selected: \(SearchBySymptoms [2])")
                    }) {
                        VStack(spacing: -10) {
                            Image("bl11")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 90, height: 90)
                            
                            Text(SearchBySymptoms [2])
                                .font(.caption)
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: 80, height: 100)
                    }
                    Button(action: {
                        // Action to perform when the button is tapped
                        print("Symptom selected: \(SearchBySymptoms [3])")
                    }) {
                        VStack(spacing: -10) {
                            Image("bl12")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 90, height: 90)
                            
                            Text(SearchBySymptoms [3])
                                .font(.caption)
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: 80, height: 100)
                    }
                    Button(action: {
                        // Action to perform when the button is tapped
                        print("Symptom selected: \(SearchBySymptoms [4])")
                    }) {
                        VStack(spacing: -10) {
                            Image("bl10")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 90, height: 90)
                            
                            Text(SearchBySymptoms [4])
                                .font(.caption)
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: 80, height: 100)
                    }
                    Button(action: {
                        // Action to perform when the button is tapped
                        print("Symptom selected: \(SearchBySymptoms [5])")
                    }) {
                        VStack(spacing: -10)  {
                            Image("bl14")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 90, height: 90)
                            
                            Text(SearchBySymptoms [5])
                                .font(.caption)
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: 80, height: 100)
                    }
                    Button(action: {
                        // Action to perform when the button is tapped
                        print("Symptom selected: \(SearchBySymptoms [6])")
                    }) {
                        VStack(spacing: -10)  {
                            Image("bl15")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 90, height: 90)
                            
                            Text(SearchBySymptoms [6])
                                .font(.caption)
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: 80, height: 100)
                    }
                    Button(action: {
                        // Action to perform when the button is tapped
                        print("Symptom selected: \(SearchBySymptoms [7])")
                    }) {
                        VStack (spacing: -10) {
                            Image("bl16")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 90, height: 90)
                            
                            Text(SearchBySymptoms [7])
                                .font(.caption)
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: 80, height: 100)
                    }
                }
            }
        }
    }
}

#Preview {
    BookAppointment()
}
