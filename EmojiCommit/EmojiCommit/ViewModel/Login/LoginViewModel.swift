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
        case next(String)
    }
    
    func apply(_ input: Input) {
        switch input {
        case let .next(githubId):
            nextButtonSubject.send(githubId)
        }
    }
    
    // MARK: Output
    @Published var githubId = UserDefaults.standard.string(forKey: UserDefaultKey.githubId.rawValue) ?? ""
    @Published var isNextEnabled = false
    @Published var isButtonDisabled = true
    
    // MARK: Subject
    private let nextButtonSubject = PassthroughSubject<String, Never>()
    
    // MARK: properties
    var title = "github 아이디 입력 👩🏻‍💻"
    var idPlaceholder = "github 아이디를 입력하세요"
    private var didTouchNextButton: ((String) -> Void)?
    private var subscriptions = Set<AnyCancellable>()
    
    init(didTouchNextButton: ((String) -> Void)? = nil) {
        self.didTouchNextButton = didTouchNextButton
        configure()
    }
    
    func configure() {
        nextButtonSubject
            .sink { githubId in
                self.didTouchNextButton?(githubId)
            }
            .store(in: &subscriptions)
        
        $githubId
            .sink { githubId in
                UserDefaults.standard.setValue(githubId,
                                               forKey: UserDefaultKey.githubId.rawValue)
            }
            .store(in: &subscriptions)
        
        $githubId
            .map { githubId in
                githubId.count > 0
            }
            .assign(to: \.isNextEnabled, on: self)
            .store(in: &subscriptions)
        
        $githubId
            .map { githubId in
                githubId.count == 0
            }
            .assign(to: \.isButtonDisabled, on: self)
            .store(in: &subscriptions)
    }
}
