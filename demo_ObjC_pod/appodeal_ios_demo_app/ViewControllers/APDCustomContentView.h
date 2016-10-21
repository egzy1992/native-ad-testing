//
//  APDCustomContentView.h
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 8/9/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDRootView.h"
#import <Appodeal/Appodeal.h>

@interface APDCustomContentView : APDRootView

@property (nonatomic, strong) UIButton * loadNativeButton;
@property (nonatomic, strong) UIButton * nextButton;
@property (nonatomic, strong) UIButton * prevButton;

@property (nonatomic, strong) UILabel * countLabel;

- (void) updateNativeViewWith:(APDNativeAd *)nativeAd onRootViewController:(UIViewController *)controller;

@end
