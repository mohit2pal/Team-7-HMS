//
//  GeneratePassword.swift
//  Team-7-HMS
//
//  Created by Meghs on 22/04/24.
//

import Foundation

func generateRandomPassword(length: Int) -> String {
    let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()"
    var password = ""
    
    for _ in 0..<length {
        let randomIndex = Int(arc4random_uniform(UInt32(characters.count)))
        let character = characters[characters.index(characters.startIndex, offsetBy: randomIndex)]
        password.append(character)
    }
    return password
}
