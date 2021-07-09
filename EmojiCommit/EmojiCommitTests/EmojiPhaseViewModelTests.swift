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
        
        describe("selectedIndex") {
            context("when do nothing") {
                it("has no value") {
                    expect(viewModel.selectedIndex).to(beNil())
                }
            }
            
            context("when select Index") {
                let index = 0
                beforeEach {
                     viewModel.apply(.selectIndex(index))
                }
                it("is equal to selected index") {
                    expect(viewModel.selectedIndex).to(equal(index))
                }
            }
        }
        
        describe("showingSheetStatus") {
            context("when do nothing") {
                it("is false") {
                    expect(viewModel.isShowingSheet).to(beFalse())
                }
            }
            
            context("when select Index") {
                let index = 0
                beforeEach {
                     viewModel.apply(.selectIndex(index))
                }
                it("is true") {
                    expect(viewModel.isShowingSheet).to(beTrue())
                }
            }
        }
        
        describe("nextEnabledStatus") {
            context("when one of emojiphases is empty") {
                beforeEach {
                    let phaseArray = [EmojiPhase(phase: 0, emoji: "🤔"),
                                      EmojiPhase(phase: 1, emoji: "✅"),
                                      EmojiPhase(phase: 2, emoji: "✍🏻"),
                                      EmojiPhase(phase: 3, emoji: "😞"),
                                      EmojiPhase(phase: 4, emoji: "")]
                    viewModel.emojiPhases = phaseArray
                }
                it("is false") {
                    expect(viewModel.isNextEnabled).to(beFalse())
                }
            }
            
            context("when has all emojiphases") {
                beforeEach {
                    let phaseArray = [EmojiPhase(phase: 0, emoji: "🤔"),
                                      EmojiPhase(phase: 1, emoji: "✅"),
                                      EmojiPhase(phase: 2, emoji: "✍🏻"),
                                      EmojiPhase(phase: 3, emoji: "😞"),
                                      EmojiPhase(phase: 4, emoji: "🛠")]
                    viewModel.emojiPhases = phaseArray
                }
                it("is true") {
                    expect(viewModel.isNextEnabled).to(beTrue())
                }
            }
        }
    }
}

class CommitViewModelTests: QuickSpec {
    
}

class CommitItemViewModelTests: QuickSpec {
    struct UserDefaultMockService {
        func getEmoji() -> [EmojiPhase] {
            let zero = EmojiPhase(phase: 0, emoji: "🥚")
            let first = EmojiPhase(phase: 0, emoji: "🐣")
            let second = EmojiPhase(phase: 0, emoji: "🐥")
            let third = EmojiPhase(phase: 0, emoji: "🐔")
            let forth = EmojiPhase(phase: 0, emoji: "🍖")
            return [zero, first, second, third, forth]
        }
    }
}
