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
    
    var imageName: String {
        return theme.images[commit.level.rawValue]
    }
}
