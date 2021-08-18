//
//  UserDefaults+Extensions.swift
//  EmojiCommit
//
//  Created by Kang, Su Jin (강수진) on 2021/05/18.
//

import Foundation

extension UserDefaults {
    enum Key: String {
        case githubId
        case themeType
    }
    
    static let shared: UserDefaults = {
        let appGroupId = "group.com.sujinnaljin.EmojiCommitt"
        return UserDefaults(suiteName: appGroupId)!
    }()

    @UserDefault(key: .githubId)
    static var githubId: String?
    
    @UserDefault(key: .themeType)
    static var themeType: String?
    
    func removeAll() {
        let defaults = UserDefaults.shared
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
}
