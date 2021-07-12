//
//  WeekDay.swift
//  EmojiCommit
//
//  Created by Kang, Su Jin (강수진) on 2021/05/04.
//

import Foundation

enum WeekDay: Int, CaseIterable {
    case sunday = 1
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    
    var title: String {
        switch self {
        case .sunday:
            return I18N.sunday
        case .monday:
            return I18N.monday
        case .tuesday:
            return I18N.tuesday
        case .wednesday:
            return I18N.wednesday
        case .thursday:
            return I18N.thursday
        case .friday:
            return I18N.friday
        case .saturday:
            return I18N.saturday
        }
    }
}
