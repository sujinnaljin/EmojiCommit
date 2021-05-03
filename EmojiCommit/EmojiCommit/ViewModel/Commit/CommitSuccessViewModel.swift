//
//  CommitSuccessViewModel.swift
//  EmojiCommit
//
//  Created by 강수진 on 2021/05/01.
//

import Foundation
import Combine

class CommitSuccessViewModel: ObservableObject {
    struct MonthBaseDate: Identifiable, Equatable {
        let id = UUID()
        let year: Int
        let month: Int
        
        public static func ==(lhs: MonthBaseDate, rhs: MonthBaseDate) -> Bool {
            lhs.year == rhs.year && lhs.month == rhs.month
        }
    }
    
    // MARK: properties
    private let commits: [Commit]
    private(set) var monthBaseDates: [MonthBaseDate] = []
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: init
    init(commits: [Commit]) {
        self.commits = commits
        configure()
    }
    
    // MARK: func
    private func configure() {
        commits
            .publisher
            .map { (commit) in
                MonthBaseDate(year: commit.date.year, month: commit.date.month)
            }
            .removeDuplicates()
            .collect()
            .assign(to: \.monthBaseDates, on: self)
            .store(in: &subscriptions)
    }
    
    func commitFor(year: Int, month: Int) -> [Commit] {
        commits
            .filter { (commit) in
                return commit.date.year == year
                    && commit.date.month == month
            }
    }
}
