//
//  LoginViewModelTests.swift
//  EmojiCommitTests
//
//  Created by 강수진 on 2021/04/29.
//

@testable import EmojiCommit
import Quick
import Nimble

class LoginViewModelTests: QuickSpec {
    
    override func spec() {
        var viewModel: LoginViewModel!
        
        beforeEach {
            viewModel = .init(isShowBanner: false, didTouchNextButton: nil)
        }
        
        // 어떤 component를 test 하는지 설명 (명사)
        describe("UserDefaults githubId") {
            // test의 목적이나, object의 현재 state (when 으로 시작)
            context("when set github id and click next") {
                let githubId = "sujinnaljin"
                beforeEach {
                    viewModel.apply(.next(githubId))
                }
                // test에서 기대되는 결과. 위에서 명사로 작성한 테스트 대상의 행동을 작성
                it("is equal to input github id") {
                    expect(UserDefaults.githubId).to(equal(githubId))
                }
            }
        }
        
        describe("nextEnabledStatus") {
            context("when githubId is empty") {
                beforeEach {
                    let githubId = ""
                    viewModel.githubId = githubId
                }
                it("is false") {
                    expect(viewModel.isNextEnabled).to(beFalse())
                }
            }
            
            context("when githubId is not empty") {
                beforeEach {
                    let githubId = "sujinnaljin"
                    viewModel.githubId = githubId
                }
                it("is true") {
                    expect(viewModel.isNextEnabled).to(beTrue())
                }
            }
        }
    }
}
