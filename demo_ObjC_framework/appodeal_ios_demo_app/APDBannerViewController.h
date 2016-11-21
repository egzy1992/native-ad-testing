//
//  BannerViewController.h
//  apd_test_project
//
//  Created by Lozhkin Ilya on 11/11/16.
//  Copyright © 2016 appodeal. All rights reserved.
//

#import "APDRootViewController.h"

@interface APDBannerViewController : APDRootViewController

@property (nonatomic, assign) BOOL custom;

+ (instancetype)bannerCustom:(BOOL)custom;

@end
