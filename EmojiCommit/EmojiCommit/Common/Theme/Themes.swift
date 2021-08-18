//
//  Themes.swift
//  EmojiCommit
//
//  Created by 강수진 on 2021/07/18.
//

import Foundation

struct DefaultTheme: Themeable {
    var title: String = I18N.defaultString
    
    var colorZero  = "EBEDF0"
    let colorOne   = "9BE9A8"
    let colorTwo   = "41C464"
    let colorThree = "31A14E"
    let colorFour  = "216D39"
}

struct HalloweenTheme: Themeable {
    var title: String = I18N.halloween
    
    let colorZero  = "EBEDF0"
    let colorOne   = "FFEE44"
    let colorTwo   = "FBC400"
    let colorThree = "F99715"
    let colorFour  = "464646"
}

struct GrayTheme: Themeable {
    var title: String = "Gray"
    
    let colorZero  = "E9ECEF"
    let colorOne   = "DEE2E6"
    let colorTwo   = "CED4DA"
    let colorThree = "ADB5BD"
    let colorFour  = "868E96"
}

struct RedTheme: Themeable {
    var title: String = "Red"
    
    let colorZero  = "FFE3E3"
    let colorOne   = "FFC9C9"
    let colorTwo   = "FFA8A8"
    let colorThree = "FF8787"
    let colorFour  = "FF6B6B"
}

struct PinkTheme: Themeable {
    var title: String = "Pink"
    
    let colorZero  = "FFDEEB"
    let colorOne   = "FCC2D7"
    let colorTwo   = "FAA2C1"
    let colorThree = "F783AC"
    let colorFour  = "F06595"
}

struct GrapeTheme: Themeable {
    var title: String = "Grape"
    
    let colorZero  = "F3D9FA"
    let colorOne   = "EEBEFA"
    let colorTwo   = "E599F7"
    let colorThree = "DA77F2"
    let colorFour  = "CC5DE8"
}

struct VioletTheme: Themeable {
    var title: String = "Violet"
    
    let colorZero  = "E5DBFF"
    let colorOne   = "D0BFFF"
    let colorTwo   = "B197FC"
    let colorThree = "9775FA"
    let colorFour  = "845EF7"
}

struct IndigoTheme: Themeable {
    var title: String = "Indigo"
    
    let colorZero  = "DBE4FF"
    let colorOne   = "BAC8FF"
    let colorTwo   = "91A7FF"
    let colorThree = "748FFC"
    let colorFour  = "5C7CFA"
}

struct BlueTheme: Themeable {
    var title: String = "Blue"
    
    let colorZero  = "D0EBFF"
    let colorOne   = "A5D8FF"
    let colorTwo   = "74C0FC"
    let colorThree = "4DABF7"
    let colorFour  = "339AF0"
}

struct CyanTheme: Themeable {
    var title: String = "Cyan"
    
    let colorZero  = "C5F6FA"
    let colorOne   = "99E9F2"
    let colorTwo   = "66D9E8"
    let colorThree = "3BC9DB"
    let colorFour  = "22B8CF"
}

struct TealTheme: Themeable {
    var title: String = "Teal"
    
    let colorZero  = "C3FAE8"
    let colorOne   = "96F2D7"
    let colorTwo   = "63E6BE"
    let colorThree = "38D9A9"
    let colorFour  = "20C997"
}

struct GreenTheme: Themeable {
    var title: String = "Green"
    
    let colorZero  = "D3F9D8"
    let colorOne   = "B2F2BB"
    let colorTwo   = "8CE99A"
    let colorThree = "69DB7C"
    let colorFour  = "51CF66"
}

struct LimeTheme: Themeable {
    var title: String = "Lime"
    
    let colorZero  = "E9FAC8"
    let colorOne   = "D8F5A2"
    let colorTwo   = "C0EB75"
    let colorThree = "A9E34B"
    let colorFour  = "94D82D"
}

struct YellowTheme: Themeable {
    var title: String = "Yellow"
    
    let colorZero  = "FFF3BF"
    let colorOne   = "FFEC99"
    let colorTwo   = "FFE066"
    let colorThree = "FFD43B"
    let colorFour  = "FCC419"
}

struct OrangeTheme: Themeable {
    var title: String = "Orange"
    
    let colorZero  = "FFE8CC"
    let colorOne   = "FFD8A8"
    let colorTwo   = "FFC078"
    let colorThree = "FFA94D"
    let colorFour  = "FF922B"
}
