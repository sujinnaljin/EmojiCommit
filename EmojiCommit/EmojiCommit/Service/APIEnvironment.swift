//
//  APIEnvironment.swift
//  EmojiCommit
//
//  Created by Kang, Su Jin (강수진) on 2021/05/26.
//

import Foundation

enum APIEnvironment: String, CaseIterable {
    case development
    case staging
    case production
}

extension APIEnvironment {
    var githubServiceBaseUrl: String {
        switch self {
        case .development:
            return "https://dev-github.com"
        case .staging:
            return "https://stg-github.com"
        case .production:
            return "https://github.com"
        }
    }
}
