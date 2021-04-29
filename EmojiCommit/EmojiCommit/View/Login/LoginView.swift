//
//  LoginView.swift
//  EmojiCommit
//
//  Created by Kang, Su Jin (강수진) on 2021/03/22.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel: LoginViewModel = .init()
    
    var body: some View {
        GeometryReader { geometry in
                VStack {
                    Spacer()
                    TextField(viewModel.idPlaceholder,
                              text: $viewModel.githubId)
                        .padding()
                        .multilineTextAlignment(.center)
                    Spacer()
                    
                    // MARK: - Bottom Next Link
                    // todo 네비게이션이 아니라 root 뷰를 바꿔야함
                    NavigationLink(destination: CommitView(githudId: viewModel.githubId)) {
                        BottomNextView(geometry: geometry,
                                       isNextEnabled: viewModel.isNextEnabled)
                            .navigationTitle(viewModel.title)
                    }
                    .disabled(viewModel.isButtonDisabled)
                }
                .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
