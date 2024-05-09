//
//  paymentPageView.swift
//  dermShield1
//
//  Created by Himal  on 08/05/24.
//

import SwiftUI

struct PaymentPageView: View {
    @State private var selectedPaymentMethod: String? = nil
    @State private var isSheetPresented = false
    
    var body: some View {
        ZStack {
            Color(.white).edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 16) {
                Text("Please choose your payment method")
                    .font(.callout)
                    .padding(.leading)
                    .padding([.top, .trailing])
                
                VStack(spacing: 16) {
                    PaymentMethodRow(imageName: "paypal", name: "PayPal", isSelected: $selectedPaymentMethod)
                    PaymentMethodRow(imageName: "gpay", name: "Google Pay", isSelected: $selectedPaymentMethod)
                    PaymentMethodRow(imageName: "apple", name: "Apple Pay", isSelected: $selectedPaymentMethod)
                    PaymentMethodRow(imageName: "creditcard", name: "Credit Card", isSelected: $selectedPaymentMethod)
                }
                .padding(.horizontal)
                
                Spacer()
                
                NavigationLink(destination: EmptyView()) {
                    Text("Continue")
                        .foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .background(Color("PrimaryColor"))
                        .cornerRadius(18)
                        .padding(.horizontal)
                }
                .padding(.horizontal)
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
}

struct PaymentMethodRow: View {
    var imageName: String
    var name: String
    @Binding var isSelected: String?
    
    var body: some View {
        Button(action: {
            isSelected = name
        }) {
            HStack {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .cornerRadius(30)
                    .padding(.leading) // Add padding here
                
                Text(name)
                    .font(.callout)
                    .foregroundColor(.black)
                    .padding(.leading, 8)
                
                Spacer()
                
            }
            .padding([.top, .bottom])
            .background(.white) // Change the background color based on isSelected
            .cornerRadius(18)
            .frame(width: 380, height: 56)
            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(isSelected == name ? Color("PrimaryColor").opacity(0.8): Color.black.opacity(0.1), lineWidth: 1.3)
            )
            
        }
    }
}

struct PaymentPage_Previews: PreviewProvider {
    static var previews: some View {
        PaymentPageView()
    }
}
