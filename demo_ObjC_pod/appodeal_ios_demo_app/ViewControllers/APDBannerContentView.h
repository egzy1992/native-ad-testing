//
//  APDBannerContentView.h
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 6/14/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDRootView.h"
#import <Appodeal/Appodeal.h>
#import <Appodeal/APDMediaView.h>

@interface APDBannerContentView : UIView

- (void) setNativeAd:(APDNativeAd *)nativeAd fromViewController:(UIViewController *)controller;

@end
