//
//  EmojiListViewModel.swift
//  EmojiCommit
//
//  Created by Kang, Su Jin (강수진) on 2021/04/26.
//

import emojidataios
import Combine
import SwiftUI

class EmojiListViewModel: ObservableObject {
    
    // MARK: Input
    enum Input {
        case onAppear
        case select(String)
    }
    
    func apply(_ input: Input) {
        switch input {
        case .onAppear:
            onAppearSubject.send()
        case let .select(emoji):
            emojiSubject.send(emoji)
        }
    }
    
    // MARK: Output
    @Binding var emojiPhase: EmojiPhase
    @Binding var isShowingSheet: Bool
    
    // MARK: Subject
    private let onAppearSubject = PassthroughSubject<Void, Never>()
    private let emojiSubject = PassthroughSubject<String, Never>()
    
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
    
    init(emojiPhase: Binding<EmojiPhase>,
         isShowingSheet: Binding<Bool>) {
        self._emojiPhase = emojiPhase
        self._isShowingSheet = isShowingSheet
        configure()
    }
    
    func configure() {
        onAppearSubject
            .sink { _ in
                EmojiParser.prepare()
            }
            .store(in: &subscriptions)
        
        emojiSubject
            .sink { emoji in
                self.emojiPhase.emoji = emoji
                self.isShowingSheet = false
            }
            .store(in: &subscriptions)
        
    }
}
