//
//  ReportsListView.swift
//  Team-7-HMS
//
//  Created by Ritwatz on 06/05/24.
//

import SwiftUI
import Firebase

// Data Model
struct PatientReport: Identifiable { // Conforming to Identifiable
    let id = UUID()
    let testName: String
    let patientID: String
    let scheduledDate: String
    let caseId : String
    let status : String
    let pdfURL : String
}

// View for the rounded rectangle card
struct ReportCardView: View {
    let report: PatientReport
    
    var body: some View {
        
        NavigationLink {
            LabReportUploadView(patientUID: report.patientID, caseID: report.caseId, medicalTest: report.testName)
        } label: {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(report.testName)
                        .font(.headline)
                    Text("Case ID: \(report.caseId.suffix(5))")
                        .font(.subheadline)
                    Text("Date: \(report.scheduledDate.replacingOccurrences(of: "_", with: "-"))")
                        .font(.subheadline)
                }
                .padding()
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .padding()
            }
            .foregroundStyle(.black)
            .background(Color.white)
            .cornerRadius(15)
            .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 2)
        }
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

struct ReportCardViewCompleted: View {
    let report: PatientReport
    
    var body: some View {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(report.testName)
                        .font(.headline)
                    Text("Case ID: \(report.caseId.suffix(5))")
                        .font(.subheadline)
                    Text("Date: \(report.scheduledDate.replacingOccurrences(of: "_", with: "-"))")
                        .font(.subheadline)
                }
                .padding()
                
                Spacer()
                
                Button(action: {
                    openURLInSafari(url: URL(string: report.pdfURL)!)
                }, label: {
                    Image(systemName: "arrow.down.circle")
                        .resizable()
                        .frame(width: 20 , height: 20)
                })
                .padding(.horizontal)

            }
            .foregroundStyle(.black)
            .background(Color.white)
            .cornerRadius(15)
            .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 2)
        }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}


struct ReportsListView: View {
    @State private var reportsUpcoming: [PatientReport] = []
    @State private var reportsCompleted: [PatientReport] = []

    
    @State private var types = ["In Progress" , "Completed"]
    @State private var selectedViewIndex = 0
    var docUID : String? {
        Auth.auth().currentUser?.uid
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.background.ignoresSafeArea()
                ScrollView {
                    Picker(selection: $selectedViewIndex, label: Text("Select a segment")) {
                                ForEach(0..<types.count) { index in
                                    Text(types[index]).tag(index)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                    
                    if selectedViewIndex == 0 {
                        if reportsUpcoming.isEmpty {
                            Text("There are no medical tests appointed")
                                .foregroundStyle(.gray)
                        }
                        else{
                            LazyVStack(alignment: .leading) {
                                ForEach(reportsUpcoming) { report in
                                    ReportCardView(report: report)
                                }
                                
                            }
                        }
                    }
                    else{
                        if reportsCompleted.isEmpty{
                            Text("There are no completed medical tests.")
                                .foregroundStyle(.gray)
                        }
                        else {
                            LazyVStack(alignment: .leading) {
                                ForEach(reportsCompleted) { report in
                                    ReportCardViewCompleted(report: report)
                                }
                                
                            }
                        }
                    }
                    Spacer(minLength: 110)
                }
                .padding(.horizontal)
            }
           
            .navigationTitle("Report")
            .onAppear{
                FirebaseHelperFunctions().fetchMedicalTestsDoc(doctorUID: docUID ?? "") { reports in
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd-MM-yyyy"
                    
                    let upcoming = reports.filter{ $0.status == "In progress"}
                    
                    self.reportsUpcoming = upcoming.sorted { (report1, report2) in
                              let date1 = dateFormatter.date(from: report1.scheduledDate.replacingOccurrences(of: "_", with: "-")) ?? Date()
                              let date2 = dateFormatter.date(from: report2.scheduledDate.replacingOccurrences(of: "_", with: "-")) ?? Date()
                              return date1 > date2
                          }
                    
                    let completed = reports.filter{ $0.status == "finish"}
                    
                    self.reportsCompleted = completed.sorted { (report1, report2) in
                              let date1 = dateFormatter.date(from: report1.scheduledDate.replacingOccurrences(of: "_", with: "-")) ?? Date()
                              let date2 = dateFormatter.date(from: report2.scheduledDate.replacingOccurrences(of: "_", with: "-")) ?? Date()
                              return date1 > date2
                          }
                    
                }
            }
        }
    }
    }




//// Sample Data
//let sampleReports: [PatientReport] = [
//    PatientReport(testName: "Blood Test", patientID: "P001", scheduledDate: "", caseId: ""),
//    PatientReport(testName: "X-ray", patientID: "P002", scheduledDate: "", caseId: ""),
//    // Add more sample reports here
//]

// Preview
struct ReportsListView_Previews: PreviewProvider {
    static var previews: some View {
            ReportsListView()
    }
}
