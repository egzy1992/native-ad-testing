//
//  APDBannerView.swift
//  appodeal_ios_demo_swift_app
//
//  Created by Lozhkin Ilya on 9/9/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

import UIKit
import Appodeal

class APDBanner: APDRootViewController, APDBannerViewDelegate {

    var apdBannerViewModel : APDBannerViewModel!
    var bannerView : APDBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apdBannerViewModel = APDBannerViewModel.init(frame: self.view.frame)
        self.view = apdBannerViewModel
        
        bannerView = APDBannerView.init(size: kAPDAdSize320x50)
        bannerView.delegate = self
        bannerView.rootViewController = self
        bannerView.center = self.view.center
        bannerView.loadAd()
        bannerView.requestDelegate = self
        self.view.addSubview(bannerView)
    }
    
    func bannerViewDidLoadAd(_ bannerView: APDBannerView!){
        
    }
    func precacheBannerViewDidLoadAd(_ precacheBannerView: APDBannerView!){
        
    }
    func bannerViewDidRefresh(_ bannerView: APDBannerView!){
        
    }
    func bannerView(_ bannerView: APDBannerView!, didFailToLoadAdWithError error: Error!){
        
    }
    func bannerViewDidReceiveTapAction(_ bannerView: APDBannerView!){
        
    }
}

extension APDBanner : APDBannerViewRequestDelegate {
    func bannerViewDidStartMediation(_ bannerView: APDBannerView!) {
        print("[RRI] Banner mediation started")
    }
    
    func bannerView(_ bannerView: APDBannerView!, willSendRequestToAdNetwork adNetwork: String!) {
        print("[RRI] Banner send request to network ", adNetwork)
    }
    
    func bannerView(_ bannerView: APDBannerView!, didRecieveResponseFromAdNetwork adNetwork: String!, wasFilled filled: Bool) {
        print("[RRI] Banner send request to network ", adNetwork, " was filled ", filled ? "yes" : "no")
    }
    
    func bannerView(_ bannerView: APDBannerView!, didFinishMediationAdWasFilled filled: Bool) {
        print("[RRI] Banner mediation finished, ad was filled ", filled ? "yes" : "no")
    }
    
    func bannerView(_ bannerView: APDBannerView!, logImpressionForAdNetwork adNetwork: String!) {
        print("[RRI] Banner log impression for network ", adNetwork)
    }
    
    func bannerView(_ bannerView: APDBannerView!, logClickForAdNetwork adNetwork: String!) {
        print("[RRI] Banner log click for network ", adNetwork)
    }
}

class APDBannerViewModel: APDRootView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
