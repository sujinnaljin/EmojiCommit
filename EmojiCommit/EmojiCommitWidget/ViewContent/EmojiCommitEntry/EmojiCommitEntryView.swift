//
//  EmojiCommitEntryView.swift
//  EmojiCommitWidgetExtension
//
//  Created by 강수진 on 2021/05/18.
//

import SwiftUI
import WidgetKit

struct EmojiCommitEntryView: View {
    @Environment(\.widgetFamily) private var widgetFamily
    let entry: EmojiCommitEntryViewModel
    
    var body: some View {
        if !entry.isGithubIdSet {
            Text("github ID 세팅을 완료해주세요 😞")
        } else if !entry.isValidGithubId {
            Text("github ID 를 확인해주세요 😞")
        } else {
            switch widgetFamily {
            case .systemSmall:
                WidgetCommitItem(viewModel: .init(commit: entry.commits.last!))
            case .systemMedium:
                HStack {
                    ForEach(entry.commits.suffix(7)) { commit in
                        WidgetCommitItem(viewModel: .init(commit: commit))
                    }
                }
                .padding(.horizontal, 10)
            case .systemLarge:
                Text(entry.date, style: .time)
            }
        }
    }
}
