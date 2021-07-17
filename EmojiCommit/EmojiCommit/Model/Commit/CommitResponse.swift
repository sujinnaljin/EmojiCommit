//
//  CommitResponse.swift
//  EmojiCommit
//
//  Created by Kang, Su Jin (강수진) on 2021/04/08.
//

import Foundation

struct CommitResponse: Codable {
    let commits: [Commit]
}

struct Commit: Codable, Identifiable {
    
    var id = UUID()
    var date: Date
    var level: Level

    enum Level: Int, Codable {
        case zero, one, two, three, four
        
        var emojiImageName: String {
            switch self {
            case .zero:
                return "Emoji0"
            case .one:
                return "Emoji1"
            case .two:
                return "Emoji2"
            case .three:
                return "Emoji3"
            case .four:
                return "Emoji4"
            }
        }
    }
    
    init(date: Date, level: Level) {
        self.date = date
        self.level = level
    }
}
