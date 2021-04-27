//
//  EmojiPhaseRow.swift
//  EmojiCommit
//
//  Created by Kang, Su Jin (강수진) on 2021/04/06.
//

import SwiftUI

struct EmojiPhaseRow: View {
    var emojiPhase: EmojiPhase
    
    var body: some View {
        HStack {
            Text("\(emojiPhase.phase) 단계")
            Text(emojiPhase.emoji.isEmpty ? "선택이 필요합니다" : emojiPhase.emoji)
            Spacer()
        }
        .contentShape(Rectangle()) // make tappable include spacer
    }
}

struct EmojiPhaseRow_Previews: PreviewProvider {
    static let emojiPhase = EmojiPhase(phase: 0, emoji: "😎")
    
    static var previews: some View {
        EmojiPhaseRow(emojiPhase: emojiPhase)
    }
}
