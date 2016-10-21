//
//  APDBannerContentViewController.m
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 6/14/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDBannerContentViewController.h"
#import "APDBannerContentView.h"

@interface APDBannerContentViewController () <APDNativeAdLoaderDelegate>
{
    APDNativeAdLoader * _nativeAdLoader;
    NSMutableArray * _nativeAdArray;
}

@end

@implementation APDBannerContentViewController

- (void) viewDidLoad {
    
    {
        self.navigationItem.title = [NSLocalizedString(@"Content Banner", nil) uppercaseString];
    }
    
    [super viewDidLoad];
    
    {
        self.view.backgroundColor = UIColor.whiteColor;
    }
    
    {
        _nativeAdLoader = [APDNativeAdLoader new];
        _nativeAdLoader.delegate = self;
        [_nativeAdLoader loadAdWithType:self.nativeType];
    }
}

- (void) bannerViewWithAd:(APDNativeAd *)nativeAd{
    
    APDBannerContentView * bannerContentView = [[APDBannerContentView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 50)];
    [self.view addSubview: bannerContentView];
    
    [bannerContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.height.equalTo(@52);
        make.width.equalTo(self.view).with.offset(-50);
        make.bottom.equalTo(self.view).with.offset(-2);
    }];
    
    [bannerContentView setNativeAd:nativeAd fromViewController:self];
}

#pragma mark --- NATIVE_AD_LOADER_DELEGATE

- (void)nativeAdLoader:(APDNativeAdLoader *)loader didLoadNativeAd:(APDNativeAd *)nativeAd{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.view withMessage:@"nativeAdLoader didLoadNativeAd"];
    }
    
    _nativeAdArray = [NSMutableArray array];
    [_nativeAdArray addObject:nativeAd];
    
    [self bannerViewWithAd:nativeAd];
}

- (void)nativeAdLoader:(APDNativeAdLoader *)loader didFailToLoadWithError:(NSError *)error{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.view withMessage:@"nativeAdLoader didFailToLoadWithError"];
    }
}

@end
