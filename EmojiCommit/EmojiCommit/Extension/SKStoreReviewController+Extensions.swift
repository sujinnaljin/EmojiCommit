//
//  SKStoreReviewController+Extensions.swift
//  EmojiCommit
//
//  Created by 강수진 on 2021/07/19.
//

import StoreKit

extension SKStoreReviewController {
    public static func requestReviewInCurrentScene() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            requestReview(in: scene)
        }
    }
}
