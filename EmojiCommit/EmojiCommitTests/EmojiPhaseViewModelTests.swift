//
//  EmojiPhaseViewModelTests.swift
//  EmojiCommitTests
//
//  Created by 강수진 on 2021/04/20.
//

import XCTest
import Combine
import Quick
import Nimble
@testable import EmojiCommit

class EmojiPhaseViewModelTests: QuickSpec {
    
    override func spec() {
        var viewModel: EmojiPhaseViewModel!
        
        beforeEach {
            viewModel = .init()
        }
        
        // 어떤 component를 test 하는지 설명 (명사)
        describe("selectedIndexMessage") {
            
            // test의 목적이나, object의 현재 state (when 으로 시작)
            context("when do nothing") {
                // test에서 기대되는 결과. 위에서 명사로 작성한 테스트 대상의 행동을 작성
                it("shows default message") {
                    let expected = "최근 선택한 index는 없습니다"
                    expect(viewModel.selectedIndexMessage).to(equal(expected))
                }
            }
            
            context("when select Index") {
                let index = 0
                beforeEach {
                    viewModel.apply(.selectIndex(index))
                }
                it("shows message with selected index") {
                    let expected = "최근 선택한 index는 \(index)"
                    expect(viewModel.selectedIndexMessage).to(equal(expected))
                }
            }
        }
    }
    
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
