//
//  AppIconViewModelTests.swift
//  EmojiCommitTests
//
//  Created by Kang, Su Jin (강수진) on 2021/08/17.
//

@testable import EmojiCommit
import Quick
import Nimble

class AppIconViewModelTests: QuickSpec {
    
    override func spec() {
        var viewModel: AppIconViewModel!
        
        beforeEach {
            UIApplication.shared.setAlternateIconName(nil)
            viewModel = .init(didTouchNextButton: nil)
        }
        
        // 어떤 component를 test 하는지 설명 (명사)
        describe("selectedAppIcon") {
            // test의 목적이나, object의 현재 state (when 으로 시작)
            context("when alternateIconName is not set") {
                // test에서 기대되는 결과. 위에서 명사로 작성한 테스트 대상의 행동을 작성
                it("is set to default") {
                    expect(viewModel.selectedAppIcon).to(equal(.default))
                }
            }
            
            context("when select appIcon") {
                let appIcon = AppIcon.emojiOne
                beforeEach {
                    viewModel.apply(.selectAppIcon(appIcon))
                }
                it("is equal to selected app icon") {
                    expect(viewModel.selectedAppIcon).to(equal(appIcon))
                }
            }
        }
        
        describe("alternateIconName") {
            context("when select appIcon and click next") {
                let appIcon = AppIcon.emojiOne
                beforeEach {
                    viewModel.apply(.selectAppIcon(appIcon))
                    viewModel.apply(.next)
                }
                it("is equal to selected app icon's alternateIconName") {
                    let expected = viewModel.selectedAppIcon.alternateIconName
                    expect(UIApplication.shared.alternateIconName).to(equal(expected))
                }
            }
        }
        
        // TODO: - isErrorShown 에 대한 testCode 작성 - 아래 코드는 다 test 통과함
        /*
        describe("isErrorShown") {
            let appIcons = AppIcon.allCases
            appIcons.forEach { (appIcon) in
            context("when set app icon with \(appIcon)") {
                beforeEach {
                    viewModel.apply(.selectAppIcon(appIcon))
                    viewModel.apply(.next)
                }
                
                it("is false") {
                    expect(viewModel.isErrorShown).to(beFalse())
                }
            }
        }
        */
    }
}
