//
//  EmojiPhaseViewModel.swift
//  EmojiCommit
//
//  Created by 강수진 on 2021/04/20.
//

import Combine

class EmojiPhaseViewModel: ObservableObject {
    
    // MARK: Input
    enum Input {
        case selectIndex(_ index: Int)
    }
    
    func apply(_ input: Input) {
        switch input {
        case .selectIndex(let index):
            selectIndexSubject.send(index)
        }
    }
    
    // MARK: Output
    @Published var selectedIndexMessage = "최근 선택한 index는 없습니다"
    @Published var emojiPhases: [EmojiPhase] = []
    @Published var isNextEnabled = false
    @Published var isShowingSheet = false
    @Published var selectedIndex: Int? // 이걸 published로 하는게 맞나...???
    
    // MARK: Subject
    private let selectIndexSubject = PassthroughSubject<Int, Never>()
    
    // MARK: properties
    var title = "이모지 선택 😎"
    private var subscriptions = Set<AnyCancellable>()
    
    init(phaseArray: [EmojiPhase]) {
        self.emojiPhases = phaseArray
        configure()
    }
    
    func configure() {
        selectIndexSubject
            .map {
                "최근 선택한 index는 \($0)"
            }
            .assign(to: \.selectedIndexMessage, on: self)
            .store(in: &subscriptions)
        
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
            .map { (emojiPhases) -> Bool in
                return emojiPhases
                    .map({ (emojiPhases) in
                        // 값이 있을때 true, 없을때 false
                        !emojiPhases.emoji.isEmpty
                    })
                    .allSatisfy {
                        $0 == true
                    }
            }
            .assign(to: \.isNextEnabled, on: self)
            .store(in: &subscriptions)
    }
}
