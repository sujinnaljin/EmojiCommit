//
//  CommitItemViewModel.swift
//  EmojiCommit
//
//  Created by 강수진 on 2021/05/01.
//

import Foundation

struct CommitItemViewModel {
    private let commit: Commit
    private let theme: Theme
    
    init(commit: Commit,
         theme: Theme = Theme(rawValue: UserDefaults.theme ?? "") ?? .default) {
        self.commit = commit
        self.theme = theme
    }
    
    var emojiImageName: String {
        return commit.level.emojiImageName
    }
    var color: String {
        return theme.colors[commit.level.rawValue]
    }
}
