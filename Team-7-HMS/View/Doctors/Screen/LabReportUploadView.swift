import SwiftUI

struct LabReportUploadView: View {
    @State private var labReportURL: URL?
    @State private var isReportSent = false
    @State private var documentPickerIsPresented = false
    @State private var selectedPatientIndex = 0 // Default selected patient index
    
    let patients = ["John Doe", "Jane Smith", "Michael Johnson", "Emily Brown", "David Wilson"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack {
                Image("OnBoardScreen3")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 300)
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                
                HStack() {
                    Text("Patient Name")
                        .font(.headline)
                        .foregroundColor(.black)
                    Picker(selection: $selectedPatientIndex, label: Text("")) {
                        ForEach(0..<patients.count) { index in
                            Text(self.patients[index]).tag(index)
                        }
                    }
                    .pickerStyle(DefaultPickerStyle())
                    .background(Color("PrimaryColor"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.top, 10)
                }
            }
            
            Text("Upload Lab Report")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Please select the PDF lab report file to upload. Once uploaded, you can send it to the doctor for review.")
                .foregroundColor(.gray)
                .multilineTextAlignment(.leading)
                .font(.body)
            
            VStack(spacing: 20) {
                if labReportURL != nil {
                    Text("Lab Report Uploaded Successfully!")
                        .foregroundColor(.green)
                        .padding(.bottom)
                }
                
                Button(action: {
                    documentPickerIsPresented.toggle()
                }) {
                    Text("Select Lab Report")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color("PrimaryColor"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("PrimaryColor"), lineWidth: 1)
                        )
                }
                
                if labReportURL != nil && !isReportSent {
                    Button(action: {
                        // Simulating sending report to doctor
                        // You can replace this with actual sending logic
                        isReportSent = true
                    }) {
                        Text("Send Report to Doctor")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("PrimaryColor"))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("PrimaryColor"), lineWidth: 1)
                            )
                    }
                }
            }
            .padding(.horizontal)
        }
        .padding()
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
