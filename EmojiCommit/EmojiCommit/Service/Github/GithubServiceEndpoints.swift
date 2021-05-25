//
//  GithubServiceEndpoints.swift
//  EmojiCommit
//
//  Created by Kang, Su Jin (강수진) on 2021/05/26.
//

import Foundation

enum GithubServiceEndpoints {
    // organise all the end points here for clarity
    case getCommits(id: String)
    
    // gave a default timeout but can be different for each.
    var requestTimeOut: Int {
        return 20
    }
    
    // specify the type of HTTP request
    var httpMethod: HTTPMethod {
        switch self {
        case .getCommits:
            return .GET
        }
    }
    
    // encodable request body for POST
    var requestBody: Encodable? {
        switch self {
        default:
            return nil
        }
    }
    
    // compose urls for each request
    func getURL(from environment: APIEnvironment) -> String {
        let baseUrl = environment.githubServiceBaseUrl
        switch self {
        case .getCommits(let id):
            return "\(baseUrl)/users/\(id)/contributions"
        }
    }
    
    // compose the NetworkRequest
    func createRequest(token: String = "",
                       environment: APIEnvironment) -> NetworkRequest {
        var headers: [String: String] = [:]
        headers["Content-Type"] = "application/json"
        headers["Authorization"] = "Bearer \(token)"
        return NetworkRequest(url: getURL(from: environment),
                              headers: headers,
                              reqBody: requestBody,
                              httpMethod: httpMethod)
    }
}
