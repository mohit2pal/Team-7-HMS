import SwiftUI

struct slotsAvailableSwiftUIView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var isBooking = false
    @State private var bookingCompleted = false
    @State private var showSuccessAnimation: Bool = false
    
    var patientUID: String
    @State private var doctorDetails: [String: Any]? // Optional dictionary
    @State private var slotDetails: [String: Any]?
    @State private var selectedSlot: String?
    let doctorName: String
    let date: String
    @State var doctorId: String
    
    @State private var complaints: [String] = []
    @State private var newComplaint: String = ""
    // State for showing PaymentDetailsView
    @State private var showingPaymentDetails = false
    
    @State private var isPaymentSuccessful: Bool = false
    
    var body: some View {
        VStack {
            ScrollView {
                DoctorDetailsSection()
                SlotSelectionSection(slotDetails: $slotDetails, selectedSlot: $selectedSlot, doctorId: doctorId, complaints: $complaints, newComplaint: $newComplaint)
            }
            .scrollIndicators(.hidden)
            Spacer()
            Text("Select Payment Method to Unable Booking.")
                .foregroundStyle(Color.gray)
            BookingButtonSection()
        }
        .padding()
        .background(Color.background)
        .fullScreenCover(isPresented: $showSuccessAnimation) {
            SuccessAnimationView()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showingPaymentDetails = true
                }) {
                    Image(systemName: "creditcard")
                }
            }
        }
        .sheet(isPresented: $showingPaymentDetails) {
            PaymentPageView(isPaymentSuccessful: $isPaymentSuccessful, showingPaymentDetails: $showingPaymentDetails)
        }
        .onAppear {
            fetchDoctorsDetails(name: doctorName) { details, error in
                if let error = error {
                    print("Error fetching doctor details: \(error)")
                } else {
                    self.doctorDetails = details
                }
                
                FirebaseHelperFunctions().fetchSlots(doctorID: doctorId, date: date) { slots, error in
                    if let error = error {
                        print("Error fetching slots: \(error)")
                    } else {
                        self.slotDetails = slots
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func DoctorDetailsSection() -> some View {
        if let doctorDetails = doctorDetails, !doctorDetails.isEmpty {
            DoctorDetailsView(
                doctorName: doctorName,
                speciality: doctorDetails["speciality"] as? String ?? "",
                education: doctorDetails["education"] as? String ?? "",
                experience: doctorDetails["experience"] as? Int ?? 0
            )
        } else {
            ProgressView()
        }
    }
    
    @ViewBuilder
    private func BookingButtonSection() -> some View {
        Button(action: bookSlot) {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(#colorLiteral(red: 0.48627451062202454, green: 0.5882353186607361, blue: 1, alpha: 1)))
                    .frame(width: 300, height: 50)
                
                if isBooking {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(0.5)
                } else if bookingCompleted {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                        .scaleEffect(1.5)
                        .transition(.scale)
                } else {
                    Text("Book Selected Slot")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundColor(selectedSlot == nil || !isPaymentSuccessful ? .white.opacity(0.5) : .white)
                        .multilineTextAlignment(.center)
                }
            }
        }
        .disabled(selectedSlot == nil || !isPaymentSuccessful)
    }
    
    private func bookSlot() {
        isBooking = true
        guard let selectedSlot = selectedSlot else {
            print("No slot selected")
            return
        }
        
        FirebaseHelperFunctions.bookSlot(doctorUID: doctorId, date: date, slotTime: selectedSlot, patientUID: patientUID, issues: complaints) { result in
            switch result {
            case .success(let successMessage):
                print(successMessage)
            case .failure(let error):
                print("Failed to book slot: \(error)")
            }
        }
        self.showSuccessAnimation = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isBooking = false
            self.bookingCompleted = true
            presentationMode.wrappedValue.dismiss()
        }
    }
}

#Preview {
    slotsAvailableSwiftUIView(patientUID: "", doctorName: "Nithin Reddy", date: "02_05_2024", doctorId: "xh3HrIsjjxdrXzRZouDgxqTdLn92")

}
