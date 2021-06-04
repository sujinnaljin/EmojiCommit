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
         UserDefaults.githubId != ""
    }
    
    var isEmojiSet: Bool {
        if let data = UserDefaults.shared.value(forKey: UserDefaults.Key.emojiPhases.rawValue) as? Data,
           let emojiPhases = try? PropertyListDecoder().decode([EmojiPhase].self, from: data) {
            return emojiPhases
                .map({ (emojiPhases) -> Bool in
                    // 값이 있을때 true, 없을때 false
                    emojiPhases.emoji.isNotEmpty
                })
                .allSatisfy {
                    $0 == true
                }
        } else {
            return false
        }
    }
}
