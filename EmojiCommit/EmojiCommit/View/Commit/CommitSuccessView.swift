//
//  CommitSuccessView.swift
//  EmojiCommit
//
//  Created by 강수진 on 2021/05/01.
//

import SwiftUI
import ElegantPages

struct CommitSuccessView: View {
    @StateObject private var viewModel: CommitSuccessViewModel
    let pageManager: ElegantPagesManager
    
    init(viewModel: CommitSuccessViewModel,
         pageManager: ElegantPagesManager = ElegantPagesManager(startingPage: 12, pageTurnType: .earlyCutOffDefault)) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.pageManager = pageManager
    }
    
    var body: some View {
        ElegantVPages(manager: pageManager) {
            ForEach(viewModel.monthBaseDates) { date in
                 CommitMonthView(viewModel: .init(commits: viewModel.commitFor(year: date.year,
                                                                               month: date.month)))
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
