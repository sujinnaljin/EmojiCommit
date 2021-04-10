//
//  LoginView.swift
//  EmojiCommit
//
//  Created by Kang, Su Jin (강수진) on 2021/03/22.
//

import SwiftUI

struct LoginView: View {
    
    //todo AppStorage 로 하면 바로 업데이트가 안된다..!
    //@AppStorage("githubId") var githubId: String = ""
    @State private var githubId: String = ""
    
    var body: some View {
        GeometryReader { geometry in
                VStack {
                    Spacer()
                    TextField("github 아이디를 입력하세요", text: $githubId)
                        .padding()
                        .multilineTextAlignment(.center)
                    Spacer()
                    
                    //MARK: - Bottom Next Link
                    //todo 네비게이션이 아니라 root 뷰를 바꿔야함
                    NavigationLink(destination: CommitView(githudId: githubId)){
                        BottomNextView(geometry: geometry,
                                       isNextEnabled: !githubId.isEmpty)
                            .navigationTitle("github 아이디 입력 👩🏻‍💻")
                    }
                    .disabled(githubId.isEmpty)
                }
                .edgesIgnoringSafeArea(.bottom)
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
