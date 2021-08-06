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
    // 무엇을 호출하는지 결정하는건 request를 호출 했을 때 결과 값으로 받는 데이터 타입이 어떤 거냐에 따라서 달라짐
    func request(_ request: NetworkRequest) -> AnyPublisher<Data, APIServiceError>
    func request<T: Decodable>(_ request: NetworkRequest) -> AnyPublisher<T, APIServiceError>
}
