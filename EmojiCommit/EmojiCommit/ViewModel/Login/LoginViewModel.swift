//
//  LoginViewModel.swift
//  EmojiCommit
//
//  Created by Kang, Su Jin (강수진) on 2021/04/26.
//

import Foundation
import Combine
import WidgetKit

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
    @Published var githubId = UserDefaults.githubId ?? ""
    @Published var isNextEnabled = false
    @Published var isButtonDisabled = true
    
    // MARK: Subject
    private let nextButtonSubject = PassthroughSubject<String, Never>()
    
    // MARK: properties
    var title = "\(I18N.githubIdPlaceHolder) 👩🏻‍💻"
    var idPlaceholder = I18N.githubIdPlaceHolder
    private var didTouchNextButton: ((String) -> Void)?
    private var subscriptions = Set<AnyCancellable>()
    
    init(didTouchNextButton: ((String) -> Void)? = nil) {
        self.didTouchNextButton = didTouchNextButton
        configure()
    }
    
    func configure() {
        nextButtonSubject
            .sink { githubId in
                UserDefaults.githubId = githubId
                WidgetCenter.shared.reloadAllTimelines()
                self.didTouchNextButton?(githubId)
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
