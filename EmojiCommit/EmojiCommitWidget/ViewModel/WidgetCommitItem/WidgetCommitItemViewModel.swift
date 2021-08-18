//
//  WidgetCommitItemViewModel.swift
//  EmojiCommit
//
//  Created by 강수진 on 2021/07/11.
//

import Foundation

struct WidgetCommitItemViewModel {
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
    
    var weekDay: String {
        return WeekDay.allCases.first(where: { weekDay in
            weekDay.rawValue == commit.date.weekday
        })?.title ?? ""
    }
}
