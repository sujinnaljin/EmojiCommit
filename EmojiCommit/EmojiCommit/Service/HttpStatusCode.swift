//
//  HttpStatusCode.swift
//  EmojiCommit
//
//  Created by Kang, Su Jin (강수진) on 2021/04/08.
//

import Foundation

enum HttpStatusCode: Int {
    case success = 200
    case notFoundError = 404
    case internalServerError = 500
}
