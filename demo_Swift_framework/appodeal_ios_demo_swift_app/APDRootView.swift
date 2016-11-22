//
//  APDRootView.swift
//  appodeal_ios_demo_swift_app
//
//  Created by Lozhkin Ilya on 9/8/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

import UIKit

class APDRootView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func apd_mainButtonWith(_ title : String) -> UIButton {
        let button : UIButton = UIButton.init(type: UIButtonType.custom)
        let attrString : NSAttributedString = APDRootView.apd_mainAttributedFromMainButton(title)
        button.setAttributedTitle(attrString, for: UIControlState.normal)
        
        button.clipsToBounds = true;
        button.layer.cornerRadius = 4.0
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.lightGray.cgColor
        
        return button;
    }
    
    class func apd_mainAttributedFromMainButton(_ title : String) -> NSAttributedString {
        return NSAttributedString.init(string: title, attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 20.0, weight: UIFontWeightLight),
                                                                   NSKernAttributeName : 2,
                                                                   NSForegroundColorAttributeName : UIColor.lightGray])
    }
    
    func headerView(withTitle title:String, tintColor : UIColor, fontSize : CGFloat, backgroundColor : UIColor) -> UIView {
        let newLabel : UILabel = UILabel()
        let view : UIView = UIView()
        view.backgroundColor = backgroundColor
        view.addSubview(newLabel)
        
        newLabel.attributedText = NSAttributedString.init(string: title,
                                                          attributes: [
                                                            NSForegroundColorAttributeName : tintColor,
                                                            NSFontAttributeName : UIFont.systemFont(ofSize: fontSize),
                                                            NSKernAttributeName : 2.0])
        return view;
    }
}

class APDDescriptionCell : UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
