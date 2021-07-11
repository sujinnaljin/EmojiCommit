//
//  EmojiCommitEntryViewModel.swift
//  EmojiCommitWidgetExtension
//
//  Created by 강수진 on 2021/06/05.
//

import WidgetKit

struct GitHubContributionsWidgetViewModel: TimelineEntry {
    let date: Date
    let commits: [Commit]
    
    var isValidGithubId: Bool {
        !commits.isEmpty
    }
    
    var isGithubIdSet: Bool {
        !UserDefaults.githubId.isNil
    }
}
