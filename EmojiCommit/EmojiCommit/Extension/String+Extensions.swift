//
//  String+Extensions.swift
//  EmojiCommit
//
//  Created by Kang, Su Jin (강수진) on 2021/04/10.
//

import Foundation

extension String {
    func toDate() -> Date? {
        let dateFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateFormatter.timeZone = TimeZone(identifier: "UTC")
            return dateFormatter
        }()
        
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }
    
    var localized: String {
        let key = self
        let value = NSLocalizedString(key, comment: "")
        
        let hasValueForKey = value != key
        if hasValueForKey {
            return value
        }
        
        // Fall back to en
        guard let path = Bundle.main.path(forResource: "en", ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return value
        }
        
        return NSLocalizedString(key, bundle: bundle, comment: "")
    }
}
