//
//  EmojiCommitProvider.swift
//  EmojiCommit
//
//  Created by 강수진 on 2021/05/18.
//

import Foundation
import WidgetKit

// 위젯을 새로고침 및 업데이트 하는 타이밍을 정의하는 부분
// TimelineProvider는 Widget의 디스플레이를 업데이트 할 시기를 WidgetKit에 알려주는 타입
struct EmojiCommitProvider: TimelineProvider {
    typealias Entry = EmojiCommitEntry
    // 0. 위젯 추가하기 전에 place holder
    // context: Widget이 렌더링되는 방법에 대한 세부 정보가 포함된 객체
    func placeholder(in context: Context) -> EmojiCommitEntry {
        EmojiCommitEntry(date: Date())
    }

    // 1. 위젯의 현재 상태를 나타내는 즉각적인 스냅샷 -> 사용자가 위젯을 추가할때 맨 처음으로
    // 데이터를 로드하는 데 시간이 좀 걸리는 경우 (ex. 서버에서 데이터 가져오는 경우) 샘플데이터를 대신 사용
    func getSnapshot(in context: Context, completion: @escaping (EmojiCommitEntry) -> Void) {
        let entry = EmojiCommitEntry(date: Date())
        completion(entry)
    }

    // 2. 현재 상태랑 미래의 상태들을 나타내는 entry 배열 -> 사용자가 위젯을 추가한 다음부터
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        var entries: [EmojiCommitEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for minuteOffset in stride(from: 0, to: 60, by: 10) {
            let entryDate = Calendar.current.date(byAdding: .minute, value: minuteOffset, to: currentDate)!
            let entry = EmojiCommitEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}
