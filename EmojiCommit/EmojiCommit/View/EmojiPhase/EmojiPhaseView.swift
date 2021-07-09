//
//  EmojiPhaseView.swift
//  EmojiCommit
//
//  Created by Kang, Su Jin (강수진) on 2021/03/26.
//

import SwiftUI

struct EmojiPhaseView: View {
    
    @StateObject var viewModel: EmojiPhaseViewModel
    
    var body: some View {
        GeometryReader { (geometry) in
            NavigationView {
                VStack(spacing: 0) {
                    // MARK: - List
                    List(viewModel.emojiPhases.indices, id: \.self) { index in
                        EmojiPhaseRow(emojiPhase: viewModel.emojiPhases[index])
                            .onTapGesture {
                                viewModel.apply(.selectIndex(index))
                            }
                    }
                    .listStyle(InsetGroupedListStyle())
                    .sheet(isPresented: $viewModel.isShowingSheet) {
                        if let selectedIndex = viewModel.selectedIndex {
                            EmojiListView(viewModel: .init(emojiPhase: $viewModel.emojiPhases[selectedIndex],
                                                           isShowingSheet: $viewModel.isShowingSheet))
                        }
                    }
                    
                    // MARK: - Bottom Next Link
                    NavigationLink(destination: LoginView()) {
                        BottomNextView(geometry: geometry,
                                       isNextEnabled: viewModel.isNextEnabled)
                            .navigationTitle(viewModel.title)
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        self.viewModel.apply(.next)
                    })
                    .disabled(!viewModel.isNextEnabled)
                }
                .edgesIgnoringSafeArea(.bottom)
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct EmojiPhaseView_Previews: PreviewProvider {
    static let phaseArray = [EmojiPhase(phase: 0, emoji: ""),
                             EmojiPhase(phase: 1, emoji: ""),
                             EmojiPhase(phase: 2, emoji: ""),
                             EmojiPhase(phase: 3, emoji: ""),
                             EmojiPhase(phase: 4, emoji: "")]
    
    static var previews: some View {
        EmojiPhaseView(viewModel: .init())
    }
}
