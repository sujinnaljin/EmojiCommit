//
//  ThemeRow.swift
//  EmojiCommit
//
//  Created by 강수진 on 2021/07/11.
//

import SwiftUI

struct ThemeRow: View {
    var theme: Theme
    @Binding var isSelected: Bool
    
    var body: some View {
        HStack {
            ForEach(theme.colors.indices, id: \.self) { index in
                if let level = Commit.Level.init(rawValue: index) {
                    Image(level.emojiImageName)
                        .commitItemModifier(backgroundColor: theme.colors[index])
                }
            }
        }
        .listRowBackground(isSelected ? Color.gray : (Color(UIColor.systemBackground)))
    }
}
