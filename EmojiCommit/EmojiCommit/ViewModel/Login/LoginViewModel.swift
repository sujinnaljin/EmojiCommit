//
//  LoginViewModel.swift
//  EmojiCommit
//
//  Created by Kang, Su Jin (강수진) on 2021/04/26.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    // MARK: Input
    enum Input {
        case next
    }
    
    func apply(_ input: Input) {
        switch input {
        case .next:
            nextTapSubject.send()
        }
    }
    
    // MARK: Output
    @Published var githubId = UserDefaults.standard.string(forKey: UserDefaultKey.githubId.rawValue) ?? ""
    @Published var isNextEnabled = false
    @Published var isButtonDisabled = true
    
    // MARK: Subject
    private let nextTapSubject = PassthroughSubject<Void, Never>()
    
    // MARK: properties
    var title = "github 아이디 입력 👩🏻‍💻"
    var idPlaceholder = "github 아이디를 입력하세요"
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        configure()
    }
    
    func configure() {
        nextTapSubject
            .sink { _ in
                UserDefaults.standard.setValue(self.githubId, forKey: UserDefaultKey.githubId.rawValue)
            }
            .store(in: &subscriptions)
        
        $githubId
            .map { (githubId) in
                githubId.count > 0
            }
            .assign(to: \.isNextEnabled, on: self)
            .store(in: &subscriptions)
        
        $githubId
            .map { (githubId) in
                githubId.count == 0
            }
            .assign(to: \.isButtonDisabled, on: self)
            .store(in: &subscriptions)
    }
}
