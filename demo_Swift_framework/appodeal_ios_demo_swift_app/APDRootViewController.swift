//
//  APDRootViewController.swift
//  appodeal_ios_demo_swift_app
//
//  Created by Lozhkin Ilya on 9/8/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

import UIKit
import Appodeal

class APDRootViewController: APDVisualRootViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
}
