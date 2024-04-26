//
//  SplashScreen.swift
//  Team-7-HMS
//
//  Created by Subha on 25/04/24.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        
            VStack(alignment: .center) {
                Text("UrCare")
                    .font(.system(size: 100, weight: .black))
                    .foregroundColor(.black)
                    
                Text("Your Healthcare")
                    .font(.system(size: 16, weight: .regular))
                    .kerning(15)
                    .fontWeight(.regular)
            }
        }
    }

#Preview {
    SplashScreen()
}
