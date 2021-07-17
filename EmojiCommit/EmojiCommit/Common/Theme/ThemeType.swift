//
//  ThemeType.swift
//  EmojiCommit
//
//  Created by 강수진 on 2021/07/18.
//

import Foundation

enum ThemeType: String, CaseIterable {
    case `default`
    case halloween

    var theme: Themeable {
        switch self {
        case .default:
            return DefaultTheme()
        case .halloween:
            return HalloweenTheme()
        }
    }
}
