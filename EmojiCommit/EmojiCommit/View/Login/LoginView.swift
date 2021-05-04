//
//  LoginView.swift
//  EmojiCommit
//
//  Created by Kang, Su Jin (강수진) on 2021/03/22.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel: LoginViewModel = .init()
    @EnvironmentObject private var rootViewModel: RootViewModel
    
    var body: some View {
        GeometryReader { geometry in
                VStack {
                    Spacer()
                    TextField(viewModel.idPlaceholder,
                              text: $viewModel.githubId)
                        .font(.title)
                        .padding()
                        .multilineTextAlignment(.center)
                    Spacer()
                    
                    // MARK: - Bottom Next Link
                    BottomNextView(geometry: geometry,
                                   isNextEnabled: viewModel.isNextEnabled)
                        .onTapGesture {
                            self.rootViewModel.viewType = .CommitView
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
