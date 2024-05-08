//
//  AppState.swift
//  Team-7-HMS
//
//  Created by Subha on 25/04/24.
//

import Foundation
import SwiftUI

final class AppState : ObservableObject {
    @Published var rootViewId = UUID()
    @Published var patientUID : String = ""
}

func openURLInSafari(url : URL ) {
        UIApplication.shared.open(url)
    }
