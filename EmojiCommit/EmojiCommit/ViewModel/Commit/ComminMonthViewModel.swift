//
//  ComminMonthViewModel.swift
//  EmojiCommit
//
//  Created by Kang, Su Jin (강수진) on 2021/05/03.
//

import Foundation

struct CommitMonthViewModel {
    // MARK: properties
    private(set) var commits: [Commit]
    var emptyCountInFirstWeek: Int {
        get {
            guard let firstCommit = commits.first else {
                return 0
            }
            
            // Sun(1) Mon(2) Tue(3) Wed(4) Thr(5) Fri(6) Sat(7)
            let firstWeekDay = firstCommit.date.weekday
            // 1 => 0, 2 => 1, 3 => 2, ...., 6 => 5, 7 => 6
            let addEmptyCount = firstWeekDay - 1
            return addEmptyCount
        }
    }
    
    // MARK: init
    init(commits: [Commit]) {
        self.commits = commits
    }
}
