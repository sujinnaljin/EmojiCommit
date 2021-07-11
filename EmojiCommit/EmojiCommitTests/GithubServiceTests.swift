//
//  GithubServiceTests.swift
//  EmojiCommitTests
//
//  Created by Kang, Su Jin (강수진) on 2021/06/07.
//

import Combine
import Quick
import Nimble
@testable import EmojiCommit

struct GithubMockService: GithubServiceable {
    func getCommits(id: String) -> AnyPublisher<[Commit], APIServiceError> {
        let defaultDate = Date()
        let commits = (0...6).map { (day) -> Commit in
            let nextDate = Calendar.current.date(byAdding: .day, value: day, to: defaultDate)
            let commit = Commit(date: nextDate ?? defaultDate, level: .zero)
            return commit
        }
        return commits.publisher
            .collect()
            .setFailureType(to: APIServiceError.self)
            .eraseToAnyPublisher()
    }
}

class GithubServiceTests: QuickSpec {
    // 요청 보내면 commit 오는거
    override func spec() {
        var githubService: GithubServiceable!
        var subscriptions: Set<AnyCancellable>!
        
        beforeEach {
            subscriptions = .init()
        }
        
        // 어떤 component를 test 하는지 설명 (명사)
        describe("github commits") {
            // test의 목적이나, object의 현재 state (when 으로 시작)
            context("when request network from github") {
                beforeEach {
                    githubService = GithubService.init(apiService: APIService(),
                                                       environment: .production)
                }
                // test에서 기대되는 결과. 위에서 명사로 작성한 테스트 대상의 행동을 작성
                it("returns commits greater than 365") {
                    let timeoutSeconds = 3
                    let id = "sujinnaljin"
                    let expected = 365
                    var count = 0
                    
                    githubService.getCommits(id: id)
                        .sink { (_) in
                        } receiveValue: { (commits) in
                            count = commits.count
                        }
                        .store(in: &subscriptions)
                    expect(count).toEventually(beGreaterThanOrEqualTo(expected), timeout: .seconds(timeoutSeconds))
                }
            }
            
            context("when use mock data") {
                beforeEach {
                    githubService = GithubMockService.init()
                }
                
                it("returns commits 7") {
                    let id = "sujinnaljin"
                    let expected = 7
                    
                    githubService.getCommits(id: id)
                        .sink { (_) in
                        } receiveValue: { (commits) in
                            expect(commits.count).to(equal(expected))
                        }
                        .store(in: &subscriptions)
                }
            }
        }
    }
}
