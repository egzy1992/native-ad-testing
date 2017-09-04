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
    
    func createAlertForPlacement (showStyle: AppodealShowStyle, rootController: UIViewController) {
        let alert = UIAlertController(title: "Setting the placement", message: "Enter the placement name", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = ""
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            if ((textField?.text?.isEmpty))! {
                Appodeal.showAd(showStyle, rootViewController: rootController);
            }
            else {
                Appodeal.showAd(showStyle, forPlacement: textField?.text, rootViewController: rootController)
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
