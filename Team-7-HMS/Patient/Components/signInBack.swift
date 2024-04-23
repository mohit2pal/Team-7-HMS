//
//  signInBack.swift
//  Team-7-HMS
//
//  Created by Subha on 22/04/24.
//

import SwiftUI

struct signInBack: View {
    var body: some View {
        //image 8
        Image(uiImage: #imageLiteral(resourceName: "Arrow"))
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 20, height: 20)
            .clipped()
        .frame(width: 20, height: 20)
    }
    
}

#Preview {
    signInBack()
}
