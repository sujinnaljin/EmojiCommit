//
//  EmojiCommitEntry.swift
//  EmojiCommit
//
//  Created by 강수진 on 2021/05/18.
//

import Foundation
import WidgetKit

// 업데이트 타이밍 정보(date)를 가지고 있다. 즉, WidgetKit이 widget을 rendering 할 date
struct EmojiCommitEntry: TimelineEntry {
    var date: Date
    var commits: [Commit]
}
