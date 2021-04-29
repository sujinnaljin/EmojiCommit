//
//  LoginViewModel.swift
//  EmojiCommit
//
//  Created by Kang, Su Jin (강수진) on 2021/04/26.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    // MARK: Output
    @Published var githubId = UserDefaults.standard.string(forKey: UserDefaultKey.githubId.rawValue) ?? ""
    @Published var isNextEnabled = false
    @Published var isButtonDisabled = true
    
    // MARK: properties
    var title = "github 아이디 입력 👩🏻‍💻"
    var idPlaceholder = "github 아이디를 입력하세요"
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        configure()
    }
    
    func configure() {
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
