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
    // MARK: Input
    enum Input {
        case onAppear
        case changePage(Int)
    }

    func apply(_ input: Input) {
        switch input {
        case .onAppear:
            onAppearSubject.send()
        case let .changePage(page):
            changePageSubject.send(page)
        }
    }
    
    // MARK: Output
    @Published private(set) var title: String?
    
    // MARK: Subject
    private let changePageSubject = PassthroughSubject<Int, Never>()
    private let onAppearSubject = PassthroughSubject<Void, Never>()
    
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
        
        onAppearSubject
            .map { [weak self] _ in
                self?.getTitle(from: self?.monthBaseDates.last)
            }
            .assign(to: \.title, on: self)
            .store(in: &subscriptions)
        
        changePageSubject
            .sink { [weak self] (page) in
                guard let self = self,
                      page < self.monthBaseDates.count else {
                    return
                }
                self.title = self.getTitle(from: self.monthBaseDates[page])
            }
            .store(in: &subscriptions)
    }
    
    private func getTitle(from monthBaseDate: MonthBaseDate?) -> String? {
        guard let monthBaseDate = monthBaseDate else {
            return nil
        }
        
        return monthBaseDate.year.description
            + "/"
            + monthBaseDate.month.description
            + " 🎢"
    }
    
    func commitFor(year: Int, month: Int) -> [Commit] {
        commits
            .filter { (commit) in
                return commit.date.year == year
                    && commit.date.month == month
            }
    }
}
