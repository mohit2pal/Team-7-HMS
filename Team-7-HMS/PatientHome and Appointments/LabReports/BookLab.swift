//
//  BookLab.swift
//  Team-7-HMS
//
//  Created by Ekta  on 29/04/24.
//
import SwiftUI

struct BookLab: View {
    
    let HealthChecks = [
        "Full Body Checkup", "Diabetes", "Women's Health","Hairfall",
        "Health Packages", "Blood Studies", "Vitamins", "Heart"]
    let PopularCategories = [
        "Pregnancy","X-Ray", "Allergies",
        "Infertility", "Joint Pain", "PCOD", "STD", "Heart"]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 245 / 255, green: 245 / 255, blue: 245 / 255)
                    .ignoresSafeArea()
                
                ScrollView {
                    
                    VStack(alignment: .leading) {
                        Text("Health Checks")
                            .font(.headline)
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))], spacing: 1) {
                            Button(action: {
                                // Action to perform when the button is tapped
                                print("Speciality selected: \(HealthChecks[0])")
                            }) {
                                VStack (spacing: -10){
                                    Image("bl17")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 90, height: 90)
                                    
                                    Text("Full Body CheckUp")
                                        .font(.caption)
                                        .multilineTextAlignment(.center)
                                }
                                .frame(width: 80, height: 100)
                            }
                            Button(action: {
                                // Action to perform when the button is tapped
                                print("Speciality selected: \(HealthChecks[1])")
                            }) {
                                VStack (spacing: -10){
                                    Image("bl18")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 90, height: 90)
                                    
                                    Text("Diabetes")
                                        .font(.caption)
                                        .multilineTextAlignment(.center)
                                }
                                .frame(width: 80, height: 100)
                            }
                            // Repeat this pattern for other buttons in HealthChecks array
                            Button(action: {
                                // Action to perform when the button is tapped
                                print("Speciality selected: \(HealthChecks[2])")
                            }) {
                                VStack (spacing: -10){
                                    Image("bl19")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 90, height: 90)
                                    
                                    Text("Women's Health")
                                        .font(.caption)
                                        .multilineTextAlignment(.center)
                                }
                                .frame(width: 80, height: 100)
                            }
                            Button(action: {
                                // Action to perform when the button is tapped
                                print("Speciality selected: \(HealthChecks[3])")
                            }) {
                                VStack(spacing: -10) {
                                    Image("bl58")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 90, height: 90)
                                    
                                    Text("HairFall")
                                        .font(.caption)
                                        .multilineTextAlignment(.center)
                                }
                                .frame(width: 80, height: 100)
                            }
                            Button(action: {
                                // Action to perform when the button is tapped
                                print("Speciality selected: \(HealthChecks[4])")
                            }) {
                                VStack (spacing: -10){
                                    Image("bl20")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 90, height: 90)
                                    
                                    Text("Health Packages")
                                        .font(.caption)
                                        .multilineTextAlignment(.center)
                                }
                                .frame(width: 80, height: 100)
                            }
                            Button(action: {
                                // Action to perform when the button is tapped
                                print("Speciality selected: \(HealthChecks[5])")
                            }) {
                                VStack(spacing: -10) {
                                    Image("bl21")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 90, height: 90)
                                    
                                    Text("Blood Studies")
                                        .font(.caption)
                                        .multilineTextAlignment(.center)
                                }
                                .frame(width: 80, height: 100)
                            }
                            Button(action: {
                                // Action to perform when the button is tapped
                                print("Speciality selected: \(HealthChecks[6])")
                            }) {
                                VStack(spacing: -10) {
                                    Image("bl22")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 90, height: 90)
                                    
                                    Text("Vitamins")
                                        .font(.caption)
                                        .multilineTextAlignment(.center)
                                }
                                .frame(width: 80, height: 100)
                            }
                            Button(action: {
                                // Action to perform when the button is tapped
                                print("Speciality selected: \(HealthChecks[7])")
                            }) {
                                VStack(spacing: -10) {
                                    Image("bl23")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 90, height: 90)
                                    
                                    Text("Heart")
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
                                print("Symptom selected: \(PopularCategories[0])")
                            }) {
                                VStack{
                                    Image("Pregnancy")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 70, height: 70)
                                    
                                    Text(PopularCategories[0])
                                        .font(.caption)
                                        .multilineTextAlignment(.center)
                                }
                                .frame(width: 80, height: 100)
                            }
                            Button(action: {
                                // Action to perform when the button is tapped
                                print("Symptom selected: \(PopularCategories[1])")
                            }) {
                                VStack {
                                    Image("X-Ray")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 70, height: 70)
                                    
                                    Text(PopularCategories[1])
                                        .font(.caption)
                                        .multilineTextAlignment(.center)
                                }
                                .frame(width: 80, height: 100)
                            }
                            Button(action: {
                                // Action to perform when the button is tapped
                                print("Symptom selected: \(PopularCategories[2])")
                            }) {
                                VStack{
                                    Image("Allergies")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 70, height: 70)
                                    
                                    Text(PopularCategories[2])
                                        .font(.caption)
                                        .multilineTextAlignment(.center)
                                }
                                .frame(width: 80, height: 100)
                            }
                            Button(action: {
                                // Action to perform when the button is tapped
                                print("Symptom selected: \(PopularCategories[3])")
                            }) {
                                VStack{
                                    Image("Infertility")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 70, height: 70)
                                    
                                    Text(PopularCategories[3])
                                        .font(.caption)
                                        .multilineTextAlignment(.center)
                                }
                                .frame(width: 80, height: 100)
                            }
                            Button(action: {
                                // Action to perform when the button is tapped
                                print("Symptom selected: \(PopularCategories[4])")
                            }) {
                                VStack{
                                    Image("JointPain")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 70, height: 70)
                                    
                                    Text(PopularCategories[4])
                                        .font(.caption)
                                        .multilineTextAlignment(.center)
                                }
                                .frame(width: 80, height: 100)
                            }
                            Button(action: {
                                // Action to perform when the button is tapped
                                print("Symptom selected: \(PopularCategories[5])")
                            }) {
                                VStack {
                                    Image("PCOD")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 70, height: 70)
                                    
                                    Text(PopularCategories[5])
                                        .font(.caption)
                                        .multilineTextAlignment(.center)
                                }
                                .frame(width: 80, height: 100)
                            }
                            Button(action: {
                                // Action to perform when the button is tapped
                                print("Symptom selected: \(PopularCategories[6])")
                            }) {
                                VStack {
                                    Image("STD")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 70, height: 70)
                                    
                                    Text(PopularCategories[6])
                                        .font(.caption)
                                        .multilineTextAlignment(.center)
                                }
                                .frame(width: 80, height: 100)
                            }
                            Button(action: {
                                // Action to perform when the button is tapped
                                print("Symptom selected: \(PopularCategories[7])")
                            }) {
                                VStack {
                                    Image("bl7")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 70, height: 70)
                                    
                                    Text(PopularCategories[7])
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
    }
}

#Preview {
    BookLab()
}

