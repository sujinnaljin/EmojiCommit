//
//  GithubService.swift
//  EmojiCommit
//
//  Created by Kang, Su Jin (강수진) on 2021/05/26.
//

import Foundation
import Combine
import SwiftSoup

protocol GithubServiceable {
    func getCommits(id: String) -> AnyPublisher<[Commit], APIServiceError>
}

class GithubService: GithubServiceable {
    
    private var apiService: Requestable
    private var environment: APIEnvironment
    
    // inject this for testability
    init(apiService: Requestable, environment: APIEnvironment) {
        self.apiService = apiService
        self.environment = environment
    }
    
    func getCommits(id: String) -> AnyPublisher<[Commit], APIServiceError> {
        let request = GithubServiceEndpoints
            .getCommits(id: id)
            .createRequest(environment: self.environment)
        return self.apiService.request(request)
            .compactMap { String(data: $0, encoding: .ascii) }
            .compactMap { [weak self] html in self?.getCommits(from: html) }
            .eraseToAnyPublisher()
    }
    
    private func getCommits(from html: String) -> [Commit]? {
        let document = try? SwiftSoup.parse(html)
        let contributions = try? document?.select("rect")
        let commits = contributions?
            .compactMap({ (element) -> (String, String)? in
                guard let date = try? element.attr("data-date"),
                      let level = try? element.attr("data-level") else {
                    return nil
                }
                return (date, level)
            })
            .compactMap({ (dateString, levelString) -> Commit? in
                guard let levelInt = Int(levelString),
                      let level = Commit.Level(rawValue: levelInt),
                      let date = dateString.toDate() else {
                    return nil
                }
                return Commit(date: date, level: level)
            })
        return commits
    }
}
