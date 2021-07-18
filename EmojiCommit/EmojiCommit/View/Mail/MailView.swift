//
//  MailView.swift
//  EmojiCommit
//
//  Created by 강수진 on 2021/07/19.
//

import MessageUI
import SwiftUI
import UIKit

//https://stackoverflow.com/questions/56784722/swiftui-send-email
struct MailView: UIViewControllerRepresentable {
    
    enum Constants {
        private static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        private static let osVersion = UIDevice.current.systemVersion
        static let defaultMessageBody = "앱 버전: \(Constants.appVersion) \n iOS 버전: \(Constants.osVersion)"
        static let subject = "EmojiCommit 문의"
        static let recipients = ["rkdthd1234@naver.com"]
    }
    @Environment(\.presentationMode) var presentation
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        @Binding var presentation: PresentationMode

        init(presentation: Binding<PresentationMode>) {
            _presentation = presentation
        }

        func mailComposeController(_: MFMailComposeViewController,
                                   didFinishWith result: MFMailComposeResult,
                                   error: Error?) {
            $presentation.wrappedValue.dismiss()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(presentation: presentation)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.setSubject(Constants.subject)
        vc.setToRecipients(Constants.recipients)
        vc.setMessageBody(Constants.defaultMessageBody, isHTML: true)
        vc.mailComposeDelegate = context.coordinator
        return vc
    }

    func updateUIViewController(_: MFMailComposeViewController,
                                context _: UIViewControllerRepresentableContext<MailView>) {}
}
