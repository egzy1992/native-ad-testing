//
//  APDVisualRootViewController.swift
//  appodeal_ios_demo_swift_app
//
//  Created by Lozhkin Ilya on 2/15/17.
//  Copyright © 2017 Lozhkin Ilya. All rights reserved.
//

import UIKit

class APDVisualRootViewController: UIViewController {

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
