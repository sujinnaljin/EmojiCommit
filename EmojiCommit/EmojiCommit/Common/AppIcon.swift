//
//  AppIcon.swift
//  EmojiCommit
//
//  Created by 강수진 on 2021/07/14.
//

import Foundation

// TODO: - section 별로 나눌 방법 고민
enum AppIcon: String, CaseIterable {
    
    case
        `default`,
        emojiZero,
        emojiOne,
        emojiTwo,
        emojiThree,
        emojiFour
    
    private var firstLetterCapitalizedRawValue: String {
        let rawValue = self.rawValue
        return rawValue.prefix(1).capitalized + rawValue.dropFirst()
    }
    
    var title: String {
        return self.rawValue
    }
    
    // List 에 뿌려줄 이미지 path
    var filePath: String? {
        var fileName = ""
        switch self {
        case .default:
            fileName = self.rawValue
        default:
            fileName = firstLetterCapitalizedRawValue
        }
        fileName += "@2x"
        let fileType = "png"
        return Bundle.main.path(forResource: fileName, ofType: fileType)
    }
    
    // App Icon 변경을 위한 이미지 이름 (App Icons와 info.plist 에 추가된 이름)
    var alternateIconName: String? {
        switch self {
        case .default:
            // If alternateIconName is nil then the default App Icon will be used.
          return nil
        default:
            return firstLetterCapitalizedRawValue
        }
      }
}
