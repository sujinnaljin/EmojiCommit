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
                             <----Required----> </br>
                             App Version: \(AppMetaData.appVersion as? String ?? "") </br>
                             iOS Version: \(AppMetaData.iOSVersion) </br>
                             Device Type: \(AppMetaData.deviceType) </br>
                             </br>
                             <----Optional----> </br>
                             Github ID: \(UserDefaults.githubId ?? "미설정") </br>
                             </br>
                             <----Write message below 🕺🏻----> </br>
                             """
    let subject = "[EmojiCommit]"
    let recipients = ["rkdthd1234@naver.com"]
}
