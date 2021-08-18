//
//  Themeable.swift
//  EmojiCommit
//
//  Created by 강수진 on 2021/07/18.
//

import Foundation

protocol Themeable {
    var title: String { get }
    
    var colorZero: String { get }
    var colorOne: String { get }
    var colorTwo: String { get }
    var colorThree: String { get }
    var colorFour: String { get }
    
    subscript(index: Int) -> String { get }
}

extension Themeable {
    var count: Int {
        return [colorZero, colorOne, colorTwo, colorThree, colorFour].count
    }
    
    subscript(index: Int) -> String {
        switch index {
        case 0:
            return colorZero
        case 1:
            return colorOne
        case 2:
            return colorTwo
        case 3:
            return colorThree
        case 4:
            return colorFour
        default:
            return colorZero
        }
    }
}
