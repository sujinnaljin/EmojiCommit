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
        static let columnCount = 7
        static let emojiSpacing: CGFloat = 5
        static let emojiLineSpacing: CGFloat = 10
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
            ForEach(viewModel.commits) { commit in
                    CommitItem(viewModel: .init(commit: commit))
                // UI  참고 https://iosexample.com/an-efficient-and-customizable-full-screen-calendar-written-in-swiftui/
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
