//
//  MailViewModel.swift
//  EmojiCommit
//
//  Created by 강수진 on 2021/07/20.
//

import UIKit
import Combine

class MailViewModel: ObservableObject {
    let defaultMessageBody = """
앱 버전: \(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "") \n
iOS 버전: \(UIDevice.current.systemVersion)
"""
    let subject = "EmojiCommit 문의"
    let recipients = ["rkdthd1234@naver.com"]
}
