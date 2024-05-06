import SwiftUI
import FirebaseFirestore // Ensure you've imported FirebaseFirestore if needed

struct MedicalRecordView: View {
    @State private var medicalRecords: PatientMedicalRecords?
    @State private var isLoading = true
    @State private var errorMessage: String?

    @State var patientId: String

    var body: some View {
        VStack {
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .onAppear {
                        // Using FirebaseHelperFunctions class to fetch medical records
                        FirebaseHelperFunctions.getMedicalRecords(patientUID: patientId) { records, error in
                            if let error = error {
                                self.errorMessage = "Failed to fetch records: \(error.localizedDescription)"
                            } else if let records = records {
                                self.medicalRecords = records
                            } else {
                                self.errorMessage = "No medical records found."
                            }
                            self.isLoading = false
                        }
                    }
            } else if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            } else if let medicalRecords = medicalRecords {
                List {
                    Section(header: Text("Patient Details")) {
                        Text("Allergies: \(medicalRecords.alergies.isEmpty ? "No allergies" : medicalRecords.alergies.joined(separator: ", "))")
                        Text("Past Medical History: \(medicalRecords.pastMedical.isEmpty ? "No past medical history" : medicalRecords.pastMedical.joined(separator: ", "))")
                        Text("Surgeries: \(medicalRecords.surgeries.isEmpty ? "No surgeries" : medicalRecords.surgeries.joined(separator: ", "))")
                        Text("Blood Group: \(medicalRecords.bloodGroup)")
                        Text("Gender: \(medicalRecords.gender)")
                        Text("Height: \(medicalRecords.height)")
                        Text("Weight: \(medicalRecords.weight)")
                        Text("Phone Number: \(medicalRecords.phoneNumber)")
                    }
                }
            } else {
                Text("No patient records found.")
            }
        }
    }
}

// Dummy preview provider
struct MedicalRecordView_Previews: PreviewProvider {
    static var previews: some View {
        MedicalRecordView(patientId: "hi")
    }
}
