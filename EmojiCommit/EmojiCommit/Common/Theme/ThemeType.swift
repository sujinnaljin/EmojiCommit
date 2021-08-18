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
    case gray
    case red
    case pink
    case grape
    case violet
    case indigo
    case blue
    case cyan
    case teal
    case green
    case lime
    case yellow
    case orange

    var theme: Themeable {
        switch self {
        case .default:
            return DefaultTheme()
        case .halloween:
            return HalloweenTheme()
        case .gray:
            return GrayTheme()
        case .red:
            return RedTheme()
        case .pink:
            return PinkTheme()
        case .grape:
            return  GrapeTheme()
        case .violet:
            return VioletTheme()
        case .indigo:
            return IndigoTheme()
        case .blue:
            return BlueTheme()
        case .cyan:
            return CyanTheme()
        case .teal:
            return TealTheme()
        case .green:
            return GreenTheme()
        case .lime:
            return LimeTheme()
        case .yellow:
            return YellowTheme()
        case .orange:
            return OrangeTheme()
        }
    }
}
