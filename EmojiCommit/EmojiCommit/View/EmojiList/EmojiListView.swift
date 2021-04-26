//
//  EmojiListView.swift
//  EmojiCommit
//
//  Created by Kang, Su Jin (강수진) on 2021/03/26.
//

import SwiftUI

struct EmojiListView: View {
    private enum Constants {
        static let columnCount = 5
        static let emojiSpacing: CGFloat = 5
        static let emojiLineSpacing: CGFloat = 10
        static let emojiWidth: CGFloat = (UIScreen.screenWidth - CGFloat(columnCount)*emojiSpacing) / CGFloat(columnCount)
    }
    
    @StateObject var viewModel: EmojiListViewModel = .init()
    @Binding var emojiPhase: EmojiPhase
    @Binding var isShowingSheet: Bool
    
    // MARK: - Grid 형태 정의
    private var columns: [GridItem] {
        let grids = (0..<Constants.columnCount).map { (_) in
            GridItem(.fixed(Constants.emojiWidth), spacing: Constants.emojiSpacing)
        }
        return grids
    }
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: columns,
                          spacing: Constants.emojiLineSpacing) {
                    ForEach(viewModel.emojis) { emojiGroup in
                        Section(header: Text(emojiGroup.section).font(.title)) {
                            ForEach(emojiGroup.emojis) { (emoji) in
                                Button(emoji.value) {
                                    emojiPhase.emoji = emoji.value
                                    isShowingSheet = false
                                }
                            }
                        }
                    }
                }
            }
        }.onAppear(perform: {
            viewModel.apply(.onAppear)
        })
    }
}

struct EmojiListView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiListView(emojiPhase: .constant(EmojiPhase(phase: 0, emoji: "🔵")), isShowingSheet: .constant(true))
    }
}
