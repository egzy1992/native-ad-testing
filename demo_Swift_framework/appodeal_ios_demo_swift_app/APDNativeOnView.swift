//
//  APDNativeOnView.swift
//  appodeal_ios_demo_swift_app
//
//  Created by Lozhkin Ilya on 9/9/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

import UIKit
import Appodeal

class APDNativeOnView: APDRootViewController, APDNativeAdLoaderDelegate {

    fileprivate var appodealNativeViewModel : APDNativeOnViewModelView!
    private var apdLoader : APDNativeAdLoader! = APDNativeAdLoader()
    fileprivate var apdNativeArray : [APDNativeAd]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appodealNativeViewModel = APDNativeOnViewModelView.init(frame: self.view.frame)
        self.view.addSubview(appodealNativeViewModel)
        appodealNativeViewModel.isHidden = true
        
        apdLoader.delegate = self
        apdLoader.loadAd(with: APDNativeAdType.auto)
        
    }
    
    func nativeAdLoader(_ loader: APDNativeAdLoader!, didLoad nativeAds: [APDNativeAd]!) {
        apdNativeArray = nativeAds
        let _ = nativeAds.map {( $0.delegate = self )}
        appodealNativeViewModel.isHidden = false;
        appodealNativeViewModel.customNativeView.setNativeAd(apdNativeArray.first!, withViewController: self)
    }
    
    func nativeAdLoader(_ loader: APDNativeAdLoader!, didFailToLoadWithError error: Error!){
        
    }
}

extension APDNativeOnView : APDNativeAdPresentationDelegate {
    
    func nativeAdWillLogImpression(_ nativeAd: APDNativeAd!) {
        print("nativeAdWillLogImpression at index ", apdNativeArray.index(of: nativeAd)!)
    }
    
    func nativeAdWillLogUserInteraction(_ nativeAd: APDNativeAd!) {
        print("nativeAdWillLogUserInteraction ", apdNativeArray.index(of: nativeAd)!)
    }
}

class APDNativeOnViewModelView: APDRootView {
    
    var customNativeView : APDNativeCustonView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let width : CGFloat = UIScreen.main.bounds.size.width
        let height : CGFloat = 50 + width * 9 / 16
        customNativeView = APDNativeCustonView.init(frame: CGRect.init(x: 0, y: 0, width: width, height: height))
        customNativeView.center = self.center
        self.addSubview(customNativeView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class APDNativeCustonView : UIView {
    
    var iconView : UIImageView!
    var titleLabel : UILabel!
    var descriptionLabel : UILabel!
    var mediaView : APDMediaView!
    var callToActionLabel : UILabel!
    var adBadgeLabel : UILabel!
    var nativeAd : APDNativeAd!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        mediaView = APDMediaView.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
//        mediaView.type = APDMediaViewType.mainImage
//        mediaView.skippable = true
//        mediaView.muted = false
        
        adBadgeLabel = UILabel()
        adBadgeLabel.backgroundColor = UIColor.darkGray
        adBadgeLabel.text = "Ad"
        adBadgeLabel.textColor = UIColor.white
        adBadgeLabel.textAlignment = NSTextAlignment.center
        adBadgeLabel.font = UIFont.systemFont(ofSize: 10)
        adBadgeLabel.layer.cornerRadius = 2.0

        titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.textColor = UIColor.darkGray
        
        callToActionLabel = UILabel()
        callToActionLabel.textColor = UIColor.darkGray
        callToActionLabel.textAlignment = NSTextAlignment.center
        callToActionLabel.font = UIFont.boldSystemFont(ofSize: 14)
        callToActionLabel.layer.cornerRadius = 5.0
        callToActionLabel.layer.borderWidth = 2.0
        callToActionLabel.layer.borderColor = UIColor.darkGray.cgColor
 
        descriptionLabel = UILabel()
        descriptionLabel.font = UIFont.boldSystemFont(ofSize: 14)
        descriptionLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        descriptionLabel.numberOfLines = 3
        descriptionLabel.textAlignment = NSTextAlignment.left
        descriptionLabel.textColor = UIColor.gray
 
        self.nativeElementSetPosition()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setNativeAd(_ nativeAD : APDNativeAd, withViewController controller : UIViewController) {
        if nativeAd != nil {
            nativeAd.detachFromView()
        }
        
        nativeAd = nativeAD;
        nativeAd.attach(to: self, viewController: controller)
        
        mediaView.setNativeAd(nativeAd, rootViewController: controller)
        
        titleLabel.text = self.nativeAd.title;
        descriptionLabel.text = self.nativeAd.descriptionText;
        callToActionLabel.text = self.nativeAd.callToActionText;
    }
    
    func nativeElementSetPosition() {
        
        self.addSubview(mediaView)
        self.addSubview(callToActionLabel)
        self.addSubview(adBadgeLabel)
        self.addSubview(titleLabel)
        self.addSubview(descriptionLabel)
        
        let width : CGFloat = UIScreen.main.bounds.size.width
        let height : CGFloat = width * 9 / 16
        
        self.mediaView.frame = CGRect.init(x: 0, y: 0, width: width, height: height)
        self.callToActionLabel.frame = CGRect.init(x: self.frame.width - 125, y: height + 25, width: 120, height: 30)
        self.adBadgeLabel.frame = CGRect.init(x: self.frame.width  - 30, y: height + 5,width: 25,height: 12);
        self.titleLabel.frame = CGRect.init(x: 5, y: height + 5, width: self.frame.size.width - 100,height: 15);
        self.descriptionLabel.frame = CGRect.init(x: 5, y: height + self.titleLabel.frame.height + 10,width: self.frame.width - 130, height: 40);
    }
}
