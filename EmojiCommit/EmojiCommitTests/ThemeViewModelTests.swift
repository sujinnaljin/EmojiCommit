//
//  ThemeViewModelTests.swift
//  EmojiCommitTests
//
//  Created by 강수진 on 2021/07/11.
//

@testable import EmojiCommit
import Quick
import Nimble

class ThemeViewModelTests: QuickSpec {
    
    override func spec() {
        var viewModel: ThemeViewModel!
        
        beforeEach {
            UserDefaults.shared.removeAll()
            viewModel = .init(isShowBanner: false, didTouchNextButton: nil)
        }
        
        // 어떤 component를 test 하는지 설명 (명사)
        describe("selectedIndex") {
            // test의 목적이나, object의 현재 state (when 으로 시작)
            context("when user default is not set") {
                // test에서 기대되는 결과. 위에서 명사로 작성한 테스트 대상의 행동을 작성
                it("is equal to 0") {
                    expect(viewModel.selectedIndex).to(equal(.zero))
                }
            }
           
            context("when select Index") {
                let index = 1
                beforeEach {
                    viewModel.apply(.selectIndex(index))
                }
                it("is equal to selected index") {
                    expect(viewModel.selectedIndex).to(equal(index))
                }
            }
        }
        
        describe("UserDefaults themeType") {
            context("when select index and click next") {
                let index = 1
                beforeEach {
                    viewModel.apply(.selectIndex(index))
                    viewModel.apply(.next)
                }
                it("is equal to themeType at selected index") {
                    let expected = viewModel.themeTypes[index].rawValue
                    expect(UserDefaults.themeType).to(equal(expected))
                }
            }
        }
    }
}
