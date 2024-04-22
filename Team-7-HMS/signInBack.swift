//
//  signInBack.swift
//  Team-7-HMS
//
//  Created by Subha on 22/04/24.
//

import SwiftUI

struct signInBack: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color(#colorLiteral(red: 0.021709632128477097, green: 0.013090278021991253, blue: 0.12083332985639572, alpha: 1)))
            .frame(width: 44, height: 44)
            
            //Iconly/Light-Outline/Arrow - Right
            Rectangle()
                .fill(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
            .frame(width: 22, height: 22)
            .rotationEffect(.degrees(-179.29))
        }
    }
    
}

#Preview {
    signInBack()
}
