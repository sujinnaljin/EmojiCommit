//
//  RootView.swift
//  EmojiCommit
//
//  Created by Kang, Su Jin (강수진) on 2021/05/04.
//

import SwiftUI

struct RootView: View {
    // observing changes of the setting class and switch between your app views
    @ObservedObject var viewModel: RootViewModel
    
    var body: some View {
        Group {
            if viewModel.viewType == .ThemeView {
                RootRouter.themeView(isShowBanner: false)
            } else {
                let githubId = UserDefaults.githubId
                RootRouter.commitView(githubId: githubId)
            }
        }
        .environmentObject(viewModel)
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(viewModel: .init(viewType: .ThemeView))
    }
}
