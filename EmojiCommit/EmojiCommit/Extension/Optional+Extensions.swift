//
//  Optional+Extensions.swift
//  EmojiCommit
//
//  Created by Kang, Su Jin (강수진) on 2021/04/12.
//

import Combine

protocol AnyOptional {
    /// Returns `true` if `nil`, otherwise `false`.
    var isNil: Bool { get }
}

extension Optional: AnyOptional {
    public var isNil: Bool { self == nil }
}
