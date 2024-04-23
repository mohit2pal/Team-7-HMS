//
//  testing.swift
//  Team-7-HMS
//
//  Created by Meghs on 23/04/24.
//

import SwiftUI

struct testing: View {
    
    @State var title: String
    var body: some View {
        NavigationStack{
            Text("This is \(title) Page")
        }
        .navigationTitle(title)
    }
}

#Preview {
    NavigationStack{
        testing(title: "Nephroy")
    }
}
