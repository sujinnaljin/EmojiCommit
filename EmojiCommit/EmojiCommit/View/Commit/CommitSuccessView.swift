//
//  CommitSuccessView.swift
//  EmojiCommit
//
//  Created by 강수진 on 2021/05/01.
//

import SwiftUI
import SwiftUIPager

struct CommitSuccessView: View {
    @StateObject private var viewModel: CommitSuccessViewModel
    
    init(viewModel: CommitSuccessViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Pager(page: viewModel.currentPage,
              data: viewModel.pageData,
              id: \.self) {
                self.pageView($0)
        }
        .vertical()
        .onPageChanged { (page) in
            viewModel.apply(.changePage(page))
        }
        .navigationTitle(viewModel.title ?? "")
        .onAppear {
            viewModel.apply(.onAppear)
        }
    }
    
    private func pageView(_ page: Int) -> some View {
        let date = viewModel.monthBaseDates[page]
        return CommitMonthView(viewModel: .init(commits: viewModel.commitFor(year: date.year,
                                                                             month: date.month))
        )
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
