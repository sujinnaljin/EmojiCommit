//
//  EmojiPhaseView.swift
//  EmojiCommit
//
//  Created by Kang, Su Jin (강수진) on 2021/03/26.
//

import SwiftUI

struct EmojiPhase {
    var phase: Int = 0 //todo phase 없어도 될거같은데?
    var emoji: String
    
    init(phase: Int, emoji: String) {
        self.phase = phase
        self.emoji = emoji
    }
}

class EmojiPhaseViewViewModel: ObservableObject {
    @Published var emojiPhases: [EmojiPhase]

    init(emojiPhases: [EmojiPhase]){
        self.emojiPhases = emojiPhases
    }
}

struct EmojiPhaseRow: View {
    var emojiPhase: EmojiPhase
    var body: some View {
        HStack {
            Text("\(emojiPhase.phase) 단계")
            Text(emojiPhase.emoji)
            Spacer()
        }
    }
}

struct EmojiPhaseView: View {
    //todo - 2순위 UserDefault 값으로 불러오기@@@
    @ObservedObject var emojiPhaseViewModel: EmojiPhaseViewViewModel
    @State private var isShowingSheet = false
    @State private var isNextButtonEnabled = false //todo 만약 이모지 다 있으면 true
    @State private var selectedIndex: Int?
    
    var body: some View {
        VStack {
            Text("최근 선택한 index는 " + (selectedIndex?.description ?? "없습니다"))
            List(emojiPhaseViewModel.emojiPhases.indices, id: \.self) { index in
                EmojiPhaseRow(emojiPhase: emojiPhaseViewModel.emojiPhases[index])
                    .contentShape(Rectangle()) //make tappable include spacer
                    .onTapGesture {
                        selectedIndex = index
                        isShowingSheet = true
                    }
            }.sheet(isPresented: $isShowingSheet) {
                if let selectedIndex = selectedIndex {
                    EmojiListView(emojiPhase: $emojiPhaseViewModel.emojiPhases[selectedIndex],
                                  isShowingSheet: $isShowingSheet)
                }
            }
            Button("다음") {
                //todo - 다음 동작
            }.disabled(!isNextButtonEnabled)
            
        }
    }
}

struct EmojiPhaseView_Previews: PreviewProvider {
    static let phaseArray = [EmojiPhase(phase: 0, emoji: "🙆🏻‍♀️"),
                             EmojiPhase(phase: 1, emoji: "🇶🇦"),
                             EmojiPhase(phase: 2, emoji: "🇫🇴"),
                             EmojiPhase(phase: 3, emoji: "🏁"),
                             EmojiPhase(phase: 4, emoji: "🟣")]
    
    static var previews: some View {
        EmojiPhaseView(emojiPhaseViewModel: EmojiPhaseViewViewModel(emojiPhases: phaseArray))
    }
}

