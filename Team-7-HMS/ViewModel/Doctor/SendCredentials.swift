//
//  SendCredentials.swift
//  Team-7-HMS
//
//  Created by Meghs on 22/04/24.
//

import Foundation
import MessageUI
class MailHelper: NSObject, MFMailComposeViewControllerDelegate {
    public static let shared = MailHelper()
    private override init() { }
    func sendEmail(subject: String, body: String, to: String){
        guard MFMailComposeViewController.canSendMail() else {
            print("Cannot send mail")
            return
        }
        let mailComposeViewController = MFMailComposeViewController()
        mailComposeViewController.mailComposeDelegate = self
        mailComposeViewController.setToRecipients([to])
        mailComposeViewController.setSubject(subject)
        mailComposeViewController.setMessageBody(body, isHTML: false)
        MailHelper.getRootViewController()?.present(mailComposeViewController, animated: true, completion: nil)
    }
    static func getRootViewController() -> UIViewController? {
        guard let firstScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return nil
        }
        guard let firstWindow = firstScene.windows.first else {
            return nil
        }
        let viewController = firstWindow.rootViewController
        return viewController
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?)
    {
        switch (result) {
        case .sent:
            print("email sent.")
            break
        case .cancelled:
            print("email cancelled.")
            break
        case .failed:
            print("failed sending email")
            break
        default:
            break
        }
        controller.dismiss(animated: true, completion: nil)
    }
}


import SwiftUI
struct SendCredentials: View {
    @State var mailSubject: String = ""
    @State var mailBody: String = ""
    @State var mailTo: String = ""
    var body: some View {
        VStack(spacing: 20) {
            TextField("mailSubject", text: $mailSubject)
            TextField("mailBody", text: $mailBody)
            TextField("mailTo", text: $mailTo)
            Button {
                MailHelper.shared.sendEmail(
                    subject: mailSubject,
                    body: mailBody,
                    to: mailTo
                )
            }label: {
                Text("Send email")
            }
        }
        .padding()
    }
}



