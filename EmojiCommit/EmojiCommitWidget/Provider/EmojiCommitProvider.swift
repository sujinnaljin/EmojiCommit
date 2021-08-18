//
//  EmojiCommitProvider.swift
//  EmojiCommit
//
//  Created by 강수진 on 2021/05/18.
//

import Foundation
import WidgetKit
import Combine

// 위젯을 새로고침 및 업데이트 하는 타이밍을 정의하는 부분
// TimelineProvider는 Widget의 디스플레이를 업데이트 할 시기를 WidgetKit에 알려주는 타입
class EmojiCommitProvider: TimelineProvider {
    
    typealias Entry = EmojiCommitEntryViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    // 0. 위젯 추가하기 전에 place holder
    // context: Widget이 렌더링되는 방법에 대한 세부 정보가 포함된 객체
    // 여기가 어떻게 설정되어있느냐에 따라서 place holder 가 다르게 보이는 듯
    func placeholder(in context: Context) -> Entry {
        let defaultDate = Date()
        let defualtCommit = (0...6).map { (day) -> Commit in
            let nextDate = Calendar.current.date(byAdding: .day, value: day, to: defaultDate)
            let commit = Commit(date: nextDate ?? defaultDate, level: .zero)
            return commit
        }
        return Entry(date: Date(), commits: defualtCommit)
    }
    
    // 1. 위젯의 현재 상태를 나타내는 즉각적인 스냅샷 -> 사용자가 위젯을 추가할때 맨 처음으로
    // 데이터를 로드하는 데 시간이 좀 걸리는 경우 (ex. 서버에서 데이터 가져오는 경우) 샘플데이터를 대신 사용
    func getSnapshot(in context: Context, completion: @escaping (Entry) -> Void) {
        // 유저가 위젯 추가할때 미리보기로 보이는 데이터
        let defaultDate = Date()
        let defualtCommit = (0...6).map { (day) -> Commit in
            let nextDate = Calendar.current.date(byAdding: .day, value: day, to: defaultDate)
            let commit = Commit(date: nextDate ?? defaultDate,
                                level: Commit.Level(rawValue: day % 5) ?? .zero)
            return commit
        }
        
        let entry = Entry(date: Date(), commits: defualtCommit)
        completion(entry)
    }
    
    // 2. 현재 상태랑 미래의 상태들을 나타내는 entry 배열 -> 사용자가 위젯을 추가한 다음부터
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        
        let currentDate = Date()
        let refreshDate = Calendar.current.date(byAdding: .minute, value: 1, to: currentDate)!
        let githubId =  UserDefaults.githubId ?? ""
        
        GithubService(apiService: APIService(),
                      environment: .production)
            .getCommits(id: githubId)
            .map {
                Timeline(entries: [Entry(date: currentDate,
                                         commits: $0)],
                         policy: .after(refreshDate))
            }
            .replaceError(with: Timeline(entries: [Entry(date: currentDate,
                                                         commits: [])],
                                         policy: .after(refreshDate)))
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: completion)
            .store(in: &subscriptions)
    }
}
