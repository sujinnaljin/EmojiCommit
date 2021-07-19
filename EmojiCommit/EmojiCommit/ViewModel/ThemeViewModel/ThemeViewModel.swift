//
//  ThemeViewModel.swift
//  EmojiCommit
//
//  Created by 강수진 on 2021/07/11.
//

import Foundation
import Combine
import WidgetKit

class ThemeViewModel: ObservableObject {
    
    // MARK: Input
    enum Input {
        case selectIndex(_ index: Int)
        case next
    }
    
    func apply(_ input: Input) {
        switch input {
        case .selectIndex(let index):
            selectIndexSubject.send(index)
        case .next:
            nextButtonSubject.send()
        }
    }
    
    // MARK: Output
    @Published var selectedIndex: Int
    
    // MARK: Subject
    private let selectIndexSubject = PassthroughSubject<Int, Never>()
    private let nextButtonSubject = PassthroughSubject<Void, Never>()
    
    // MARK: properties
    let isShowBanner: Bool
    let title = "\(I18N.selectTheme) 😎"
    let themeTypes = ThemeType.allCases
    let isNextEnabled: Bool = true
    private let didTouchNextButton: (() -> Void)?
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: init
    init(isShowBanner: Bool,
         didTouchNextButton: (() -> Void)? = nil) {
        self.isShowBanner = isShowBanner
        self.didTouchNextButton = didTouchNextButton
        self.selectedIndex = themeTypes.enumerated().first { (_, themeType) in
            UserDefaults.themeType == themeType.rawValue
        }.map { (index, _) in
            return index
        } ?? 0
        configure()
    }
    
    func configure() {
        selectIndexSubject
            .assign(to: \.selectedIndex, on: self)
            .store(in: &subscriptions)
    
        nextButtonSubject
            .sink { [weak self] _ in
                guard let self = self else {
                    return
                }
                UserDefaults.themeType = self.themeTypes[self.selectedIndex].rawValue
                WidgetCenter.shared.reloadAllTimelines()
                self.didTouchNextButton?()
            }
            .store(in: &subscriptions)
    }
}
