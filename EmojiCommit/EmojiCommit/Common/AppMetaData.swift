//
//  AppMetaData.swift
//  EmojiCommit
//
//  Created by 강수진 on 2021/08/22.
//

import UIKit

enum AppMetaData {
    static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"]
    static let iOSVersion = UIDevice.current.systemVersion
    static let deviceType = UIDevice.type
}
