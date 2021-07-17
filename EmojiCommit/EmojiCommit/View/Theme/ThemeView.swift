//
//  ThemeView.swift
//  EmojiCommit
//
//  Created by 강수진 on 2021/07/11.
//

import SwiftUI

struct ThemeView: View {
    @StateObject var viewModel: ThemeViewModel
    
    var body: some View {
         GeometryReader { (geometry) in
            NavigationView {
                VStack(spacing: 0) {
                    // MARK: - List
                    // TODO: - 버전 올린 다음에 List Binding으로 처리
                    List {
                        ForEach(viewModel.themes.indices) { index in
                            Section(header: Text(viewModel.themes[index].title)) {
                                ThemeRow(theme: viewModel.themes[index],
                                         isSelected: .constant(viewModel.selectedIndex == index))
                                    .onTapGesture {
                                        viewModel.apply(.selectIndex(index))
                                    }
                                    
                            }
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                    
                    // MARK: - AdBanner
                    if viewModel.isShowBanner {
                        AdBanner()
                    }
                    
                    // MARK: - Bottom Next Link
                    NavigationLink(destination: LoginView(viewModel: .init(isShowBanner: false))) {
                        BottomNextView(geometry: geometry,
                                       isNextEnabled: viewModel.isNextEnabled)
                            .navigationTitle(viewModel.title)
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        self.viewModel.apply(.next)
                    })
                    .disabled(!viewModel.isNextEnabled)
                }
                .edgesIgnoringSafeArea(.bottom)
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}
