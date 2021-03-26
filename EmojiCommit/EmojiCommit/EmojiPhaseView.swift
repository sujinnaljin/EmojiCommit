//
//  EmojiPhaseView.swift
//  EmojiCommit
//
//  Created by Kang, Su Jin (강수진) on 2021/03/26.
//

import SwiftUI

struct EmojiPhase: Hashable {
    var phase: Int
    var emoji: String?
}


struct EmojiPhaseRow: View {
    var emojiPhase: EmojiPhase
    var body: some View {
        HStack {
            Text("\(emojiPhase.phase) 단계")
            Text(emojiPhase.emoji ?? "")
            Spacer()
        }
        
    }
}

struct EmojiPhaseView: View {
    //todo - UserDefault 값으로 불러오기
    @State var emojiPhases = [EmojiPhase(phase: 0, emoji: "🙆🏻‍♀️"),
                              EmojiPhase(phase: 1, emoji: "🤛🏻"),
                              EmojiPhase(phase: 2, emoji: "🌝"),
                              EmojiPhase(phase: 3, emoji: "🏄🏻"),
                              EmojiPhase(phase: 4, emoji: "⚾️")]
    @State var isShowingSheet = false
    @State var isNextButtonDisabled = true //todo 만약 이모지 다 있으면 false
    
    var body: some View {
        VStack {
            Text("커밋 단계별 이모지를 선택해주세요")
            List {
                ForEach(emojiPhases, id: \.self) { emojiPhase in
                    EmojiPhaseRow(emojiPhase: emojiPhase)
                        .contentShape(Rectangle()) //make tappable include spacer
                        .onTapGesture {
                            isShowingSheet = true
                        }
                        .sheet(isPresented: $isShowingSheet) {
                            //todo - 모달 뷰 띄우기
                        }
                }
            }
            Button("다음") {
                //todo - 다음 동작
            }.disabled(isNextButtonDisabled)
        }
    }
}

struct EmojiPhaseView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiPhaseView()
    }
}

