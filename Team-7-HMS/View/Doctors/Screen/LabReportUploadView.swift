//
// LabReportUploadView.swift
//  Team-7-HMS
//
//  Created by Himal on 29/04/24.
//

import SwiftUI
import FirebaseStorage

struct LabReportUploadView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var isLoading = false
    @State private var labReportURL: URL?
    @State private var documentPickerIsPresented = false
    @State private var selectedPatientIndex = 0 // Default selected patient index
    @State private var diagnosis : String = ""
    @State var errorMsg = false
    @State var fileName : String?// Assign the file name here
    
    @State var patientUID : String
    @State var caseID : String
    @State var medicalTest : String
    var body: some View {
        ZStack{
            Color.background.ignoresSafeArea()
            ScrollView{
                VStack(spacing: 20) {
                    VStack(spacing: 20) {
                        
                        HStack(spacing: 20) {
                            VStack
                            {
                                Text(medicalTest)
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .padding(.leading)
                                
                                Text(caseID.suffix(5))
                                
                                if errorMsg{
                                    Text("Error uploading file. Please try again")
                                        .foregroundStyle(.red)
                                }
                            }
                        }
                        .padding()
                        .customShadow()
                        Spacer()
                        Image("OnBoardScreen3")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 100) // Adjust height as needed
                            .padding(.bottom, 10)
                        
                        
                        Text("Upload Lab Report")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("Select the PDF file to upload and send it to the doctor.")
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .font(.body)
                        
                        
                        Spacer()
                        
                        if labReportURL != nil {
                            HStack(spacing: 10) {
                                Image(systemName: "doc.text.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20) // Adjust size as needed
                                    .foregroundColor(.blue) // Use blue color for consistency with buttons
                                Text(fileName ?? "Lab report Name") // Use the assigned file name variable
                                    .font(.body)
                                    .foregroundColor(.black)
                                    .lineLimit(1) // Limit text to one line
                            }
                            
                            
                            HStack{
                                Text("Analysis")
                                    .bold()
                               
                            }
                            TextEditor(text: $diagnosis)
                                .padding()
                                .frame(height : 250)
                                
                                .multilineTextAlignment(.leading)
                                .disableAutocorrection(true)
                                .autocapitalization(.sentences)
                                .shadow(color: Color.black.opacity(0.2), radius: 1, x: 0, y: 2)
                                .cornerRadius(15)
                                       
                            
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
                    
                    
                    VStack(spacing: 10) {
                        
                        Button(action: {
                            documentPickerIsPresented.toggle()
                        }) {
                            Text("Select Lab Report")
                                .font(.headline)
                                .padding()
                                .frame(width: 360)
                                .background(Color("PrimaryColor"))
                                .foregroundColor(.white)
                                .cornerRadius(20)
                        }
                        
                        Button(action: {
                            isLoading = true
                            if let reportURL = labReportURL {
                                // Forward report action
                                uploadFileToFirebaseStorage(url: reportURL) { result in
                                    switch result {
                                    case .success(let url):
                                        FirebaseHelperFunctions().updateMedicalRecord(for: caseID, pdf: url, analysis: diagnosis)
                                        
                                        isLoading = false
                                        presentationMode.wrappedValue.dismiss()
                                    case .failure(let error):
                                        print("Error uploading file to Firebase Storage: \(error.localizedDescription)")
                                        
                                        isLoading = false
                                        errorMsg = true
                                 
                                        // Handle error if necessary
                                    }
                                }
                            }
                        }) {
                            
                            if isLoading {
                                ProgressView()
                            }
                            else{
                                Text("Forward Report")
                                    .padding()
                                    .font(.headline)
                                    .frame(width: 360)
                                    .background(labReportURL != nil ? Color("PrimaryColor") : Color.gray) // Change color based on document selection
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                                    .disabled(labReportURL == nil) // Disable button if no document is selected
                            }
                        }
                    }
                    .padding()
                }
                .padding(.horizontal)
                .background(Color.background)
                .navigationBarTitle("Lab Report Upload", displayMode: .inline)
                .sheet(isPresented: $documentPickerIsPresented) {
                    DocumentPickerView(documentURL: $labReportURL, fileName: $fileName)
                }
            }
        }
    }
    
    func uploadFileToFirebaseStorage(url: URL,  completion: @escaping (Result<String, Error>) -> Void) {
        let fileName = url.lastPathComponent
        let storageRef = Storage.storage().reference().child("lab_reports/\(fileName)")

        storageRef.putFile(from: url, metadata: nil) { metadata, error in
            guard let _ = metadata else {
                // Error occurred. Handle error.
                print("Error uploading file: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            // File uploaded successfully.
            storageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    // Error occurred. Handle error.
                    print("Error getting download URL: \(error?.localizedDescription ?? "Unknown error")")
                    completion(.failure(error!))
                    return
                }
                
                // File URL retrieved successfully.
                print("File uploaded successfully. URL: \(downloadURL)")
                completion(.success(downloadURL.absoluteString))
                
                
            }
        }
    }

}

struct DocumentPickerView: UIViewControllerRepresentable {
    @Binding var documentURL: URL?
    @Binding var fileName : String?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf , .image], asCopy: true)
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
            if let url = urls.first {
                parent.documentURL = url
                
                // Update the fileName variable with the selected file name
                parent.fileName = url.lastPathComponent
            }
        }
    }
    
}

struct LabReportUploadView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LabReportUploadView(patientUID: "", caseID: "", medicalTest: "")
        }
    }
}
