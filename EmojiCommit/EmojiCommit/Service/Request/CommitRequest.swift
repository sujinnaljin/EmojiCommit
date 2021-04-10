//
//  CommitRequest.swift
//  EmojiCommit
//
//  Created by Kang, Su Jin (강수진) on 2021/04/08.
//

import Foundation

struct CommitRequest: APIRequestType {
    let userId: String
    var path: String {
        "/users/\(userId)/contributions"
    }
    var queryItems: [URLQueryItem]? {
        nil
    }
}
