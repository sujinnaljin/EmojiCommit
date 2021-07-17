//
//  AdBanner.swift
//  EmojiCommit
//
//  Created by 강수진 on 2021/07/15.
//

import UIKit
import SwiftUI
import GoogleMobileAds
import AppTrackingTransparency
import AdSupport

struct AdBanner: View {
    enum Constants {
        static let width: CGFloat = 320
        static let height: CGFloat = 50
    }
    
    var body: some View {
        AdBannerVC()
            .frame(width: Constants.width,
                   height: Constants.height,
                   alignment: .center)
    }
}

final private class AdBannerVC: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> UIViewController {
        
        #if DEBUG
        let bannerID = "ca-app-pub-3940256099942544/2435281174"
        #else
        let bannerID = "ca-app-pub-9883195223600770/8092424771"
        
        #endif

        // Create a GADBannerView (in code or interface builder) and set the ad unit ID on it.
        let bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.adUnitID = bannerID
        
        let viewController = UIViewController()
        bannerView.rootViewController = viewController
        viewController.view.addSubview(bannerView)
        viewController.view.frame = CGRect(origin: .zero, size: kGADAdSizeBanner.size)

        // Create an ad request and load the adaptive banner ad.
        ATTrackingManager.requestTrackingAuthorization(completionHandler: { _ in
            bannerView.load(GADRequest())
        })

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
