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
    @Published var isErrorShown = false
    @Published var errorMessage = ""
    
    // MARK: Subject
    private let onAppearSubject = PassthroughSubject<Void, Never>()
    private let responseSubject = PassthroughSubject<CommitResponse, Never>()
    private let errorSubject = PassthroughSubject<APIServiceError, Never>()
    
    // MARK: properties
    private var userId: String
    private var apiService: APIServiceType
    private var cancellables: [AnyCancellable] = []

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
        
        //Subject는 send(_:)를 통해 stream에 값을 주입할 수 있는 "publisher"
        let responsePublisher = self.onAppearSubject.flatMap { [apiService] _ in
            
            //todo 여기서 한글이면 에러나 학생..^^
            apiService.response(from: request)!
                .compactMap { String(data: $0, encoding: .ascii) }
                .compactMap { [weak self] html in self?.getCommits(from: html) }
                .tryMap { (commits) in
                    guard commits.count > 0 else {
                        throw APIServiceError.customError("Cannot find any commits")
                    }
                    return CommitResponse(commits: commits)
                }
                //catch는 (APIServiceError)를 받아서 -> Publisher 리턴하는 handler 넣어준다
                .catch { [weak self] error -> Empty<CommitResponse, Never> in
                    self?.errorSubject.send(error as! APIServiceError)
                    return .init()
                }
        }
        
        //.subscribe(_:) 인자안에 subscriber을 넣어도 되고 subject를 넣어도 됨. publisher에서 값 뱉어낼때마다 send를 이어서 호출하는 듯.
        let responseStream = responsePublisher.subscribe(self.responseSubject)

        cancellables += [
            responseStream,
        ]
    }
    
    private func bindOutputs() {
        let commitsStream = self.responseSubject
            .map { $0.commits }
            .assign(to: \.commits, on: self)
        
        let errorMessageStream = self.errorSubject
            .map { error -> String in
                switch error {
                case .internetError:
                    return "네트워크 에러입니다. 인터넷 연결상태를 확인해주세요."
                case .clientError:
                    return "ID를 다시 입력해주세요."
                case .serverError:
                    return "탭해서 다시 시도해주세요."
                case .customError(let message):
                    return message
                case .unknowError(let message):
                    return message
                }
            }
            .assign(to: \.errorMessage, on: self)

        let errorStream = self.errorSubject
            .map { _ in true }
            .assign(to: \.isErrorShown, on: self)

        cancellables += [
            commitsStream,
            errorStream,
            errorMessageStream
        ]
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
