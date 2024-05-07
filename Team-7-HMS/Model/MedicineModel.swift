//
//  MedicineModel.swift
//  Team-7-HMS
//
//  Created by Subha on 06/05/24.
//

import Foundation

struct Medicine: Identifiable {
    let id = UUID()
    let name: String
    let morningDose: Bool
    let eveningDose: Bool
    let nightDose: Bool
    
    // Initializer to create a Medicine instance from a dictionary
    init?(dictionary: [String: Any]) {
        guard let name = dictionary["name"] as? String,
              let morningDose = dictionary["morningDose"] as? Bool,
              let eveningDose = dictionary["eveningDose"] as? Bool,
              let nightDose = dictionary["nightDose"] as? Bool else {
            return nil
        }
        
        self.name = name
        self.morningDose = morningDose
        self.eveningDose = eveningDose
        self.nightDose = nightDose
    }
}

// Example data - replace this with actual data fetching from Firebase
let medi = [
    Medicine(dictionary: ["name": "Dolo", "morningDose": true, "eveningDose": false, "nightDose": false]),
    Medicine(dictionary: ["name": "Paracetamol", "morningDose": true, "eveningDose": true, "nightDose": true])
]

