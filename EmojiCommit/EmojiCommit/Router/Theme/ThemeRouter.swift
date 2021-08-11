//
//  ThemeRouter.swift
//  EmojiCommit
//
//  Created by 강수진 on 2021/08/11.
//

import SwiftUI

final class ThemeRouter {
    public static func loginView(isShowBanner: Bool) -> some View {
        return LoginView(isShowBanner: isShowBanner)
    }
}
