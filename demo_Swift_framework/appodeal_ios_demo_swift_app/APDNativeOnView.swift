//
//  APDNativeOnView.swift
//  appodeal_ios_demo_swift_app
//
//  Created by Lozhkin Ilya on 9/9/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

import UIKit
import Appodeal

class APDNativeOnView: APDRootViewController {
    
    var isAdQueue : Bool!
    var capacity : Int = 1
    var type : APDNativeAdType = .auto
    
    fileprivate var appodealNativeViewModel : APDNativeOnViewModelView!
    private var apdLoader : APDNativeAdLoader! = APDNativeAdLoader()
    private var apdAdQueue : APDNativeAdQueue = APDNativeAdQueue()
    
    fileprivate var apdNativeArray : [APDNativeAd]! = Array()
    
    fileprivate lazy  var slider : UISlider = UISlider.init(frame: CGRect(x: (UIScreen.main.bounds.width - 200) / 2,
                                                                      y: UIScreen.main.bounds.height - 65,
                                                                      width: 200,
                                                                      height: 35))
    private lazy var countLabel : UILabel = UILabel(frame: CGRect(x: (UIScreen.main.bounds.width - 200) / 2,
                                                                  y: UIScreen.main.bounds.height - 100,
                                                                  width: 200,
                                                                  height: 34))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appodealNativeViewModel = APDNativeOnViewModelView.init(frame: self.view.frame)
        self.view.addSubview(appodealNativeViewModel)
        appodealNativeViewModel.isHidden = true
        
        createControls()
        setAvailableAdCount(0)
        
        guard !isAdQueue else {
            apdAdQueue.delegate = self
            apdAdQueue.setMaxAdSize(capacity)
            apdAdQueue.loadAd(of: type)
            return
        }
        
        apdLoader.delegate = self
        apdLoader.loadAd(with: type, capacity: capacity)
    }
    
    func createControls() {
        
        slider.value = 1;
        slider.tintColor = UIColor.red
        slider.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)
        
        countLabel.font = UIFont.systemFont(ofSize: 26)
        countLabel.textColor = UIColor.darkText
        countLabel.textAlignment = .center
        
        view.addSubview(slider)
        view.addSubview(countLabel)
    }
    
    func setAvailableAdCount(_ count : Int) {
        guard count > 0 else {
            countLabel.isHidden = true
            slider.isHidden = true
            return
        }
        
        countLabel.isHidden = false
        slider.isHidden = count <= 1
        
        let currentAd = Int(slider.value)
        countLabel.text = String(format: "%d/%d", currentAd, count)
        slider.maximumValue = Float(count)
        slider.minimumValue = Float(1)
        
//        slider.value = Float(currentAd)
    }
    
    func sliderChanged() {
        let currentAd = Int(slider.value) - 1
        
        if currentAd > apdNativeArray.count - 1{
            let nativeAd : [APDNativeAd]! = apdAdQueue.getNativeAds(ofCount: 1)
            
            let _ = apdNativeArray.map {( $0.delegate = self )}
            apdNativeArray.append(contentsOf:nativeAd)
        }
        
        if isAdQueue == true {
            countLabel.text = String(format: "%d/%d", Int(slider.value), Int(apdNativeArray.count + apdAdQueue.currentAdCount))
        } else {
            countLabel.text = String(format: "%d/%d", Int(slider.value), Int(apdNativeArray.count))
        }
        
        appodealNativeViewModel.customNativeView.setNativeAd(apdNativeArray[currentAd % apdNativeArray.count], withViewController: self)
    }
}

extension APDNativeOnView : APDNativeAdLoaderDelegate {
    
    func nativeAdLoader(_ loader: APDNativeAdLoader!, didLoad nativeAds: [APDNativeAd]!) {
        apdNativeArray = nativeAds
        let _ = nativeAds.map {( $0.delegate = self )}
        appodealNativeViewModel.isHidden = false;
        setAvailableAdCount(nativeAds.count)
        appodealNativeViewModel.customNativeView.setNativeAd(apdNativeArray.first!, withViewController: self)
    }
    
    func nativeAdLoader(_ loader: APDNativeAdLoader!, didFailToLoadWithError error: Error!){
        setAvailableAdCount(0)
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

extension APDNativeOnView : APDNativeAdQueueDelegate {
    
    func adQueue(_ adQueue: APDNativeAdQueue!, failedWithError error: Error!) {
        setAvailableAdCount(0)
    }
    
    func adQueueAdIsAvailable(_ adQueue: APDNativeAdQueue!, ofCount count: Int) {
//        apdNativeArray.append(contentsOf:adQueue.getNativeAds(ofCount: count))
//        let _ = apdNativeArray.map {( $0.delegate = self )}
        
        appodealNativeViewModel.isHidden = false;
        
        if apdNativeArray.count > 0 {
            setAvailableAdCount(apdNativeArray.count + count)
        } else {
            apdNativeArray.append(contentsOf:adQueue.getNativeAds(ofCount: 1))
            let _ = apdNativeArray.map {( $0.delegate = self )}
            setAvailableAdCount(count)
            
            let currentAd = Int(slider.value) - 1
            appodealNativeViewModel.customNativeView.setNativeAd(apdNativeArray[currentAd], withViewController: self)
        }
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
    var iconSizeLabel : UILabel!
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
        
        iconSizeLabel = UILabel()
        iconSizeLabel.font = UIFont.boldSystemFont(ofSize: 8)
        iconSizeLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        iconSizeLabel.numberOfLines = 2
        iconSizeLabel.textAlignment = NSTextAlignment.left
        iconSizeLabel.textColor = UIColor.white
        iconSizeLabel.backgroundColor = UIColor.black
        
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
        iconSizeLabel.text = "main:\(nativeAd.mainImage.size.width)x\(nativeAd.mainImage.size.height)\nicon:\(nativeAd.iconImage.size.width)x\(nativeAd.iconImage.size.height)";
    }
    
    func nativeElementSetPosition() {
        
        self.addSubview(mediaView)
        self.addSubview(callToActionLabel)
        self.addSubview(adBadgeLabel)
        self.addSubview(titleLabel)
        self.addSubview(descriptionLabel)
        self.addSubview(iconSizeLabel)
        
        let width : CGFloat = UIScreen.main.bounds.size.width
        let height : CGFloat = width * 9 / 16
        
        self.mediaView.frame = CGRect.init(x: 0, y: 0, width: width, height: height)
        self.callToActionLabel.frame = CGRect.init(x: self.frame.width - 125, y: height + 25, width: 120, height: 30)
        self.adBadgeLabel.frame = CGRect.init(x: self.frame.width  - 30, y: height + 5,width: 25,height: 12);
        self.titleLabel.frame = CGRect.init(x: 5, y: height + 5, width: self.frame.size.width - 100,height: 15);
        self.descriptionLabel.frame = CGRect.init(x: 5, y: height + self.titleLabel.frame.height + 10,width: self.frame.width - 130, height: 40);
        self.iconSizeLabel.frame = CGRect.init(x: self.frame.size.width - 120, y: height, width: 95,height: 20);
    }
}
