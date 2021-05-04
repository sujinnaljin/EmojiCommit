//
//  Date+Extensions.swift
//  EmojiCommit
//
//  Created by Kang, Su Jin (강수진) on 2021/04/10.
//

import Foundation

extension Date {
    var year: Int {
        return Calendar(identifier: .gregorian).component(.year, from: self)
    }
    
    var month: Int {
         return Calendar(identifier: .gregorian).component(.month, from: self)
    }
    
    var day: Int {
         return Calendar(identifier: .gregorian).component(.day, from: self)
    }
    
    var weekday: Int {
        return Calendar(identifier: .gregorian).component(.weekday, from: self)
    }
    
    var monthName: String {
        let nameFormatter = DateFormatter()
        nameFormatter.dateFormat = "MMMM" // format January, February, March, ...
        return nameFormatter.string(from: self)
    }
}
