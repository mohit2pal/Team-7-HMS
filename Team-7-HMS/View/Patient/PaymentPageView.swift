import SwiftUI

struct PaymentPageView: View {
    @State private var selectedPaymentMethod: String? = nil
    @State private var isSheetPresented = false
    
    // Add state properties for the text field inputs for each payment method
    @State private var cardNumber: String = ""
    @State private var expirationDate: String = ""
    @State private var cvv: String = ""
    @State private var paypalEmail: String = ""
    @State private var googlePayEmail: String = ""
    @State private var applePayEmail: String = ""
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            Color(.white).edgesIgnoringSafeArea(.all)
            
            VStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Please choose your payment method")
                            .font(.callout)
                            .padding(.leading)
                            .padding([.top, .trailing])
                        
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
                            TextField("PayPal Email", text: $paypalEmail)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.horizontal)
                        } else if selectedPaymentMethod == "Google Pay" {
                            TextField("Google Pay Email", text: $googlePayEmail)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.horizontal)
                        } else if selectedPaymentMethod == "Apple Pay" {
                            TextField("Apple Pay Email", text: $applePayEmail)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.horizontal)
                        }
                    }
                }
                
                // Continue Button
                Button(action: {
                    // Action for continue button
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
                .disabled(selectedPaymentMethod == nil) // Disable button if no payment method is selected
                .padding(.bottom, 20) // Add some padding at the bottom
            }
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
            EmptyView() // Empty view for now
        }
    }
    
    // Extracted credit card fields for better readability
    private var creditCardFields: some View {
        VStack(alignment: .leading, spacing: 10) {
            TextField("Card Number", text: $cardNumber)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            TextField("Expiration Date (MM/YY)", text: $expirationDate)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            TextField("CVV", text: $cvv)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
        }
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
            .background(isSelected == name ? Color("PrimaryColor").opacity(0.3) : .white)
            .cornerRadius(18)
            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(isSelected == name ? Color("PrimaryColor").opacity(0.8) : Color.black.opacity(0.1), lineWidth: 1.3)
            )
        }
    }
}

struct PaymentPage_Previews: PreviewProvider {
    static var previews: some View {
        PaymentPageView()
    }
}
