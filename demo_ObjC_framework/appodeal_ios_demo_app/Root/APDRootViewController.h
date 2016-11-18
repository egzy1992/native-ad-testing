//
//  APDRootViewController.h
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 6/10/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppodealToast.h"
#import <Appodeal/Appodeal.h>

@interface APDRootViewController : UIViewController

@property (nonatomic, assign) BOOL toastMode;
@property (nonatomic, assign) APDNativeAdType nativeType;
@property (nonatomic, assign, readonly, getter=isDeprecateApi) BOOL deprecateApi;

-(void) apdBannerViewOnBottom;

- (void)wasInitializedLikeDeprecated;

@end
