//
//  CommitViewModel.swift
//  EmojiCommit
//
//  Created by Kang, Su Jin (강수진) on 2021/04/06.
//

import Combine

final class CommitViewModel: ObservableObject {

    // MARK: Input
    enum Input {
        case fetchCommits(String)
        case showingSheet(SheetType)
    }
    
    enum SheetType {
        case theme
        case login
        case appIcon
    }
    
    func apply(_ input: Input) {
        switch input {
        case let .fetchCommits(githubId):
            isLoading = true
            fetchCommitsSubject.send(githubId)
        case let .showingSheet(sheetType):
            showingSheetSubject.send(sheetType)
        }
    }
    
    // MARK: Output
    @Published private(set) var result: Result<[Commit], APIServiceError>?
    @Published private(set) var isLoading = false
    @Published var isShowingSheet = false
    private(set) var selectedSheet: SheetType?
    
    // MARK: Subject
    private let fetchCommitsSubject = PassthroughSubject<String, Never>()
    private let githubIdSubject = PassthroughSubject<String, Never>()
    private let responseSubject = PassthroughSubject<CommitResponse, Never>()
    private let errorSubject = PassthroughSubject<APIServiceError, Never>()
    private let showingSheetSubject = PassthroughSubject<SheetType, Never>()
    
    // MARK: properties
    let settingTitle = I18N.settings
    let settingSystemImageName = "gearshape"
    let changeIdTitle = "👩🏻‍💻 \(I18N.changeId)"
    let changeThemeTitle = "😎 \(I18N.changeTheme)"
    let changeAppIconTitle = "🤓 \(I18N.changeAppIcon)"
    var githubId: String
    private var githubService: GithubServiceable
    private var cancellables = Set<AnyCancellable>()

    // MARK: init
    init(githubId: String,
         githubService: GithubServiceable = GithubService(apiService: APIService(),
                                                          environment: .production)) {
        self.githubId = githubId
        self.githubService = githubService
        self.bindInputs()
        self.bindOutputs()
    }

    private func bindInputs() {
        // Subject는 send(_:)를 통해 stream에 값을 주입할 수 있는 "publisher"
        let responsePublisher = self.fetchCommitsSubject.flatMap { [githubService] githubId in
            githubService.getCommits(id: githubId)
                .tryMap { (commits) in
                    guard commits.count > 0 else {
                        throw APIServiceError.customError("Cannot find any commits")
                    }
                    return CommitResponse(commits: commits)
                }
                // catch는 (APIServiceError)를 받아서 -> Publisher 리턴하는 handler 넣어준다
                .catch { [weak self] error -> Empty<CommitResponse, Never> in
                    self?.errorSubject.send(error as! APIServiceError)
                    return .init()
                }
        }
        
        // .subscribe(_:) 인자안에 subscriber을 넣어도 되고 subject를 넣어도 됨. publisher에서 값 뱉어낼때마다 send를 이어서 호출하는 듯.
        responsePublisher
            .subscribe(self.responseSubject)
            .store(in: &cancellables)
        
        fetchCommitsSubject
            .subscribe(self.githubIdSubject)
            .store(in: &cancellables)
    }
    
    private func bindOutputs() {
        self.githubIdSubject
            .sink { githubId in
                self.githubId = githubId
            }
            .store(in: &cancellables)
        
        self.responseSubject
            .sink(receiveValue: {
                self.isLoading = false
                self.result = .success($0.commits)
            })
            .store(in: &cancellables)

        self.errorSubject
            .sink(receiveValue: { (error) in
                self.isLoading = false
                self.result = .failure(error)
            })
            .store(in: &cancellables)
        
        self.showingSheetSubject
            .sink { (sheetType) in
                self.isShowingSheet = true
                self.selectedSheet = sheetType
            }
            .store(in: &cancellables)
    }
}
