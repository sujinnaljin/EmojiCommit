//
//  CommitView.swift
//  EmojiCommit
//
//  Created by Kang, Su Jin (강수진) on 2021/04/06.
//

import SwiftUI

struct CommitView: View {
    
    @StateObject var viewModel: CommitViewModel
    
    init(githudId: String) {
        _viewModel = StateObject(wrappedValue: CommitViewModel.init(userId: githudId))
    }
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let commits = viewModel.commits {
                CommitSuccessView(viewModel: .init(commits: commits))
            } else if let error = viewModel.error {
                CommitErrorView(viewModel: .init(error: error))
            }
        }
        .navigationBarTitle(Text("Commits"))
        .onAppear(perform: { self.viewModel.apply(.onAppear) })
    }
}

struct CommitView_Previews: PreviewProvider {
    static var previews: some View {
        CommitView(githudId: "sujinnaljin")
    }
}
