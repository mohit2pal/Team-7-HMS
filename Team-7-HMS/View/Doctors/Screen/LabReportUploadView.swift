//
// LabReportUploadView.swift
//  Team-7-HMS
//
//  Created by Himal on 29/04/24.
//

import SwiftUI

struct LabReportUploadView: View {
    @State private var labReportURL: URL?
    @State private var documentPickerIsPresented = false
    @State private var selectedPatientIndex = 0 // Default selected patient index
    
    let patients = ["John Doe", "Jane Smith", "Michael Johnson", "Emily Brown", "David Wilson"]
    let fileName = "LabReport.pdf" // Assign the file name here
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 20) {
                HStack(spacing: 20) {
                    Text("Patient Name")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding(.leading)
                    
                    
                    Picker(selection: $selectedPatientIndex, label: Text("")) {
                        ForEach(0..<patients.count) { index in
                            Text(self.patients[index]).tag(index)
                        }
                    }
                    .pickerStyle(DefaultPickerStyle())
                    .frame(width: 150) // Adjust width to fit text and picker properly
                    .clipped() // Prevents text from being cut off
                    
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white) // Use a white background
                        .shadow(radius: 1) // Add a shadow for depth
                        .frame(width: 320)
                )
                
                Image("OnBoardScreen3")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 250) // Adjust height as needed
                    .padding(.bottom, 10)
                
                Text("Upload Lab Report")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Select the PDF file to upload and send it to the doctor.")
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .font(.body)
                
                
                if labReportURL != nil {
                    HStack(spacing: 10) {
                        Image(systemName: "doc.text.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20) // Adjust size as needed
                            .foregroundColor(.blue) // Use blue color for consistency with buttons
                        Text(fileName) // Use the assigned file name variable
                            .font(.body)
                            .foregroundColor(.black)
                            .lineLimit(1) // Limit text to one line
                    }
                } else {
                    HStack(spacing: 10) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20) // Adjust size as needed
                            .foregroundColor(.red) // Use red color for error indication
                        Text("No Document Selected") // Hard-coded error message
                            .font(.body)
                            .foregroundColor(.red)
                            .lineLimit(1) // Limit text to one line
                    }
                } // Added spacer for layout adjustment
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white) // Use a white background
                    .shadow(radius: 3) // Add a shadow for depth
            )
            
            VStack(spacing: 10) {
                
                Button(action: {
                    documentPickerIsPresented.toggle()
                }) {
                    Text("Select Lab Report")
                        .padding()
                        .frame(width: 360)
                        .background(Color("PrimaryColor"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 0.3)
                                
                        )
                }
                
                Button(action: {
                    if labReportURL != nil {
                        // Forward report action
                    }
                }) {
                    Text("Forward Report")
                        .padding()
                        .frame(width: 360)
                        .background(labReportURL != nil ? Color("PrimaryColor") : Color.gray) // Change color based on document selection
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 0.3)
                        )
                        .disabled(labReportURL == nil) // Disable button if no document is selected
                }
            }
            .padding()
        }
        .padding(.horizontal)
        .navigationBarTitle("Lab Report Upload", displayMode: .inline)
        .sheet(isPresented: $documentPickerIsPresented) {
            DocumentPickerView(documentURL: $labReportURL)
        }
    }
}

struct DocumentPickerView: UIViewControllerRepresentable {
    @Binding var documentURL: URL?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf], asCopy: true)
        documentPicker.delegate = context.coordinator
        return documentPicker
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}
    
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        var parent: DocumentPickerView
        
        init(parent: DocumentPickerView) {
            self.parent = parent
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            // For simplicity, we are assuming only one document is picked
            parent.documentURL = urls.first
        }
    }
}

struct LabReportUploadView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LabReportUploadView()
        }
    }
}
