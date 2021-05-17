//
//  CommitItemViewModel.swift
//  EmojiCommit
//
//  Created by 강수진 on 2021/05/01.
//

import Foundation

struct CommitItemViewModel {
    @PublishedEmojiPhase(wrappedValue: []) private var emojiPhases: [EmojiPhase]
    private let commit: Commit
    
    init(commit: Commit) {
        self.commit = commit
    }
    
    var emoji: String {
        return emojiPhases[commit.level.rawValue].emoji
    }
    var date: String {
        return commit.date.day.description
    }
}
