//
//  SendEmail.swift
//  Team-7-HMS
//
//  Created by Subha on 28/04/24.
//

import Foundation

class EmailFunction {
    static func sendEmail(subject: String, body: String, to recipient: String) {
        guard let url = URL(string: "https://hms-form-mfyl4y27cq-el.a.run.app/send-email") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let parameters: [String: String] = [
            "subject": subject,
            "body": body,
            "recipient": recipient
        ]
        
        request.httpBody = parameters.map { key, value in
            return "\(key)=\(value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")"
        }.joined(separator: "&").data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error sending email: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Error sending email: Invalid response")
                return
            }
            
            print("Email sent successfully")
        }.resume()
    }
}
