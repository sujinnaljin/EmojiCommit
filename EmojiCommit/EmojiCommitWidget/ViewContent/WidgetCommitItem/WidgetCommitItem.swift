//
//  WidgetCommitItem.swift
//  EmojiCommit
//
//  Created by 강수진 on 2021/07/11.
//

import SwiftUI

struct WidgetCommitItem: View {
    private enum Constants {
        static let imageMaxWidth: CGFloat = 50
    }
    
    private let viewModel: WidgetCommitItemViewModel
    
    init(viewModel: WidgetCommitItemViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Image(viewModel.emojiImageName)
                .commitItemModifier(backgroundColor: viewModel.color)
                .frame(maxWidth: Constants.imageMaxWidth)
            
            Text(viewModel.weekDay)
                .font(.body)
        }
    }
}
