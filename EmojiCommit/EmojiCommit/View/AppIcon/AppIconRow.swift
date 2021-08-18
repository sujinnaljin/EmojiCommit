//
//  AppIconRow.swift
//  EmojiCommit
//
//  Created by 강수진 on 2021/07/14.
//

import SwiftUI
import UIKit

struct AppIconRow: View {
    private enum Constants {
        static let radius: CGFloat = 8
    }
    
    var appIcon: AppIcon
    @Binding var isSelected: Bool
    
    var body: some View {
        HStack {
            if let filePath = appIcon.filePath,
               let pathImage = UIImage(contentsOfFile: filePath) {
                Image(uiImage: pathImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(Constants.radius)
            }
            Text(appIcon.title)
            Spacer()
        }
        .contentShape(Rectangle()) // make tappable include spacer
        .listRowBackground(isSelected ? Color.gray : (Color(UIColor.systemBackground)))
    }
}
