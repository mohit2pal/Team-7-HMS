//import SwiftUI
//
//struct AddingSlot: View {
//    @State private var doctors: [DoctorInfo] = []
//    @State private var selectedDoctor: DoctorInfo? = nil {
//        didSet {
//            fetchBookedSlots()
//        }
//    }
//    @State private var selectedDate: Date? = nil {
//        didSet{
//            fetchBookedSlots()
//        }
//    }
//    @State private var searchText = ""
//    @State private var bookedSlots: [String] = []
//    @State private var selectedSlots: [String] = []
//    @State private var showSuccessAnimation = false // New state variable for showing the tick animation
//    
//    let firebaseHelper = FirebaseHelperFunctions()
//    
//    // Existing code remains unchanged...
//    
//    // MARK: - Submit Button
//    var submitButton: some View {
//        Button(action: {
//            if let selectedDoctor = selectedDoctor {
//                firebaseHelper.createSlots(doctorName: selectedDoctor.name, doctorID: selectedDoctor.id, date: selectedDate ?? Date(), slots: selectedSlots) {
//                    // Assuming createSlots has a completion handler to notify when done
//                    self.showSuccessAnimation = true
//                    
//                    // Wait for 2 seconds to show the tick animation, then navigate back
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                        self.showSuccessAnimation = false
//                        self.selectedDoctor = nil
//                        self.selectedDate = nil
//                        self.selectedSlots = []
//                    }
//                }
//            } else {
//                print("No doctor selected.")
//            }
//        }, label: {
//            Text("Press here to submit")
//        })
//        .frame(width: 296, height: 44)
//        .background(isSubmitButtonDisabled ? Color.gray : Color.myAccent)
//        .foregroundColor(.white)
//        .cornerRadius(20)
//        .disabled(isSubmitButtonDisabled)
//        .fullScreenCover(isPresented: $showSuccessAnimation) {
//            // FullScreenCover for success animation
//            SuccessAnimationView()
//        }
//    }
//}
//
//struct SuccessAnimationView: View {
//    var body: some View {
//        ZStack {
//            Color.background.edgesIgnoringSafeArea(.all)
//            Image(systemName: "checkmark.circle.fill") // Use a tick mark image or system symbol
//                .resizable()
//                .scaledToFit()
//                .frame(width: 200, height: 200)
//                .foregroundColor(.green)
//        }
//    }
//}
//
//// Existing structs like SearchBar and DateButton remain unchanged
//
//// #Preview {
////     AddingSlots()
//// }
