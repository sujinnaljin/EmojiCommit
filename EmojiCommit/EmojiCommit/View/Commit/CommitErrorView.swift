//
//  CommitErrorView.swift
//  EmojiCommit
//
//  Created by 강수진 on 2021/04/30.
//

import SwiftUI

struct CommitErrorView: View {
    let viewModel: CommitErrorViewModel
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Text(viewModel.errorEmoji)
                    .font(.system(size: 300))
                Text(viewModel.errorText)
                    .font(.title)
                    .padding(.horizontal, 32)
            }
            .position(
                x: proxy.size.width / 2,
                y: proxy.size.height / 2
            )
        }
    }
}

struct CommitErrorView_Previews: PreviewProvider {
    static var previews: some View {
        CommitErrorView(viewModel: CommitErrorViewModel.init(error: .clientError))
    }
}
