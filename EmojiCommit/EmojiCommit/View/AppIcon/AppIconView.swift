//
//  AppIconView.swift
//  EmojiCommit
//
//  Created by 강수진 on 2021/07/14.
//

import SwiftUI

struct AppIconView: View {
    
    private enum Constants {
        static let rowHeight: CGFloat = 50
    }
    
    @StateObject var viewModel: AppIconViewModel
    
    var body: some View {
        GeometryReader { (geometry) in
            NavigationView {
                VStack(spacing: 0) {
                    // MARK: - List
                    // TODO: - 버전 올린 다음에 List Binding으로 처리
                    List {
                        Section(header: Text("")) {
                            ForEach(viewModel.appIcons, id: \.self) { appIcon in
                                AppIconRow(appIcon: appIcon,
                                           isSelected: .constant(appIcon == viewModel.selectedAppIcon))
                                    .frame(height: Constants.rowHeight)
                                    .onTapGesture {
                                        viewModel.apply(.selectAppIcon(appIcon))
                                    }
                            }
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                    .navigationTitle(viewModel.title)
                    .alert(isPresented: $viewModel.isErrorShown, content: { () -> Alert in
                        Alert(title: Text(viewModel.errorTitle),
                              message: Text(viewModel.errorMessage))
                    })
                    
                    // MARK: - Banner
                    Banner()
                    
                    // MARK: - Bottom Next Link
                    BottomNextView(geometry: geometry,
                                   isNextEnabled: viewModel.isNextEnabled)
                        
                        .onTapGesture {
                            self.viewModel.apply(.next)
                        }
                }
                .edgesIgnoringSafeArea(.bottom)
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}
