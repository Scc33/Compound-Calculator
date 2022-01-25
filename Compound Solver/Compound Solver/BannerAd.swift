//
//  BannerAd.swift
//  Compound Solver
//
//  Created by Sean Coughlin on 1/25/22.
//

import SwiftUI
import GoogleMobileAds
import UIKit

final private class BannerVC: UIViewControllerRepresentable  {
    func makeUIViewController(context: Context) -> UIViewController {
        let view = GADBannerView(adSize: GADAdSizeBanner)

        let viewController = UIViewController()
        //NOTE NOT MY AD ID VALUE
        view.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        view.rootViewController = viewController
        viewController.view.addSubview(view)
        viewController.view.frame = CGRect(origin: .zero, size: GADAdSizeBanner.size)
        view.load(GADRequest())

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

struct Banner:View {
    var body: some View{
        HStack{
            Spacer()
            BannerVC().frame(width: 320, height: 50, alignment: .center)
            Spacer()
        }
    }
}

struct Banner_Previews: PreviewProvider {
    static var previews: some View {
        Banner()
    }
}
