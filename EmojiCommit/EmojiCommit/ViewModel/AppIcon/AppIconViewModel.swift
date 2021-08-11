//
//  AppIconViewModel.swift
//  EmojiCommit
//
//  Created by 강수진 on 2021/07/14.
//

import UIKit
import Combine

class AppIconViewModel: ObservableObject {
    
    // MARK: Input
    enum Input {
        case selectAppIcon(_ appIcon: AppIcon)
        case next
    }
    
    func apply(_ input: Input) {
        switch input {
        case .selectAppIcon(let appIcon):
            selectAppIconSubject.send(appIcon)
        case .next:
            nextButtonSubject.send()
        }
    }
    
    // MARK: Output
    @Published var selectedAppIcon: AppIcon
    @Published var isErrorShown = false
    @Published var errorMessage: String = ""
    
    // MARK: Subject
    private let selectAppIconSubject = PassthroughSubject<AppIcon, Never>()
    private let nextButtonSubject = PassthroughSubject<Void, Never>()
    private let errorSubject = PassthroughSubject<String, Never>()
    
    // MARK: properties
    let title = "\(I18N.selectAppIcon) 🤓"
    let appIcons = AppIcon.allCases
    let isNextEnabled: Bool = true
    let errorTitle: String = "Error"
    private let didTouchNextButton: (() -> Void)?
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: init
    init(didTouchNextButton: (() -> Void)?) {
        self.didTouchNextButton = didTouchNextButton
        self.selectedAppIcon = appIcons.first(where: {
            $0.alternateIconName == UIApplication.shared.alternateIconName
        }) ?? .default
        configure()
    }
    
    private func configure() {
        selectAppIconSubject
            .assign(to: \.selectedAppIcon, on: self)
            .store(in: &subscriptions)
        
        nextButtonSubject
            .sink { [weak self] _ in
                guard let self = self else {
                    return
                }
                self.changeAppIcon(to: self.selectedAppIcon)
            }
            .store(in: &subscriptions)
        
        errorSubject
            .assign(to: \.errorMessage, on: self)
            .store(in: &subscriptions)
        
        errorSubject
            .map { _ in true }
            .assign(to: \.isErrorShown, on: self)
            .store(in: &subscriptions)
    }
    
    private func changeAppIcon(to appIcon: AppIcon) {
        UIApplication.shared.setAlternateIconName(appIcon.alternateIconName, completionHandler: { [weak self] (error) in
            guard let self = self else {
                return
            }
            if let error = error {
                self.errorSubject.send("\(I18N.appIconChangeFail) : \(error.localizedDescription)")
            } else {
                self.didTouchNextButton?()
            }
        })
    }
}
