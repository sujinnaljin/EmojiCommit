//
//  Emoji.swift
//  EmojiCommit
//
//  Created by Kang, Su Jin (강수진) on 2021/04/26.
//

import Foundation

struct EmojiGroup: Identifiable {
    let id = UUID()
    let section: String
    let emojis: [Emoji]
}

struct Emoji: Identifiable {
    let id = UUID()
    let value: String
}