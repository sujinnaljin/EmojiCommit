//
//  EmojiPhaseViewModelTests.swift
//  EmojiCommitTests
//
//  Created by 강수진 on 2021/04/20.
//

import XCTest
import Combine
@testable import EmojiCommit

class EmojiPhaseViewModelTests: XCTestCase {
    
    var viewModel: EmojiPhaseViewModel!
    var subscriptions = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = .init()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        subscriptions = []
    }
    
    func test_selectedIndexMessageWhenDoNothing() throws {
        // Given
        let expected = "최근 선택한 index는 없습니다"
        var result = ""
        
        viewModel.$selectedIndexMessage
            .sink { result = $0 }
            .store(in: &subscriptions)
        
        // When - Do Nothing
        
        // Then
        XCTAssert(
            result == expected,
            "selectedIndexMessage expected to be \(expected) but was \(result)"
        )
    }
    
    func test_selectedIndexMessageWhenSelectIndex() throws {
        // Given
        let index = 0
        let expected = "최근 선택한 index는 \(index)"
        var result = ""
        
        viewModel.$selectedIndexMessage
            .sink { result = $0 }
            .store(in: &subscriptions)
        
        // When
        viewModel.apply(.selectIndex(index))
        
        // Then
        XCTAssert(
            result == expected,
            "selectedIndexMessage expected to be \(expected) but was \(result)"
        )
    }
    
    func test_selectedIndexIsNilWhenDoNothing() throws {
        // Given
        var result: Int? = 0
        let expected: Int? = nil
        
        viewModel.$selectedIndex
            .sink { result = $0 }
            .store(in: &subscriptions)
        
        // When - Do Nothing
        
        // Then
        XCTAssertNil(
            result,
            "selectedIndex expected to be \(expected) but was \(result)"
        )
    }
    
    func test_selectedIndexWhenSelectIndex() throws {
        // Given
        let expected: Int = 1
        var result: Int? = 0
        
        viewModel.$selectedIndex
            .sink { result = $0 }
            .store(in: &subscriptions)
        
        // When
        viewModel.apply(.selectIndex(expected))
        
        // Then
        XCTAssert(
            expected == result,
            "selectedIndex expected to be \(expected) but was \(result)"
        )
    }
    
    func test_showingSheetStatusWhenDoNothing() throws {
        // Given
        let expected = false
        var result = true
        
        viewModel.$isShowingSheet
            .sink { result = $0 }
            .store(in: &subscriptions)
        
        // When - Do Nothing
        
        // Then
        XCTAssert(
            result == expected,
            "showingSheetStatus expected to be \(expected) but was \(result)"
        )
    }
    
    func test_showingSheetStatusWhenSelectIndex() throws {
        // Given
        let expected = true
        var result = false
        
        viewModel.$isShowingSheet
            .sink { result = $0 }
            .store(in: &subscriptions)
        
        // When
        viewModel.apply(.selectIndex(0))
        
        // Then
        XCTAssert(
            result == expected,
            "showingSheetStatus expected to be \(expected) but was \(result)"
        )
    }
    
    func test_isNextButtonEnabledWhenHasAllEmoji() throws {
        // Given
        let expected = true

        // When
        let phaseArray = [EmojiPhase(phase: 0, emoji: "🤔"),
                          EmojiPhase(phase: 1, emoji: "✅"),
                          EmojiPhase(phase: 2, emoji: "✍🏻"),
                          EmojiPhase(phase: 3, emoji: "😞"),
                          EmojiPhase(phase: 4, emoji: "🛠")]
        viewModel.emojiPhases = phaseArray
        
        // Then
        let result: Bool = viewModel.isNextEnabled
        XCTAssert(
            result == expected,
            "isNextButtonEnable expected to be \(expected) but was \(result)"
        )
    }
    
    func test_isNextButtonDisabledWhenHasEmptyEmoji() throws {
        // Given
        let expected = false
        
        // When
        let phaseArray = [EmojiPhase(phase: 0, emoji: "🤔"),
                          EmojiPhase(phase: 1, emoji: "✅"),
                          EmojiPhase(phase: 2, emoji: "✍🏻"),
                          EmojiPhase(phase: 3, emoji: "😞"),
                          EmojiPhase(phase: 4, emoji: "")]
        viewModel.emojiPhases = phaseArray
        
        // Then
        let result: Bool = viewModel.isNextEnabled
        XCTAssert(
            result == expected,
            "isNextButtonEnable expected to be \(expected) but was \(result)"
        )
    }
}
