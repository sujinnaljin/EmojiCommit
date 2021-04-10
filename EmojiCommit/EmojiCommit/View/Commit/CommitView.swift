//
//  CommitView.swift
//  EmojiCommit
//
//  Created by Kang, Su Jin (강수진) on 2021/04/06.
//

import SwiftUI

//todo SwiftLint 적용
struct CommitView: View {
    
    //todo grid 형태 viewModifier 로 재정의해야할거같다. emojilist 랑 겹쳐서
    private enum Constants {
        static let columnCount = 7
        static let emojiSpacing: CGFloat = 5
        static let emojiLineSpacing: CGFloat = 10
        static let emojiWidth: CGFloat = (UIScreen.main.bounds.size.width - CGFloat(columnCount)*emojiSpacing) / CGFloat(columnCount)
    }
    
    @State private var isUserValid = false
    @State private var isEmojiValid = false
    @StateObject var viewModel: CommitViewModel
    
    //todo AppStorage를 쓰려면 이렇게 쓰는게 맞나?
    @AppStorage("emojiPhases") var emojiPhases: [EmojiPhase] = []
    
    init(githudId: String) {
        _viewModel = StateObject(wrappedValue: CommitViewModel.init(userId: githudId))
    }
    
    // MARK: - Grid 형태 정의
    private var columns: [GridItem] {
        let grids = (0..<Constants.columnCount).map { (_) in
            GridItem(.fixed(Constants.emojiWidth), spacing:Constants.emojiSpacing)
        }
        return grids
    }
    
    var body: some View {
        //todo
        //githubId랑 emoji 설정 둘다 되어있는지 체크해야함. -> 없을때 뷰
        //404 에러일때 github id 다시 입력하도록
        //500 에러일때 탭해서 다시 네트워크 요청하도록
        //safe area 무시하고 넘어간다
        VStack {
            ScrollView {
                LazyVGrid(columns: columns,
                          spacing: Constants.emojiLineSpacing) {
                    ForEach(viewModel.commits) { commit in
                        VStack {
                            Text(emojiPhases[commit.level.rawValue].emoji)
                            Text(commit.date.month.description
                                    + "/"
                                    + commit.date.day.description)
                        }
                        
                    }
                }
            }
        }
        .alert(isPresented: $viewModel.isErrorShown, content: { () -> Alert in
            Alert(title: Text("Error"), message: Text(viewModel.errorMessage))
        })
        .navigationBarTitle(Text("Commits"))
        .onAppear(perform: { self.viewModel.apply(.onAppear) })
    }
}

struct CommitView_Previews: PreviewProvider {
    static var previews: some View {
        CommitView(githudId: "sujinnaljin")
    }
}
