//
//  EmojiPhaseView.swift
//  EmojiCommit
//
//  Created by Kang, Su Jin (강수진) on 2021/03/26.
//

import SwiftUI

struct EmojiPhase: Codable {
    var phase: Int = 0 //todo phase 없어도 될거같은데?
    var emoji: String
    
    init(phase: Int, emoji: String) {
        self.phase = phase
        self.emoji = emoji
    }
}

struct EmojiPhaseRow: View {
    var emojiPhase: EmojiPhase
    var body: some View {
        HStack {
            Text("\(emojiPhase.phase) 단계")
            Text(emojiPhase.emoji.isEmpty ? "선택이 필요합니다" : emojiPhase.emoji)
            Spacer()
        }
    }
}

struct EmojiPhaseView: View {
    
    @Binding var emojiPhases: [EmojiPhase]
    @State private var isShowingSheet = false
    @State private var selectedIndex: Int?
    
    //todo 바깥으로 빼서 true 일때는 처음 뷰가 달라지게해야함
    private var isNextEnabled: Bool {
        emojiPhases.map { (emojiPhase) in
            // 값이 있을때 true, 없을때 false
            !emojiPhase.emoji.isEmpty
        }.reduce(true) {
            //하나라도 false 이면 모두 false
            $0 && $1
        }
    }
    
    var body: some View {
        GeometryReader { (geometry) in
            NavigationView {
                VStack(spacing: 0) {
                    //MARK: - Text
                    Text("최근 선택한 index는 " + (selectedIndex?.description ?? "없습니다"))
                    
                    //MARK: - List
                    List(emojiPhases.indices, id: \.self) { index in
                        EmojiPhaseRow(emojiPhase: emojiPhases[index])
                            .contentShape(Rectangle()) //make tappable include spacer
                            .onTapGesture {
                                selectedIndex = index
                                isShowingSheet = true
                            }
                    }
                    .listStyle(InsetGroupedListStyle())
                    .sheet(isPresented: $isShowingSheet) {
                        if let selectedIndex = selectedIndex {
                            EmojiListView(emojiPhase: $emojiPhases[selectedIndex],
                                          isShowingSheet: $isShowingSheet)
                        }
                    }
                    
                    //MARK: - Bottom Next Link
                    NavigationLink(destination: LoginView()) {
                        BottomNextView(geometry: geometry,
                                       isNextEnabled: isNextEnabled)
                            .navigationTitle("이모지 선택 😎")
                    }
                    .disabled(!isNextEnabled)
                }
                .edgesIgnoringSafeArea(.bottom)
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
    
}

struct EmojiPhaseView_Previews: PreviewProvider {
    static let phaseArray = [EmojiPhase(phase: 0, emoji: ""),
                             EmojiPhase(phase: 1, emoji: ""),
                             EmojiPhase(phase: 2, emoji: ""),
                             EmojiPhase(phase: 3, emoji: ""),
                             EmojiPhase(phase: 4, emoji: "")]
    
    static var previews: some View {
        EmojiPhaseView(emojiPhases: .constant(phaseArray))
    }
}

