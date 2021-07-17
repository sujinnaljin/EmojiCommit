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
                            .onTapGesture {
                                self.viewModel.apply(.fetchCommits(viewModel.githubId))
                            }
                    case let .failure(error):
                        CommitErrorView(viewModel: .init(error: error))
                            .onTapGesture {
                                self.viewModel.apply(.fetchCommits(viewModel.githubId))
                            }
                    }
                }
            }
            .toolbar {
                //세팅
                // 세팅
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu(content: {
                        Button(viewModel.changeIdTitle) {
                            viewModel.apply(.showingSheet(.login))
                        }
                        
                        Button(viewModel.changeThemeTitle) {
                            viewModel.apply(.showingSheet(.theme))
                        }
                        
                        Button(viewModel.changeAppIconTitle) {
                            viewModel.apply(.showingSheet(.appIcon))
                        }
                    }, label: {
                        Image(systemName: viewModel.settingSystemImageName)
                    })
                }
            }
            .sheet(isPresented: $viewModel.isShowingSheet) {
                if let selectedSheet = viewModel.selectedSheet {
                    CommitSheetView(viewType: selectedSheet)
                        .environmentObject(viewModel)
                }
            }
        }
        .accentColor(.greenGradeThree)
        .onAppear(perform: { self.viewModel.apply(.fetchCommits(viewModel.githubId)) })
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct CommitView_Previews: PreviewProvider {
    static var previews: some View {
        CommitView(githudId: "sujinnaljin")
    }
}
