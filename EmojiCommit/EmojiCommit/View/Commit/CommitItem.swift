//
//  CommitItem.swift
//  EmojiCommit
//
//  Created by 강수진 on 2021/05/01.
//

import SwiftUI

struct CommitItem: View {
    private let viewModel: CommitItemViewModel
    
    init(viewModel: CommitItemViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Text(viewModel.emoji)
                .font(.system(.largeTitle))
            Text(viewModel.date)
                .font(.system(.body))
        }
    }
}

struct CommitItem_Previews: PreviewProvider {
    
    static var previews: some View {
        let dateComponents = DateComponents(year: 2021,
                                            month: 2,
                                            day: 22)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!
        
        CommitItem(viewModel: .init(commit: Commit(date: date,
                                                   level: .one)))
    }
}
