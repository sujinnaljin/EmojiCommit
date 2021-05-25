//
//  Requestable.swift
//  EmojiCommit
//
//  Created by Kang, Su Jin (강수진) on 2021/05/26.
//

import Foundation
import Combine

protocol Requestable {
    var requestTimeOut: Float { get }
    func request(_ request: NetworkRequest) -> AnyPublisher<Data, APIServiceError>
}
