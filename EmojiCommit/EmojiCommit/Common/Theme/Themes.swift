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

//https://yeun.github.io/open-color/ingredients.html
struct GrayTheme: Themeable {
    var title: String = "Gray"
    
    let colorZero  = "FAFCFE"
    let colorOne   = "E9ECEF" // level 2
    let colorTwo   = "CED4DA" // level 4
    let colorThree = "868E96" // level 6
    let colorFour  = "343A40" // level 8
}

struct RedTheme: Themeable {
    var title: String = "Red"
    
    let colorZero  = "EBEDF0"
    let colorOne   = "FFE3E3" // level 1
    let colorTwo   = "FFA8A8" // level 3
    let colorThree = "FF6B6B" // level 5
    let colorFour  = "F03232" // level 7
}

struct PinkTheme: Themeable {
    var title: String = "Pink"
    
    let colorZero  = "EBEDF0"
    let colorOne   = "FFDEEB" // level 1`
    let colorTwo   = "FAA2C1" // level 3
    let colorThree = "F06595" // level 5
    let colorFour  = "D6336C" // level 7
}

struct GrapeTheme: Themeable {
    var title: String = "Grape"
    
    let colorZero  = "EBEDF0"
    let colorOne   = "F3D9FA" // level 1
    let colorTwo   = "E599F7" // level 3
    let colorThree = "CC5DE8" // level 5
    let colorFour  = "AE3EC9" // level 7
}

struct VioletTheme: Themeable {
    var title: String = "Violet"
    
    let colorZero  = "EBEDF0"
    let colorOne   = "E5DBFF" // level 1
    let colorTwo   = "B197FC" // level 3
    let colorThree = "845EF7" // level 5
    let colorFour  = "5F3DC4" // level 9
}

struct IndigoTheme: Themeable {
    var title: String = "Indigo"
    
    let colorZero  = "EBEDF0"
    let colorOne   = "DBE4FF" // level 1
    let colorTwo   = "91A7FF" // level 3
    let colorThree = "5C7CFA" // level 5
    let colorFour  = "364FC7" // level 9
}

struct BlueTheme: Themeable {
    var title: String = "Blue"
    
    let colorZero  = "EBEDF0"
    let colorOne   = "D0EBFF" // level 1
    let colorTwo   = "74C0FC" // level 3
    let colorThree = "339AF0" // level 5
    let colorFour  = "1C7ED6" // level 7
}

struct CyanTheme: Themeable {
    var title: String = "Cyan"
    
    let colorZero  = "EBEDF0"
    let colorOne   = "C5F6FA" // level 1
    let colorTwo   = "66D9E8" // level 3
    let colorThree = "22B8CF" // level 5
    let colorFour  = "1098AD" // level 7
}

struct TealTheme: Themeable {
    var title: String = "Teal"
    
    let colorZero  = "EBEDF0"
    let colorOne   = "C3FAE8" // level 1
    let colorTwo   = "63E6BE" // level 3
    let colorThree = "20C997" // level 5
    let colorFour  = "099268" // level 8
}

struct GreenTheme: Themeable {
    var title: String = "Green"
    
    let colorZero  = "EBEDF0"
    let colorOne   = "D3F9D8" // level 1
    let colorTwo   = "8CE99A" // level 3
    let colorThree = "51CF66" // level 5
    let colorFour  = "2F9E44" // level 8
}

struct LimeTheme: Themeable {
    var title: String = "Lime"
    
    let colorZero  = "EBEDF0"
    let colorOne   = "E9FAC8" // level 1
    let colorTwo   = "C0EB75" // level 3
    let colorThree = "94D82D" // level 5
    let colorFour  = "74B816" // level 7
}

struct YellowTheme: Themeable {
    var title: String = "Yellow"
    
    let colorZero  = "EBEDF0"
    let colorOne   = "FFF3BF" // level 1
    let colorTwo   = "FFE066" // level 3
    let colorThree = "FCC419" // level 5
    let colorFour  = "F59F00" // level 7
}

struct OrangeTheme: Themeable {
    var title: String = "Orange"
    
    let colorZero  = "EBEDF0"
    let colorOne   = "FFE8CC" // level 1
    let colorTwo   = "FFC078" // level 3
    let colorThree = "FF922B" // level 5
    let colorFour  = "F76707" // level 7
}

// https://www.webdesignrankings.com/resources/lolcolors/
struct CandyTheme: Themeable {
    var title: String = "Candy"
    
    let colorZero  = "EBEDF0"
    let colorOne   = "FBFFB9"
    let colorTwo   = "FDD692"
    let colorThree = "EC7357"
    let colorFour  = "754F44"
}

 struct WetForestTheme: Themeable {
    var title: String = "Wet forest"
    
    let colorZero  = "EBEDF0"
    let colorOne   = "C5E99B"
    let colorTwo   = "8FBC94"
    let colorThree = "548687"
    let colorFour  = "56445D"
 }

struct DarkForestTheme: Themeable {
    var title: String = "Dark forest"
    
    let colorZero  = "EBEDF0"
    let colorOne   = "5CAB7D"
    let colorTwo   = "5A9367"
    let colorThree = "44633F"
    let colorFour  = "3F4B3B"
}

struct RainTheme: Themeable {
    var title: String = "Rain"
    
    let colorZero  = "EBEDF0"
    let colorOne   = "D8E6E7"
    let colorTwo   = "9DC3C1"
    let colorThree = "77AAAD"
    let colorFour  = "1F4E5F"
}

struct BrightForestTheme: Themeable {
    var title: String = "Bright forest"
    
    let colorZero  = "EBEDF0"
    let colorOne   = "CFF09E"
    let colorTwo   = "A8DBA8"
    let colorThree = "79BD9A"
    let colorFour  = "3B8686"
}

struct PinkPastelTheme: Themeable {
    var title: String = "Pink pastel"
    
    let colorZero  = "EBEDF0"
    let colorOne   = "F8ECC9"
    let colorTwo   = "F1BBBA"
    let colorThree = "EB9F9F"
    let colorFour  = "A79C8E"
}

// https://paletton.com/#uid=13i0u0kllllaFw0g0qFqFg0w0aF
