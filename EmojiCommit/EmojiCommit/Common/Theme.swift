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
    
    var colors: [String] {
        switch self {
        case .default:
            let colorZero = "EBEDF0"
            let colorOne = "9BE9A8"
            let colorTwo = "41C464"
            let colorThree = "31A14E"
            let colorFour = "216D39"
            return [colorZero, colorOne, colorTwo, colorThree, colorFour]
        case .halloween:
            let colorZero = "EBEDF0"
            let colorOne = "FFEE44"
            let colorTwo = "FBC400"
            let colorThree = "F99715"
            let colorFour = "464646"
            return [colorZero, colorOne, colorTwo, colorThree, colorFour]
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
