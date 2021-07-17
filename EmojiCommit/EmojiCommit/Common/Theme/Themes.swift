//
//  Themes.swift
//  EmojiCommit
//
//  Created by 강수진 on 2021/07/18.
//

import Foundation

struct DefaultTheme: Themeable {
    var title: String = I18N.defaultString
    
    var colorZero = "EBEDF0"
    let colorOne = "9BE9A8"
    let colorTwo = "41C464"
    let colorThree = "31A14E"
    let colorFour = "216D39"
}

struct HalloweenTheme: Themeable {
    var title: String = I18N.halloween
    
    let colorZero = "EBEDF0"
    let colorOne = "FFEE44"
    let colorTwo = "FBC400"
    let colorThree = "F99715"
    let colorFour = "464646"
}
 
