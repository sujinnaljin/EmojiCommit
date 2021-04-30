//
//  CommitViewModel.swift
//  EmojiCommit
//
//  Created by Kang, Su Jin (강수진) on 2021/04/06.
//

import Foundation
import Combine
import SwiftSoup

final class CommitViewModel: ObservableObject {

    // MARK: Input - ex) viewModel.apply(.onApper)
    enum Input {
        case onAppear
    }
    
    func apply(_ input: Input) {
        switch input {
        case .onAppear:
            onAppearSubject.send(())
        }
    }
    
    // MARK: Output
    @Published private(set) var commits: [Commit] = []
    @Published private(set) var error: APIServiceError?
    @PublishedEmojiPhase(wrappedValue: []) private(set) var emojiPhases: [EmojiPhase]
    
    // MARK: Subject
    private let onAppearSubject = PassthroughSubject<Void, Never>()
    private let responseSubject = PassthroughSubject<CommitResponse, Never>()
    private let errorSubject = PassthroughSubject<APIServiceError, Never>()
    
    // MARK: properties
    private var userId: String
    private var apiService: APIServiceType
    private var cancellables = Set<AnyCancellable>()

    // MARK: init
    init(userId: String,
         apiService: APIServiceType = APIService()) {
        self.userId = userId
        self.apiService = apiService
        self.bindInputs()
        self.bindOutputs()
    }

    private func bindInputs() {
        let request = CommitRequest(userId: userId)
        // Subject는 send(_:)를 통해 stream에 값을 주입할 수 있는 "publisher"
        let responsePublisher = self.onAppearSubject.flatMap { [apiService] _ in

            apiService.response(from: request)
                .orEmpty()
                .compactMap { String(data: $0, encoding: .ascii) }
                .compactMap { [weak self] html in self?.getCommits(from: html) }
                .tryMap { (commits) in
                    guard commits.count > 0 else {
                        throw APIServiceError.customError("Cannot find any commits")
                    }
                    return CommitResponse(commits: commits)
                }
                // catch는 (APIServiceError)를 받아서 -> Publisher 리턴하는 handler 넣어준다
                .catch { [weak self] error -> Empty<CommitResponse, Never> in
                    self?.errorSubject.send(error as! APIServiceError)
                    return .init()
                }
        }
        
        // .subscribe(_:) 인자안에 subscriber을 넣어도 되고 subject를 넣어도 됨. publisher에서 값 뱉어낼때마다 send를 이어서 호출하는 듯.
        responsePublisher.subscribe(self.responseSubject)
            .store(in: &cancellables)
    }
    
    private func bindOutputs() {
        self.responseSubject
            .map { $0.commits }
            .assign(to: \.commits, on: self)
            .store(in: &cancellables)

        self.errorSubject
            .sink(receiveValue: { (error) in
                self.error = error
            })
            .store(in: &cancellables)
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
