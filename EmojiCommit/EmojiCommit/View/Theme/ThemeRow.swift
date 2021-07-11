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
            ForEach(theme.images, id: \.self) { imageName in
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        .listRowBackground(isSelected ? Color.gray : (Color(UIColor.systemBackground)))
    }
}
