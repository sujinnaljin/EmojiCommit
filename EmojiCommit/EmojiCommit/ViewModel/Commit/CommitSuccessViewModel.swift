//
//  CommitSuccessViewModel.swift
//  EmojiCommit
//
//  Created by 강수진 on 2021/05/01.
//

import Foundation

class CommitSuccessViewModel {
    let commits: [Commit]
    @PublishedEmojiPhase(wrappedValue: []) private(set) var emojiPhases: [EmojiPhase]
    
    init(commits: [Commit]) {
        self.commits = commits
    }
}
