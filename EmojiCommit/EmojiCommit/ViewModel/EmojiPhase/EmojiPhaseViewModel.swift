//
//  EmojiPhaseViewModel.swift
//  EmojiCommit
//
//  Created by 강수진 on 2021/04/20.
//

import Foundation
import Combine

class EmojiPhaseViewModel: ObservableObject {
    
    // MARK: Input
    enum Input {
        case selectIndex(_ index: Int)
        case next
    }
    
    func apply(_ input: Input) {
        switch input {
        case .selectIndex(let index):
            selectIndexSubject.send(index)
        case .next:
            nextButtonSubject.send()
        }
    }
    
    // MARK: Output
    @PublishedEmojiPhase(wrappedValue: []) var emojiPhases: [EmojiPhase]
    @Published var isShowingSheet = false
    @Published var selectedIndex: Int?
    @Published var isNextEnabled: Bool = false
    
    // MARK: Subject
    private let selectIndexSubject = PassthroughSubject<Int, Never>()
    private let nextButtonSubject = PassthroughSubject<Void, Never>()
    
    // MARK: properties
    var title = "이모지 선택 😎"
    let sectionTitle = "단계별 이모지를 선택해주세요"
    private var didTouchNextButton: (() -> Void)?
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: init
    init(didTouchNextButton: (() -> Void)? = nil) {
        self.didTouchNextButton = didTouchNextButton
        if emojiPhases.count == 0 {
            let defaultEmojiPhases = [EmojiPhase(phase: 0, emoji: ""),
                                      EmojiPhase(phase: 1, emoji: ""),
                                      EmojiPhase(phase: 2, emoji: ""),
                                      EmojiPhase(phase: 3, emoji: ""),
                                      EmojiPhase(phase: 4, emoji: "")]
            emojiPhases = defaultEmojiPhases
        } else {
            emojiPhases = _emojiPhases.wrappedValue
        }
        configure()
    }
    
    func configure() {
        selectIndexSubject
            .map { index in Optional.init(index) }
            .assign(to: \.selectedIndex, on: self)
            .store(in: &subscriptions)
        
        selectIndexSubject
            .map {
                _ in true
            }
            .assign(to: \.isShowingSheet, on: self)
            .store(in: &subscriptions)
        
        $emojiPhases
            .filter { $0.count > 0}
            .map { (emojiPhases) -> Bool in
                return emojiPhases
                    .map({ (emojiPhases) -> Bool in
                        // 값이 있을때 true, 없을때 false
                        emojiPhases.emoji.isNotEmpty
                    })
                    .allSatisfy {
                        $0 == true
                    }
            }
            .assign(to: \.isNextEnabled, on: self)
            .store(in: &subscriptions)
        
        nextButtonSubject
            .sink { [weak self] _ in
                self?.didTouchNextButton?()
            }
            .store(in: &subscriptions)
    }
}

@propertyWrapper
class PublishedEmojiPhase {
    @Published var value: [EmojiPhase]
    
    var wrappedValue: [EmojiPhase] {
        get {
            var emojiPhases: [EmojiPhase]?
            if let data = UserDefaults.shared.value(forKey: UserDefaults.Key.emojiPhases.rawValue) as? Data {
                emojiPhases = try? PropertyListDecoder().decode([EmojiPhase].self, from: data)
            }
            return emojiPhases ?? []
        }
        set {
            UserDefaults.shared.set(try? PropertyListEncoder().encode(newValue), forKey: UserDefaults.Key.emojiPhases.rawValue)
            value = newValue
        }
    }
    
    var projectedValue: AnyPublisher<[EmojiPhase], Never> {
        return $value
            // .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    init(wrappedValue initialValue: [EmojiPhase]) {
        value = initialValue
    }
}
