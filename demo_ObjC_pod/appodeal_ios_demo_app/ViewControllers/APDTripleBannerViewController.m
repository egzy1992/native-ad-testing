//
//  APDTripleBannerViewController.m
//  AppodealApp
//
//  Created by Lozhkin Ilya on 5/24/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDTripleBannerViewController.h"
#import "APDTripleBanerView.h"
#import <Appodeal/Appodeal.h>
#import <Appodeal/APDBannerView.h>

@interface APDTripleBannerViewController ()<APDBannerViewDelegate>
{
    APDTripleBanerView * _tripleBannerView;
    APDBannerView * _cachingBanner;
    NSUInteger _bannerCount;
}
@end

@implementation APDTripleBannerViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    
    {
        _bannerCount = 0;
    }
    {
        _tripleBannerView = [[APDTripleBanerView alloc] initWithFrame:self.view.frame];
        self.view = _tripleBannerView;
    }
    
    
    [self addAppodealBanner];
}

- (void) addAppodealBanner{
    BOOL isTablet = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ? NO : YES;
    APDBannerView * banner = [[APDBannerView alloc] initWithSize:CGSizeMake(CGRectGetWidth(_tripleBannerView.frame), isTablet ? 90 : 50)];
    banner.delegate = self;
    banner.rootViewController = self;
    
    [banner loadAd];
    _cachingBanner = banner;
}

- (void)bannerViewDidLoadAd:(APDBannerView *)bannerView{
    _bannerCount += 1;
    [_tripleBannerView addSubview:bannerView];
    bannerView.frame = CGRectOffset(bannerView.frame, 0, _tripleBannerView.center.y + _bannerCount * (IS_IPAD ? 120 : 75));
    [_tripleBannerView setCount:_bannerCount];
    if (_bannerCount < 3) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self addAppodealBanner];
        });
    }
}

- (void)bannerView:(APDBannerView *)bannerView didFailToLoadAdWithError:(NSError *)error {
    
}

@end
