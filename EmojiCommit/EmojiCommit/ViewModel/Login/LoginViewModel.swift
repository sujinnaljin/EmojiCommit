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
    
    // MARK: Subject
    private let nextButtonSubject = PassthroughSubject<String, Never>()
    
    // MARK: properties
    let isShowBanner: Bool
    let title = "\(I18N.githubIdPlaceHolder) 👩🏻‍💻"
    let idPlaceholder = I18N.githubIdPlaceHolder
    private let didTouchNextButton: ((String) -> Void)?
    private var subscriptions = Set<AnyCancellable>()
    
    init(isShowBanner: Bool,
         didTouchNextButton: ((String) -> Void)? = nil) {
        self.isShowBanner = isShowBanner
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
    }
}
