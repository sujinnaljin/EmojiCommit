//
//  EmojiCommitApp.swift
//  EmojiCommit
//
//  Created by 강수진 on 2021/08/21.
//

import SwiftUI

@main
struct EmojiCommitApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var githubId = UserDefaults.githubId
    
    var body: some Scene {
        let rootViewType: RootViewType = githubId.isNil ?
            .ThemeView : .CommitView
        
        WindowGroup {
            RootView(viewModel: .init(viewType: rootViewType))
        }
    }
}
