//
//  ThemeRow.swift
//  EmojiCommit
//
//  Created by 강수진 on 2021/07/11.
//

import SwiftUI

struct ThemeRow: View {
    var themeType: ThemeType
    @Binding var isSelected: Bool
    
    var body: some View {
        HStack {
            ForEach(0..<themeType.theme.count, id: \.self) { index in
                if let level = Commit.Level.init(rawValue: index) {
                    Image(level.emojiImageName)
                        .commitItemModifier(backgroundColor: themeType.theme[index])
                }
            }
        }
        .listRowBackground(isSelected ? Color.gray : (Color(UIColor.systemBackground)))
    }
}
