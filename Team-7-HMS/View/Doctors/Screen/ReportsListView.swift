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


struct ReportsListView: View {
    @State private var reports: [PatientReport] = []
    
    var docUID : String? {
        Auth.auth().currentUser?.uid
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.background.ignoresSafeArea()
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        ForEach(reports) { report in
                            ReportCardView(report: report)
                        }
                        
                    }
                }
                .padding(.horizontal)
            }
           
            .navigationTitle("Report")
            .onAppear{
                FirebaseHelperFunctions().fetchMedicalTestsDoc(doctorUID: docUID ?? "") { reports in
                    self.reports = reports
                }
            }
        }
    }
    }




// Sample Data
let sampleReports: [PatientReport] = [
    PatientReport(testName: "Blood Test", patientID: "P001", scheduledDate: "", caseId: ""),
    PatientReport(testName: "X-ray", patientID: "P002", scheduledDate: "", caseId: ""),
    // Add more sample reports here
]

// Preview
struct ReportsListView_Previews: PreviewProvider {
    static var previews: some View {
            ReportsListView()
    }
}
