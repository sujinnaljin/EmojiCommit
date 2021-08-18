//
//  Image+Extensions.swift
//  EmojiCommit
//
//  Created by 강수진 on 2021/07/17.
//

import SwiftUI

extension Image {
    private enum Constants {
        static let radius: CGFloat = 10
    }
    
    func commitItemModifier(backgroundColor color: String) -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .background(Color(hex: color))
            .cornerRadius(Constants.radius)
    }
}
