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
        _viewModel = StateObject(wrappedValue: CommitViewModel.init(githubId: githudId))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                } else if let result = viewModel.result {
                    switch result {
                    case let .success(commits):
                        CommitSuccessView(viewModel: .init(commits: commits))
                    case let .failure(error):
                        CommitErrorView(viewModel: .init(error: error))
                    }
                }
            }
            .navigationTitle(viewModel.title)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("👩🏻‍💻ID") {
                        viewModel.apply(.showingSheet(.login))
                    }
                    Button("😎Emoji") {
                        viewModel.apply(.showingSheet(.emoji))
                    }
                }
            }
            .sheet(isPresented: $viewModel.isShowingSheet) {
                if let selectedSheet = viewModel.selectedSheet {
                    CommitSheetView(viewType: selectedSheet)
                        .environmentObject(viewModel)
                }
            }
        }
        .onAppear(perform: { self.viewModel.apply(.fetchCommits(viewModel.githubId)) })
    }
}

struct CommitSheetView: View {
    // observing changes of the setting class and switch between your app views
    @EnvironmentObject var viewModel: CommitViewModel
    @Environment(\.presentationMode) var presentationMode
    var viewType: CommitViewModel.SheetType
    
    var body: some View {
        Group {
            if viewType == .emoji {
                EmojiPhaseView(viewModel: .init())
            } else {
                LoginView(viewModel: .init(didTouchNextButton: { githubId in
                    presentationMode.wrappedValue.dismiss()
                    viewModel.apply(.fetchCommits(githubId))
                }))
            }
        }
    }
}

struct CommitView_Previews: PreviewProvider {
    static var previews: some View {
        CommitView(githudId: "sujinnaljin")
    }
}
