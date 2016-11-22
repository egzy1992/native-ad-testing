//
//  APDDemoModel.m
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 11/18/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDDemoModel.h"

@interface NetworkProperty ()

@property (nonatomic, strong, readwrite) NSString * networkPrettyName;
@property (nonatomic, strong, readwrite) NSString * networkName;

@end


@implementation NetworkProperty

- (instancetype) initWithName:(NSString *)prettyName name:(NSString *)name {
    self = [super init];
    if (self) {
        self.networkPrettyName = prettyName;
        self.networkName = name;
        self.checked = NO;
    }
    return self;
}

@end

@implementation APDDemoModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.interstitial = YES;
        self.banner = YES;
        self.rewardedVideo = YES;
        self.MREC = YES;
        self.nativeAds = YES;
        
        self.adType = AppodealAdTypeMREC | AppodealAdTypeInterstitial | AppodealAdTypeBanner | AppodealAdTypeNativeAd | AppodealAdTypeRewardedVideo;
        self.locationTracking = NO;
        self.autoCache = YES;
        self.userSettings = YES;
        self.testMode = NO;
        self.toastMode = YES;
        
        self.bannerBackground = NO;
        self.bannerAnimation = NO;
        self.bannerSmartSize = YES;
    }
    return self;
}

@end
