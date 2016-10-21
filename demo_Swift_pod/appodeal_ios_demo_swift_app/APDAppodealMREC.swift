//
//  APDAppodealMREC.swift
//  appodeal_ios_demo_swift_app
//
//  Created by Lozhkin Ilya on 9/9/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

import UIKit
import Appodeal

class APDAppodealMREC: APDRootViewController, AppodealBannerViewDelegate {
    
    var appodealMracViewModel : APDAppodealMRECViewModel!
    var mrecView : AppodealMRECView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appodealMracViewModel = APDAppodealMRECViewModel.init(frame: self.view.frame)
        self.view = appodealMracViewModel
        
        mrecView = AppodealMRECView(rootViewController: self)
        
        mrecView.setDelegate(self)
        mrecView.loadAd()
    }

    func bannerViewDidLoadAd(_ bannerView: APDBannerView!){
        self.view.addSubview(mrecView)
        mrecView.center = self.view.center
    }
    func bannerView(_ bannerView: APDBannerView!, didFailToLoadAdWithError error: Error!){
        
    }
    func bannerViewDidInteract(_ bannerView: APDBannerView!){
        
    }
}

class APDAppodealMRECViewModel: APDRootView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
