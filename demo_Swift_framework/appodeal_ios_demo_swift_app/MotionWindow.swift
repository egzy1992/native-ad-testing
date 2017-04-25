//
//  MotionWindow.swift
//  appodeal_ios_demo_swift_app
//
//  Created by Stas Kochkin on 25/04/2017.
//  Copyright © 2017 Lozhkin Ilya. All rights reserved.
//

import UIKit

class MotionWindow: UIWindow {

    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        switch motion {
        case .motionShake:
            NotificationCenter.default.post(name: Notification.Name(rawValue: "AppShaked"), object: nil)
        default:
            break
        }
    }
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.

}
