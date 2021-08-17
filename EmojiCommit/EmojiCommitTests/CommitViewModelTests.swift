//
//  CommitViewModelTests.swift
//  EmojiCommitTests
//
//  Created by Kang, Su Jin (강수진) on 2021/08/17.
//

@testable import EmojiCommit
import Quick
import Nimble

class CommitViewModelTests: QuickSpec {
    
    override func spec() {
        var viewModel: CommitViewModel!
        
        beforeEach {
            viewModel = .init(githubId: "sujinnaljin")
        }
        /*
         @Published private(set) var isLoading = false
         **/
        
        describe("isLoading") {
            beforeEach {
                viewModel = .init(githubId: "",
                                  githubService: GithubDelay2SecdonsMockService.init())
                viewModel.apply(.fetchCommits(viewModel.githubId))
            }
            
            context("when fetching data") {
                it("is true") {
                    expect(viewModel.isLoading).to(beTrue())
                }
            }
            
            context("when finish to fetch data") {
                it("is false") {
                    let timeoutSeconds = 3
                    expect(viewModel.isLoading).toEventually(beFalse(), timeout: .seconds(timeoutSeconds))
                }
            }
        }
        
        describe("viewType") {
            context("when fail to fetch commits") {
                beforeEach {
                    viewModel = .init(githubId: "",
                                      githubService: GithubErrorMockService.init())
                    viewModel.apply(.fetchCommits(viewModel.githubId))
                }
                it("is equal to failure type") {
                    let expected = CommitViewModel.ViewType.failure( APIServiceError.internetError)
                    
                    expect(viewModel.viewType).to(equal(expected))
                }
            }
            
            context("when success to fetch commits") {
                beforeEach {
                    viewModel = .init(githubId: "",
                                      githubService: GithubSuccessMockService.init())
                    viewModel.apply(.fetchCommits(viewModel.githubId))
                }
                it("is equal to success type") {
                    let expected = CommitViewModel.ViewType.success([])
                    
                    expect(viewModel.viewType).to(equal(expected))
                }
            }
        }
        
        describe("isShowingAlert") {
            context("when select nothing") {
                it("is false") {
                    expect(viewModel.isShowingSheet).to(beFalse())
                }
            }
            
            context("when select mail with no account setting") {
                beforeEach {
                    viewModel.apply(.showingSheet(.mail))
                }
                it("is true") {
                    expect(viewModel.isShowingAlert).to(beTrue())
                }
            }
        }
        
        describe("isShowingSheet status") {
            context("when select nothing") {
                it("is false") {
                    expect(viewModel.isShowingSheet).to(beFalse())
                }
            }
            context("when select theme") {
                beforeEach {
                    viewModel.apply(.showingSheet(.theme))
                }
                it("is true") {
                    expect(viewModel.isShowingSheet).to(beTrue())
                }
            }
            
            context("when select mail with no account setting") {
                beforeEach {
                    viewModel.apply(.showingSheet(.mail))
                }
                it("is false") {
                    expect(viewModel.isShowingSheet).to(beFalse())
                }
            }
        }
        
        describe("selectedSheet") {
            context("when select theme") {
                let sheetType: CommitViewModel.SheetType = .theme
                beforeEach {
                    viewModel.apply(.showingSheet(sheetType))
                }
                it("is equal to selected sheet type") {
                    expect(viewModel.selectedSheet).to(equal(sheetType))
                }
            }
            
            context("when select mail with no account setting") {
                let sheetType: CommitViewModel.SheetType = .mail
                beforeEach {
                    viewModel.apply(.showingSheet(sheetType))
                }
                it("is nil") {
                    expect(viewModel.selectedSheet).to(beNil())
                }
            }
        }
    }
}
