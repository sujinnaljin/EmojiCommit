//
//  CommitSheetView.swift
//  EmojiCommit
//
//  Created by 강수진 on 2021/05/05.
//

import SwiftUI
import StoreKit

struct CommitSheetView: View {
    @EnvironmentObject var viewModel: CommitViewModel
    @Environment(\.presentationMode) var presentationMode
    var viewType: CommitViewModel.SheetType
    
    var body: some View {
        Group {
            switch viewType {
            case .theme:
                ThemeView(isShowBanner: true,
                          didTouchNextButton: {
                            presentationMode.wrappedValue.dismiss()
                            SKStoreReviewController.requestReviewInCurrentScene()
                          })
                
            case .login:
                LoginView(isShowBanner: true,
                          didTouchNextButton: { githubId in
                            presentationMode.wrappedValue.dismiss()
                            viewModel.apply(.fetchCommits(githubId))
                          })
                
            case .appIcon:
                AppIconView(viewModel: .init(didTouchNextButton: {
                    presentationMode.wrappedValue.dismiss()
                }))
                
            case .mail:
                MailView(viewModel: .init())
            }
        }
    }
}

struct CommitSheetView_Previews: PreviewProvider {
    static var previews: some View {
        CommitSheetView(viewType: .login)
    }
}
