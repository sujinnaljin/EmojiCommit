//
//  EmojiListView.swift
//  EmojiCommit
//
//  Created by Kang, Su Jin (강수진) on 2021/03/26.
//

import SwiftUI
import emojidataios

}

struct EmojiListView: View {
    private enum Constants {
        static let columnCount = 5
        static let emojiSpacing: CGFloat = 5
        static let emojiLineSpacing: CGFloat = 10
        static let emojiWidth: CGFloat = (UIScreen.screenWidth - CGFloat(columnCount)*emojiSpacing) / CGFloat(columnCount)
    }
    
    @Binding var emojiPhase: EmojiPhase
    @Binding var isShowingSheet: Bool
    
    private let emojiCategories: [EmojiCategory] = [.SMILEYS,
                                                    .PEOPLE,
                                                    .NATURE,
                                                    .FOODS,
                                                    .ACTIVITY]
    
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
                    ForEach(emojiCategories, id: \.self) { emojiCategory in
                        Section(header: Text(emojiCategory.rawValue).font(.title)) {
                            
                            let emojis = EmojiParser.emojisByCategory[emojiCategory]?.compactMap({ (emoji) -> Emoji in
                                return Emoji(value: emoji.emoji)
                            }) ?? []
                            
                            // todo string array나 Emoji: Hasable에서 id를 \.self 로 주면 에러. 왜?
                            ForEach(emojis) { (emoji) in
                                // todo 이모지 크게
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
            EmojiParser.prepare()
        })
    }
}

struct EmojiListView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiListView(emojiPhase: .constant(EmojiPhase(phase: 0, emoji: "🔵")), isShowingSheet: .constant(true))
    }
}
