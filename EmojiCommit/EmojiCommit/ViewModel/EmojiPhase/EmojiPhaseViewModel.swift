//
//  EmojiPhaseViewModel.swift
//  EmojiCommit
//
//  Created by 강수진 on 2021/04/20.
//

import Combine
import SwiftUI

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
    @AppStorage("emojiPhases") var emojiPhases: [EmojiPhase] = [EmojiPhase(phase: 0, emoji: ""),
                                                                EmojiPhase(phase: 1, emoji: ""),
                                                                EmojiPhase(phase: 2, emoji: ""),
                                                                EmojiPhase(phase: 3, emoji: ""),
                                                                EmojiPhase(phase: 4, emoji: "")]
    @Published var selectedIndexMessage = "최근 선택한 index는 없습니다"
    @Published var isShowingSheet = false
    @Published var selectedIndex: Int? // 이걸 published로 하는게 맞나...???
    
    // MARK: Subject
    private let selectIndexSubject = PassthroughSubject<Int, Never>()
    
    // MARK: properties
    var title = "이모지 선택 😎"
//    //todo 이걸 subscribe 안하고 computed property로 하는게 맞나..? app storage가 publisher로 잘 안만들어져서..
    var isNextEnabled: Bool {
        return emojiPhases
            .map({ (emojiPhases) in
                emojiPhases.emoji.isNotEmpty
            })
            .allSatisfy {
                $0 == true
            }
    }
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
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
    }
}
