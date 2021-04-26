//
//  EmojiListViewModel.swift
//  EmojiCommit
//
//  Created by Kang, Su Jin (강수진) on 2021/04/26.
//

import emojidataios
import Combine

class EmojiListViewModel: ObservableObject {
    
    // MARK: Input
    enum Input {
        case onAppear
    }
    
    func apply(_ input: Input) {
        switch input {
        case .onAppear:
            onAppearSubject.send()
        }
    }
    
    // MARK: Subject
    private let onAppearSubject = PassthroughSubject<Void, Never>()
    private let emojiSubject = PassthroughSubject<Void, Never>()
    
    // MARK: properties
    private var subscriptions = Set<AnyCancellable>()
    var emojis: [EmojiGroup] = {
        let emojiCategories: [EmojiCategory] = [.SMILEYS,
                                                .PEOPLE,
                                                .NATURE,
                                                .FOODS,
                                                .ACTIVITY]
        let emojis: [EmojiGroup] = emojiCategories.map({ (category) in
            let section = category.rawValue
            let emojis = EmojiParser.emojisByCategory[category]?.compactMap({ (emoji) -> Emoji in
                return Emoji(value: emoji.emoji)
            }) ?? []
            return EmojiGroup(section: section, emojis: emojis)
        })
        return emojis
    }()
    
    init() {
        configure()
    }
    
    func configure() {
        onAppearSubject
            .sink { _ in
                EmojiParser.prepare()
            }
            .store(in: &subscriptions)
    }
}
