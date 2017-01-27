//
//  APDRootViewController.swift
//  appodeal_ios_demo_swift_app
//
//  Created by Lozhkin Ilya on 9/8/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

import UIKit
import Appodeal

class APDDemoModel: NSObject {
    var interstitial : Bool
    var banner : Bool
    var rewardedVideo : Bool
    var MREC : Bool
    var nativeAds : Bool

    var adType : AppodealAdType = []
    var locationTracking : Bool
    var autoCache : Bool

    var userSettings : Bool
    var testMode : Bool
    var toastMode : Bool

    var bannerSmartSize : Bool
    var bannerAnimation : Bool
    var bannerBackground : Bool

    override init() {
        interstitial = true
        banner = true
        rewardedVideo = true
        MREC = true
        nativeAds = true

        adType = [.interstitial, .rewardedVideo, .banner, .MREC, .nativeAd]
        locationTracking = false
        autoCache = true

        userSettings = true
        testMode = false
        toastMode = true

        bannerSmartSize = true
        bannerAnimation = false
        bannerBackground = false
    }
}

class APDRootViewController: UIViewController {

    public enum APD_STATUS : Int {
        case kAPD_STATUS_LOAD
        case kAPD_STATUS_FAIL_TO_LOAD
        case kAPD_STATUS_FAIL_TO_PRESENT
        case kAPD_STATUS_LOADED
        case kAPD_STATUS_PRESENTED
        case kAPD_STATUS_NILL
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.setNeedsStatusBarAppearanceUpdate()

        let titleLabel : UILabel = UILabel()
        let attributes : NSDictionary = [NSForegroundColorAttributeName : UINavigationBar.appearance().tintColor,
                                         NSFontAttributeName : UIFont.systemFont(ofSize: 18.0),
                                         NSKernAttributeName : 2]

        if self.navigationItem.title != nil {
            titleLabel.attributedText = NSAttributedString.init(string: self.navigationItem.title!, attributes: (attributes as! [String : AnyObject]))
            titleLabel.sizeToFit()
            self.navigationItem.titleView = titleLabel
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
    }
}
