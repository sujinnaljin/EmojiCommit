//
//  GithubService.swift
//  EmojiCommit
//
//  Created by Kang, Su Jin (강수진) on 2021/05/26.
//

import Foundation
import Combine

protocol GithubServiceable {
    func getCommits(id: String) -> AnyPublisher<Data, APIServiceError>
}

class GithubService: GithubServiceable {
    
    private var apiService: Requestable
    private var environment: APIEnvironment
    
    // inject this for testability
    init(apiService: Requestable, environment: APIEnvironment) {
        self.apiService = apiService
        self.environment = environment
    }
    
    func getCommits(id: String) -> AnyPublisher<Data, APIServiceError> {
        let request = GithubServiceEndpoints
            .getCommits(id: id)
            .createRequest(environment: self.environment)
        return self.apiService.request(request)
    }
}
