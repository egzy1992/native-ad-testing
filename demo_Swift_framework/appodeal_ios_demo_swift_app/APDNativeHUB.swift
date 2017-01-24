//
//  APDNativeHUB.swift
//  appodeal_ios_demo_swift_app
//
//  Created by Lozhkin Ilya on 9/9/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

import UIKit
import Appodeal


class APDNativeHUB: APDRootViewController {

    var nativeViewHUBView : APDNativeHUBView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nativeViewHUBView = APDNativeHUBView.init(frame: self.view.frame)
        nativeViewHUBView.nativeOnViewButton.addTarget(self, action: #selector(nativeOnViewButtonClick(sender:)), for: UIControlEvents.touchUpInside)
        self.view = nativeViewHUBView
    }
    
    func nativeOnViewButtonClick(sender : AnyObject)  {
        let nextController : APDNativeOnView = APDNativeOnView()
        nextController.capacity = nativeViewHUBView.capacity
        nextController.type = nativeViewHUBView.selectedType

        self.navigationController?.pushViewController(nextController, animated: true)
    }
}

class APDNativeHUBView: APDRootView {
    
    var nativeOnViewButton : UIButton!
    var capacitySlider : UISlider!
    private var segmentedControl : UISegmentedControl!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSlider()
        createSegmentedControl()
        createButton()
    }
    
    var selectedType : APDNativeAdType {
        get {
            switch segmentedControl.selectedSegmentIndex {
                case 1 :
                    return .video
                case 2 :
                    return .noVideo
                default :
                    return .auto
            }
        }
    }
    
    var capacity : Int {
        get {
            return Int(capacitySlider.value)
        }
    }
    
    var screenWidth : CGFloat {
        get {
            return UIScreen.main.bounds.width
        }
    }
    
    var screenHeight : CGFloat {
        get {
            return UIScreen.main.bounds.height
        }
    }
    
    func createButton() {
        nativeOnViewButton = APDRootView.apd_mainButtonWith(String(format: "load native ad of count %d", capacity).uppercased())
        nativeOnViewButton.frame = CGRect.init(x: 0, y: 0, width: 325, height: 50)
        nativeOnViewButton.center = self.center
        addSubview(nativeOnViewButton)
    }
    
    func createSlider() {
        capacitySlider = UISlider.init(frame: CGRect(x: (screenWidth - 200) / 2,
                                                     y: screenHeight - 65,
                                                     width: 200,
                                                     height: 35))
        capacitySlider.maximumValue = 8
        capacitySlider.minimumValue = 1
        
        capacitySlider.tintColor = UIColor.red
        capacitySlider.value = 5
        capacitySlider.addTarget(self, action: #selector(capacitySliderChanged), for: .valueChanged)
        addSubview(capacitySlider)
    }
    
    func createSegmentedControl() {
        let items = ["Auto", "Video", "Static"]
        segmentedControl = UISegmentedControl(items: items)
        segmentedControl.frame = CGRect(x: (screenWidth - 320) / 2,
                                        y: 65,
                                        width: 320,
                                        height: 33)
        
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.tintColor = UIColor.red
        
        segmentedControl.clipsToBounds = true
        
        segmentedControl.layer.cornerRadius = 4.0
        segmentedControl.layer.borderWidth = 1.0
        segmentedControl.layer.borderColor = UIColor.red.cgColor
        addSubview(segmentedControl)
    }
    
    func capacitySliderChanged() {
        let attrTitle = APDRootView.apd_mainAttributedFromMainButton(String(format: "load native ad of count %d", capacity).uppercased())
        nativeOnViewButton.setAttributedTitle(attrTitle, for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
