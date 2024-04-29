//import SwiftUI
//
//struct ContentView: View {
//    @State private var phoneNumber = ""
//    @State private var isValidPhoneNumber = true
//
//    var body: some View {
//        TextField("Phone Number", text: $phoneNumber)
//            .keyboardType(.namePhonePad)
//            .textFieldStyle(.plain)
//            .padding()
//            .background(isValidPhoneNumber ? Color.white : Color.red)
//            .cornerRadius(10)
//            .onChange(of: phoneNumber) { newValue in
//                isValidPhoneNumber = isValidPhone(testStr: newValue)
//            }
//    }
//
//    func isValidPhone(testStr:String) -> Bool {
//        let phoneRegEx = "^\\d{3}-\\d{3}-\\d{4}$"
//        let phoneTest = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
//        return phoneTest.evaluate(with: testStr)
//    }
//}
