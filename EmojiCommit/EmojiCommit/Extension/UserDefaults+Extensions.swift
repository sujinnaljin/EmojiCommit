//
//  UserDefaults+Extensions.swift
//  EmojiCommit
//
//  Created by Kang, Su Jin (강수진) on 2021/05/18.
//

import Foundation

extension UserDefaults {
    enum Key: String {
        case githubId
        case emojiPhases
    }

    @UserDefault(key: .githubId)
    static var githubId: String?
}