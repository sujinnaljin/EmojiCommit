//
//  NetworkRequest.swift
//  EmojiCommit
//
//  Created by Kang, Su Jin (강수진) on 2021/05/26.
//

import Foundation

struct NetworkRequest {
    let url: String
    let headers: [String: String]?
    let body: Data?
    let requestTimeOut: Float?
    let httpMethod: HTTPMethod
    
    init(url: String,
         headers: [String: String]? = nil,
         reqBody: Encodable? = nil,
         reqTimeout: Float? = nil,
         httpMethod: HTTPMethod
    ) {
        self.url = url
        self.headers = headers
        self.body = reqBody?.encode()
        self.requestTimeOut = reqTimeout
        self.httpMethod = httpMethod
    }
    
    init(url: String,
         headers: [String: String]? = nil,
         reqBody: Data? = nil,
         reqTimeout: Float? = nil,
         httpMethod: HTTPMethod
    ) {
        self.url = url
        self.headers = headers
        self.body = reqBody
        self.requestTimeOut = reqTimeout
        self.httpMethod = httpMethod
    }
    
    func buildURLRequest(with url: URL) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = headers ?? [:]
        urlRequest.httpBody = body
        return urlRequest
    }
}
