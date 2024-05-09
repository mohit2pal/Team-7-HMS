//Button {
//    isBooking = true
//    // Ensure a slot is selected before attempting to book
//    guard let selectedSlot = selectedSlot else {
//        print("No slot selected")
//        return
//    }
//    
//    // Call the bookSlot function
//    FirebaseHelperFunctions.bookSlot(doctorUID: doctorId, date: date, slotTime: selectedSlot, patientUID: patientUID, issues: complaints) { result in
//        switch result {
//        case .success(let successMessage):
//            print(successMessage)
//            // Handle successful booking, e.g., show an alert or update the UI
//            
//        case .failure(let error):
//            print("Failed to book slot: \(error)")
//            // Handle failure, e.g., show an error message
//        }
//    }
//    self.showSuccessAnimation = true
//    
//    DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // 2 seconds delay
//        self.isBooking = false
//        self.bookingCompleted = true
//        presentationMode.wrappedValue.dismiss()
//    }
//} label: {
//    ZStack {
//        RoundedRectangle(cornerRadius: 20)
//            .fill(selectedSlot == nil ? Color.gray : Color(#colorLiteral(red: 0.48627451062202454, green: 0.5882353186607361, blue: 1, alpha: 1))) // Change fill color based on whether a slot is selected
//            .frame(width: 300, height: 50)
//        
//        if isBooking {
//            ProgressView()
//                .progressViewStyle(CircularProgressViewStyle(tint: .white))
//                .scaleEffect(0.5)
//        } else if bookingCompleted {
//            Image(systemName: "checkmark.circle.fill")
//                .foregroundColor(.green)
//                .scaleEffect(1.5)
//                .transition(.scale)
//        } else {
//            Text("Book Selected Slot").font(.system(size: 20, weight: .regular))
//                .foregroundColor(selectedSlot == nil ? .white.opacity(0.5) : .white) // Change text color opacity based on whether a slot is selected
//                .multilineTextAlignment(.center)
//        }
//    }
//}
//.disabled(selectedSlot == nil) // Disable the button if no slot is selected
