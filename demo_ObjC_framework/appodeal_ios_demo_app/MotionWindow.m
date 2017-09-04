//
//  MotionWindow.m
//  appodeal_ios_demo_app
//
//  Created by Stas Kochkin on 26/04/2017.
//  Copyright © 2017 Lozhkin Ilya. All rights reserved.
//

#import "MotionWindow.h"

@implementation MotionWindow

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    switch (motion) {
        case UIEventSubtypeMotionShake:
            [[NSNotificationCenter defaultCenter] postNotificationName:@"DemoAppShaked" object:nil];
            break;
            
        default:
            break;
    }
}

@end
