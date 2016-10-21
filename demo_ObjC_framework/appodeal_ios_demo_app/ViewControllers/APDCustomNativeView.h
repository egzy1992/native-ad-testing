//
//  APDCustomNativeView.h
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 8/9/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Appodeal/Appodeal.h>

@interface APDCustomNativeView : UIView

- (void) setNativeAd:(APDNativeAd *)nativeAd fromViewController:(UIViewController *)controller;

@end
