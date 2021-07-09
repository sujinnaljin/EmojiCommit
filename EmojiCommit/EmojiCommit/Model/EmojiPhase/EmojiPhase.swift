//
//  EmojiPhase.swift
//  EmojiCommit
//
//  Created by Kang, Su Jin (강수진) on 2021/04/06.
//

import Foundation

struct EmojiPhase: Codable {
    var phase: Int
    var emoji: String
    
    init(phase: Int, emoji: String) {
        self.phase = phase
        self.emoji = emoji
    }
}
