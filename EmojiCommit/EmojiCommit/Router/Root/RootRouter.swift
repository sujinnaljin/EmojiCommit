//
//  RootRouter.swift
//  EmojiCommit
//
//  Created by 강수진 on 2021/08/11.
//

import SwiftUI

final class RootRouter {
    public static func commitView(githubId: String?) -> some View {
        return CommitView(githudId: githubId ?? "")
    }
    
    public static func themeView(isShowBanner: Bool) -> some View {
        return ThemeView(isShowBanner: isShowBanner)
    }
}
