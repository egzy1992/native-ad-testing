//
//  APDUserDataPresentation.swift
//  appodeal_ios_demo_swift_app
//
//  Created by Lozhkin Ilya on 2/15/17.
//  Copyright © 2017 Lozhkin Ilya. All rights reserved.
//

import UIKit

class APDUserDataPresentation: APDVisualRootViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

class PressentationDataPicker: APDRootView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class PressentationDatePicker: APDRootView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class PressentationTextView: APDRootView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
