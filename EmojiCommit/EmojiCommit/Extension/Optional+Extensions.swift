//
//  Optional+Extensions.swift
//  EmojiCommit
//
//  Created by Kang, Su Jin (강수진) on 2021/04/12.
//

import Combine

extension Optional where Wrapped: Combine.Publisher {
    func orEmpty() -> AnyPublisher<Wrapped.Output, Wrapped.Failure> {
        self?.eraseToAnyPublisher() ?? Empty().eraseToAnyPublisher()
    }
}
