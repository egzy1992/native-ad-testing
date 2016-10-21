//
//  APDStartScreen.swift
//  appodeal_ios_demo_swift_app
//
//  Created by Lozhkin Ilya on 9/8/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

import UIKit

class APDStartScreen: APDRootViewController {
    
    var startScreenView : APDStartScreenView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startScreenView = APDStartScreenView.init(frame: self.view.frame)
        startScreenView.appodealApiButton.addTarget(self, action:#selector(appodealApiClick),for: UIControlEvents.touchUpInside)
        self.view = startScreenView
    }
    
    func appodealApiClick(){
        let nextController : APDAppodealConfiguration! = APDAppodealConfiguration();
        nextController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve;
        self.navigationController?.pushViewController(nextController, animated: true)
    }
}

class APDStartScreenView: APDRootView {
    
    var appodealApiButton : UIButton = APDRootView.apd_mainButtonWith("api v0.10.x".uppercased())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(appodealApiButton)
        appodealApiButton.frame = CGRect.init(x: 0, y: 0, width: 250, height: 50)
        appodealApiButton.center = self.center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
