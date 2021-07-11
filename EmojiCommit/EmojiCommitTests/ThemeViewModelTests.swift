//
//  ThemeViewModelTests.swift
//  EmojiCommitTests
//
//  Created by 강수진 on 2021/07/11.
//

import XCTest
import Combine
import Quick
import Nimble
@testable import EmojiCommit

class ThemeViewModelTests: QuickSpec {
    
    override func spec() {
        var viewModel: ThemeViewModel!
        
        beforeEach {
            viewModel = .init()
        }
        
        // 어떤 component를 test 하는지 설명 (명사)
        describe("selectedIndex") {
            // test의 목적이나, object의 현재 state (when 으로 시작)
            context("when select Index") {
                let index = 0
                beforeEach {
                     viewModel.apply(.selectIndex(index))
                }
                // test에서 기대되는 결과. 위에서 명사로 작성한 테스트 대상의 행동을 작성
                it("is equal to selected index") {
                    expect(viewModel.selectedIndex).to(equal(index))
                }
            }
        }
    }
}
