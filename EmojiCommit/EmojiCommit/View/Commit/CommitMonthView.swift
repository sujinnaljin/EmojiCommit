//
//  CommitMonthView.swift
//  EmojiCommit
//
//  Created by Kang, Su Jin (강수진) on 2021/05/03.
//

import SwiftUI

struct CommitMonthView: View {
    private enum Constants {
        static let columnCount = WeekDay.allCases.count
        static let emojiSpacing: CGFloat = 5
        static let emojiLineSpacing: CGFloat = 25
    }
    
    // MARK: - Grid 형태 정의
    private var columns: [GridItem] {
        let grids: [GridItem] = Array(repeating: GridItem(.flexible(),
                                                          spacing: Constants.emojiSpacing),
                                      count: Constants.columnCount)
        return grids
    }
    
    private let viewModel: CommitMonthViewModel
    
    init(viewModel: CommitMonthViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        LazyVGrid(columns: columns,
                  spacing: Constants.emojiLineSpacing) {
            ForEach(WeekDay.allCases, id: \.self) { weekday in
                Text(weekday.title)
                    .font(Font.body.weight(.semibold))
            }
            ForEach(0..<viewModel.emptyCountInFirstWeek, id: \.self) { _ in
                Rectangle()
                    .fill(Color.clear)
            }
            ForEach(viewModel.commits) { commit in
                CommitItem(viewModel: .init(commit: commit))
            }
        }
        .padding(.horizontal, 8)
    }
}

struct CommitMonthView_Previews: PreviewProvider {
    static var previews: some View {
        let dateComponents = DateComponents(year: 2021,
                                            month: 2,
                                            day: 22)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!
        
        CommitMonthView(viewModel: .init(commits: [Commit(date: date,
                                                          level: .one)]))
    }
}
