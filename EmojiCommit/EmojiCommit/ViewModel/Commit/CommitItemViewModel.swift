//
//  CommitItemViewModel.swift
//  EmojiCommit
//
//  Created by 강수진 on 2021/05/01.
//

import Foundation

struct CommitItemViewModel {
    private let commit: Commit
    private let themeType: ThemeType
    
    init(commit: Commit,
         themeType: ThemeType = ThemeType(rawValue: UserDefaults.themeType ?? "") ?? .default) {
        self.commit = commit
        self.themeType = themeType
    }
    
    var emojiImageName: String {
        return commit.level.emojiImageName
    }
    var color: String {
        return themeType.theme[commit.level.rawValue]
    }
}
