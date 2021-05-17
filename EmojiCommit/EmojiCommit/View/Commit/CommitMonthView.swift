//
//  CommitMonthView.swift
//  EmojiCommit
//
//  Created by Kang, Su Jin (강수진) on 2021/05/03.
//

import SwiftUI

struct CommitMonthView: View {
    // todo grid 형태 viewModifier 로 재정의해야할거같다. emojilist 랑 겹쳐서
    private enum Constants {
        static let columnCount = WeekDay.allCases.count
        static let emojiSpacing: CGFloat = 5
        static let emojiLineSpacing: CGFloat = 25
        static let emojiWidth: CGFloat = (UIScreen.screenWidth - CGFloat(columnCount)*emojiSpacing) / CGFloat(columnCount)
    }
    
    // MARK: - Grid 형태 정의
    private var columns: [GridItem] {
        let grids = (0..<Constants.columnCount).map { (_) in
            GridItem(.fixed(Constants.emojiWidth), spacing: Constants.emojiSpacing)
        }
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
                Text(weekday.rawValue)
                    .font(Font.body.weight(.semibold))
            }
            ForEach(0..<viewModel.emptyCountInFirstWeek, id: \.self) { _ in
                Rectangle()
                    .fill(Color.white)
            }
            ForEach(viewModel.commits) { commit in
                CommitItem(viewModel: .init(commit: commit))
            }
        }
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
