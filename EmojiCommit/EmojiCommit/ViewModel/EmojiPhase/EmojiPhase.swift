//
//  EmojiPhase.swift
//  EmojiCommit
//
//  Created by Kang, Su Jin (강수진) on 2021/04/06.
//

import Foundation

struct EmojiPhase: Codable {
    var phase: Int = 0 //todo phase 없어도 될거같은데?
    var emoji: String
    
    init(phase: Int, emoji: String) {
        self.phase = phase
        self.emoji = emoji
    }
}
