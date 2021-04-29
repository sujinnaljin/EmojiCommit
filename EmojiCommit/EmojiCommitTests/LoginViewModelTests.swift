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
            viewModel = .init()
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
        
        describe("UserDefault 'githubId' value") {
            context("when githubId is changed") {
                let githubId = "sujinnaljina"
                beforeEach {
                    viewModel.githubId = githubId
                }
                it("is sync with changed value") {
                    let userDefaultValue = UserDefaults.standard.string(forKey: UserDefaultKey.githubId.rawValue)
                    expect(userDefaultValue).to(equal(githubId))
                }
            }
            
        }
        
    }
}
