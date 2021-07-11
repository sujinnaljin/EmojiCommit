//
//  CommitItemViewModel.swift
//  EmojiCommit
//
//  Created by 강수진 on 2021/05/01.
//

import Foundation

struct CommitItemViewModel {
    private let commit: Commit
    private let theme: Theme = Theme(rawValue: UserDefaults.theme ?? "") ?? .default
    
    init(commit: Commit) {
        self.commit = commit
    }
    
    var imageName: String {
        return theme.images[commit.level.rawValue]
    }
    var date: String {
        return commit.date.day.description
    }
}
