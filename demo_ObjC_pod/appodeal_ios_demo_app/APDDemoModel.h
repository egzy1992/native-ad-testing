//
//  APDDemoModel.h
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 11/18/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import <Appodeal/Appodeal.h>
#import <Foundation/Foundation.h>

@interface NetworkProperty : NSObject

@property (nonatomic, strong, readonly) NSString * networkPrettyName;
@property (nonatomic, strong, readonly) NSString * networkName;
@property (nonatomic, assign, getter=isChecked) BOOL checked;

- (instancetype)initWithName:(NSString *)prettyName name:(NSString *)name;

@end

@interface APDDemoModel : NSObject

@property (nonatomic, assign) BOOL interstitial;
@property (nonatomic, assign) BOOL banner;
@property (nonatomic, assign) BOOL rewardedVideo;
@property (nonatomic, assign) BOOL MREC;
@property (nonatomic, assign) BOOL nativeAds;

@property (nonatomic, assign) AppodealAdType adType;
@property (nonatomic, assign, getter=isLocationTracking) BOOL locationTracking;
@property (nonatomic, assign) BOOL autoCache;
@property (nonatomic, assign) BOOL userSettings;
@property (nonatomic, assign) BOOL testMode;
@property (nonatomic, assign) BOOL toastMode;

@property (nonatomic, assign) BOOL bannerSmartSize;
@property (nonatomic, assign) BOOL bannerAnimation;
@property (nonatomic, assign) BOOL bannerBackground;

@end
