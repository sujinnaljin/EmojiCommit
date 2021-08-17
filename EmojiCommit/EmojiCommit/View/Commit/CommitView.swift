//
//  CommitView.swift
//  EmojiCommit
//
//  Created by Kang, Su Jin (강수진) on 2021/04/06.
//

import SwiftUI
struct CommitView: View {
    
    @StateObject private var viewModel: CommitViewModel
    
    init(githudId: String) {
        _viewModel = StateObject(wrappedValue: CommitViewModel.init(githubId: githudId))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                } else if let viewType = viewModel.viewType {
                    switch viewType {
                    case let .success(commits):
                        CommitSuccessView(viewModel: .init(commits: commits))
                    case let .failure(error):
                        CommitErrorView(viewModel: .init(error: error))
                    }
                }
            }
            .toolbar {
                // 새로 고침
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.apply(.fetchCommits(viewModel.githubId))
                    }, label: {
                        Image(systemName: viewModel.refreshSystemImageName)
                    })
                }
                
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
                        
                        Button(viewModel.sendMail) {
                            viewModel.apply(.showingSheet(.mail))
                        }
                    }, label: {
                        Image(systemName: viewModel.settingSystemImageName)
                            .imageScale(.large)
                    })
                }
            }
            .sheet(isPresented: $viewModel.isShowingSheet) {
                if let selectedSheet = viewModel.selectedSheet {
                    CommitRouter.sheetView(type: selectedSheet,
                                           commitViewModel: viewModel)
                }
            }
            .alert(isPresented: $viewModel.isShowingAlert, content: { () -> Alert in
                Alert(title: Text(viewModel.alertMessage))
            })
        }
        .onAppear(perform: { viewModel.apply(.fetchCommits(viewModel.githubId)) })
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct CommitView_Previews: PreviewProvider {
    static var previews: some View {
        CommitView(githudId: "sujinnaljin")
    }
}
