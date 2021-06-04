//
//  EmojiCommitWidget.swift
//  EmojiCommitWidget
//
//  Created by 강수진 on 2021/05/18.
//

import WidgetKit
import SwiftUI

// Widget 프로토콜은 Widget의 컨텐츠를 나타내는 configuration 타입 -> WidgetConfiguration 타입의 body 를 require
@main
struct EmojiCommitWidget: Widget {
    let kind: String = "com.sujinnaljin.EmojiCommit"

    var body: some WidgetConfiguration {
        // StaticConfiguration은 사용자가 구성 할 수 있는 프로퍼티(ser-configurable properties)가 없는 위젯. 단순 정보 표시 <-> IntentConfiguration
        // kind : 모든 Widget에는 고유한 문자열이 존재. 이 문자열을 가지고 위젯을 식별. 이왕이면 Bundle Identifier를 사용
        // provider : 위젯을 새로고침할 타임라인을 결정하는 객체. 위젯 업데이트를 위한 미래 날짜를 주면 시스템이 새로 고침 프로세스를 최적화 가능
        // content : WidgetKit이 Widget을 렌더링하는데 필요한 SwiftUI View가 포함. WidgetKit은 이 closure를 호출할 때, Widget Provider의 getSnapshot(in:completion:) 또는 getTimeline(in:completion:) 메소드로 타임라인 항목들을 전달
        StaticConfiguration(kind: kind,
                            provider: EmojiCommitProvider()) { entry in
            EmojiCommitEntryView(entry: entry)
        }
        .configurationDisplayName("Emoji Commit Widget")
        .description("위젯으로 이모지 커밋을 설정해보세요!")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}
