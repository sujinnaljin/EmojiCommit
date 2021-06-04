//
//  EmojiCommitEntryView.swift
//  EmojiCommitWidgetExtension
//
//  Created by 강수진 on 2021/05/18.
//

import SwiftUI
import WidgetKit

struct EmojiCommitEntryView: View {
    var entry: EmojiCommitProvider.Entry
    @Environment(\.widgetFamily) private var widgetFamily
    
    var body: some View {
        switch widgetFamily {
        case .systemSmall:
            CommitItem(viewModel: .init(commit: entry.commits.last!))
        case .systemMedium:
            HStack {
                ForEach(entry.commits.suffix(7)) { commit in
                    CommitItem(viewModel: .init(commit: commit))
                }
            }
        case .systemLarge:
            Text(entry.date, style: .time)
        }
    }
}

struct EmojiCommitEntryView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiCommitEntryView(entry: EmojiCommitEntry(date: Date(), commits: []))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
