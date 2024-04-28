//
//  AppState.swift
//  Team-7-HMS
//
//  Created by Subha on 25/04/24.
//

import Foundation

final class AppState : ObservableObject {
    @Published var rootViewId = UUID()
    @Published var patientUID : String?
}

