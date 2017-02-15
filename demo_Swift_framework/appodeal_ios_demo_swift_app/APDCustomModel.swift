//
//  APDCustomModel.swift
//  appodeal_ios_demo_swift_app
//
//  Created by Lozhkin Ilya on 2/15/17.
//  Copyright © 2017 Lozhkin Ilya. All rights reserved.
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
        
        testMode = false
        toastMode = true
        
        bannerSmartSize = true
        bannerAnimation = false
        bannerBackground = false
    }
}

class APDUserDataModel: NSObject {
    var userSettings : Bool
    
    override init () {
        userSettings = true
    }
}
