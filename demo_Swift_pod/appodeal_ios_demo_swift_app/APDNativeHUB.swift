//
//  APDNativeHUB.swift
//  appodeal_ios_demo_swift_app
//
//  Created by Lozhkin Ilya on 9/9/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

import UIKit

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
        self.navigationController?.pushViewController(nextController, animated: true)
    }
}

class APDNativeHUBView: APDRootView {
    
    var nativeOnViewButton : UIButton = APDRootView.apd_mainButtonWith("native".uppercased())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(nativeOnViewButton)
        nativeOnViewButton.frame = CGRect.init(x: 0, y: 0, width: 250, height: 50)
        nativeOnViewButton.center = self.center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
