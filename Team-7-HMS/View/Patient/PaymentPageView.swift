import SwiftUI

struct PaymentPageView: View {
    @State private var selectedPaymentMethod: String? = nil
    @State private var isSheetPresented = false
    
    // State properties for the text field inputs for each payment method
    @State private var cardNumber: String = ""
    @State private var expirationDate: String = ""
    @State private var cvv: String = ""
    @State private var paypalEmail: String = ""
    @State private var googlePayEmail: String = ""
    @State private var applePayEmail: String = ""
    
    // Add a Binding variable to track payment success
    @Binding var isPaymentSuccessful: Bool
    @Binding var showingPaymentDetails: Bool
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
//            Color(.white).edgesIgnoringSafeArea(.all)
            
            NavigationView {
                VStack {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 16) {
                            
                            LazyVGrid(columns: columns, spacing: 20) {
                                PaymentMethodSquare(imageName: "paypal", name: "PayPal", isSelected: $selectedPaymentMethod)
                                PaymentMethodSquare(imageName: "gpay", name: "Google Pay", isSelected: $selectedPaymentMethod)
                                PaymentMethodSquare(imageName: "apple", name: "Apple Pay", isSelected: $selectedPaymentMethod)
                                PaymentMethodSquare(imageName: "creditcard", name: "Credit Card", isSelected: $selectedPaymentMethod)
                            }
                            .padding(.horizontal)
                            
                            // Conditional Text Fields based on selectedPaymentMethod
                            if selectedPaymentMethod == "Credit Card" {
                                creditCardFields
                            } else if selectedPaymentMethod == "PayPal" {
                                modernTextField("PayPal Email", text: $paypalEmail)
                            } else if selectedPaymentMethod == "Google Pay" {
                                modernTextField("Google Pay Email", text: $googlePayEmail)
                            } else if selectedPaymentMethod == "Apple Pay" {
                                modernTextField("Apple Pay Email", text: $applePayEmail)
                            }
                        }
                    }
                    
                    // Continue Button
                    Button(action: {
                        // Toggle the binding variable when the button is clicked
                        isPaymentSuccessful.toggle()
                        showingPaymentDetails.toggle()
                    }) {
                        Text("Continue")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 15)
                            .background(selectedPaymentMethod != nil ? Color("PrimaryColor") : Color.gray)
                            .cornerRadius(18)
                            .padding(.horizontal)
                    }
                    .disabled(selectedPaymentMethod == nil)
                    .padding(.bottom, 20)
                }
                .navigationTitle("Choose the Payment Method")
                .navigationBarTitleDisplayMode(.inline)
            }
            .padding()
            .background(Color.background)
        }
        .navigationBarItems(trailing:
                                Button(action: {
                                    isSheetPresented.toggle()
                                }) {
                                    Text("Add Card")
                                        .font(.callout)
                                        .foregroundColor(Color("PrimaryColor"))
                                }
        )
        .sheet(isPresented: $isSheetPresented) {
            EmptyView() // Placeholder for now
        }
    }
    
    // Extracted credit card fields for better readability
    private var creditCardFields: some View {
        VStack(alignment: .leading, spacing: 10) {
            modernTextField("Card Number", text: $cardNumber)
            modernTextField("Expiration Date (MM/YY)", text: $expirationDate)
            modernTextField("CVV", text: $cvv)
        }
    }
    
    // Modern text field design
    private func modernTextField(_ placeholder: String, text: Binding<String>) -> some View {
        TextField(placeholder, text: text)
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            .padding(.horizontal)
            .shadow(radius: 1)
    }
}

struct PaymentMethodSquare: View {
    var imageName: String
    var name: String
    @Binding var isSelected: String?
    
    var body: some View {
        Button(action: {
            isSelected = name
        }) {
            VStack {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .padding(.top)
                
                Text(name)
                    .font(.callout)
                    .foregroundColor(.black)
                    .padding(.top, 8)
            }
            .padding()
            .frame(width: 150, height: 150)
            .background(isSelected == name ? Color.accentColor.opacity(0.5) : .white)
            .cornerRadius(18)
            .customShadow()
//            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(isSelected == name ? Color("PrimaryColor").opacity(0.8) : Color.black.opacity(0.1), lineWidth: 1.3)
            )
        }
    }
}

struct PaymentPage_Previews: PreviewProvider {
    static var previews: some View {
        PaymentPageView(isPaymentSuccessful: .constant(false), showingPaymentDetails: .constant(true))
    }
}
