//
//  WidgetCommitItemViewModel.swift
//  EmojiCommit
//
//  Created by 강수진 on 2021/07/11.
//

import Foundation

struct WidgetCommitItemViewModel {
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
    
    var weekDay: String {
        return WeekDay.allCases.first(where: { weekDay in
            weekDay.rawValue == commit.date.weekday
        })?.title ?? ""
    }
}
