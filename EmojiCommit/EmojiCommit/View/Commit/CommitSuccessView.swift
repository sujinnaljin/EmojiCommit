//
//  CommitSuccessView.swift
//  EmojiCommit
//
//  Created by 강수진 on 2021/05/01.
//

import SwiftUI

struct CommitSuccessView: View {
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
    
    private let viewModel: CommitSuccessViewModel
    
    init(viewModel: CommitSuccessViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: columns,
                          spacing: Constants.emojiLineSpacing) {
                    ForEach(viewModel.commits) { commit in
                        CommitItem(viewModel: .init(commit: commit))
                    }
                }
            }
        }
    }
}

struct CommitSuccessView_Previews: PreviewProvider {
    static var previews: some View {
        let dateComponents = DateComponents(year: 2021,
                                            month: 2,
                                            day: 22)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!
        
        CommitSuccessView(viewModel: .init(commits: [Commit(date: date,
                                                            level: .one)]))
    }
}
