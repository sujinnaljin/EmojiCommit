//
//  RootViewModel.swift
//  EmojiCommit
//
//  Created by Kang, Su Jin (강수진) on 2021/05/04.
//

import Foundation

class RootViewModel: ObservableObject {
    @Published var viewType: RootViewType
    
    init(viewType: RootViewType) {
        self.viewType = viewType
    }
}
