//
//  CommitRouter.swift
//  EmojiCommit
//
//  Created by 강수진 on 2021/08/11.
//

import SwiftUI

final class CommitRouter {
    public static func sheetView(type: CommitViewModel.SheetType,
                                 commitViewModel: CommitViewModel) -> some View {
        return CommitSheetView(viewType: type)
            .environmentObject(commitViewModel)
    }
}
