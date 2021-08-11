//
//  LoginView.swift
//  EmojiCommit
//
//  Created by Kang, Su Jin (강수진) on 2021/03/22.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var viewModel: LoginViewModel
    @EnvironmentObject private var rootViewModel: RootViewModel
    
    init(isShowBanner: Bool,
         didTouchNextButton: ((String) -> Void)? = nil) {
        _viewModel = StateObject(wrappedValue: LoginViewModel(isShowBanner: isShowBanner,
                                                              didTouchNextButton: didTouchNextButton))
    }
    
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
                    
                    // MARK: - AdBanner
                    if viewModel.isShowBanner {
                        AdBanner()
                    }
                    
                    // MARK: - Bottom Next Link
                    BottomNextView(geometry: geometry,
                                   isNextEnabled: viewModel.isNextEnabled)
                        .onTapGesture {
                            self.viewModel.apply(.next(viewModel.githubId))
                            self.rootViewModel.viewType = .CommitView // Change Root View
                        }
                        .disabled(!viewModel.isNextEnabled)
                }
                .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isShowBanner: false)
    }
}
