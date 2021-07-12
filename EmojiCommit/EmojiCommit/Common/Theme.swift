//
//  Theme.swift
//  EmojiCommit
//
//  Created by 강수진 on 2021/07/11.
//

import Foundation

enum Theme: String, CaseIterable {
    case `default`
    case halloween
    
    var title: String {
        switch self {
        case .default:
            return I18N.defaultString
            
        case .halloween:
            return I18N.halloween
        }
    }
    
    var images: [String] {
        switch self {
        case .default:
            let levelZeroImage = "EmojiZero"
            let levelOneImage = "EmojiOne"
            let levelTwoImage = "EmojiTwo"
            let levelThreeImage = "EmojiThree"
            let levelFourImage = "EmojiFour"
            return [levelZeroImage, levelOneImage, levelTwoImage, levelThreeImage, levelFourImage]
        case .halloween:
            let levelZeroImage = "HalloweenZero"
            let levelOneImage = "HalloweenOne"
            let levelTwoImage = "HalloweenTwo"
            let levelThreeImage = "HalloweenThree"
            let levelFourImage = "HalloweenFour"
            return [levelZeroImage, levelOneImage, levelTwoImage, levelThreeImage, levelFourImage]
        }
    }
}

/*
protocol Theme: Hashable {
    var levelZeroImage: String { get }
    var levelOneImage: String { get }
    var levelTwoImage: String { get }
    var levelThreeImage: String { get }
    var levelFourImage: String { get }
    
    

    
}

extension Theme {
    var images: [String] {
        return [
            levelZeroImage,
            levelOneImage,
            levelTwoImage,
            levelThreeImage,
            levelFourImage
        ]
    }
}

struct DefaultTheme: Theme {
    var levelZeroImage = "EmojiZero"
    var levelOneImage = "EmojiOne"
    var levelTwoImage = "EmojiTwo"
    var levelThreeImage = "EmojiThree"
    var levelFourImage = "EmojiFour"
}

struct HalloweenTheme: Theme {
    var levelZeroImage = "EmojiZero"
    var levelOneImage = "EmojiOne"
    var levelTwoImage = "EmojiTwo"
    var levelThreeImage = "EmojiThree"
    var levelFourImage = "EmojiFour"
}

 */
