//
//  APDSVC.m
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 8/29/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDSVC.h"
#import "Masonry.h"
#import <Appodeal/Appodeal.h>

@interface APDSVC () <APDBannerViewDelegate, AppodealBannerDelegate, AppodealRewardedVideoDelegate>
{
    NSInteger _testNumber;
    UIViewController * _videoCrashController;
}

@end

@implementation APDSVC

- (void)viewDidLoad {
    {
        self.navigationItem.title = [NSLocalizedString(@"SVC", nil) uppercaseString];
    }
    [super viewDidLoad];
    
    {
        self.view.backgroundColor = UIColor.whiteColor;
    }
    
    { // 1 test
        [self testOne];
    }
    
    { // 2 test
//        [self testTwo];
    }
    
    { // 3 test
//        [self testThree];
    }
}

- (void) testOne { // hide banner appodealBanner
    _testNumber = 1;
    
    [self apdBannerViewOnBottom];
    [Appodeal setBannerDelegate:self];
}

- (void) testTwo { // hide [Appodeal hideBanner]
    _testNumber = 2;
    
    [self apdBannerViewOnBottom];
    
    UIButton * newButton = k_apd_mainButtonWithTitle([NSLocalizedString(@"hide banner", nil) uppercaseString]);
    [newButton addTarget:self action:@selector(hideBannerClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:newButton];
    
    [newButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(@200);
    }];
}

- (void) testThree {
    _testNumber = 3;
    
    [Appodeal setRewardedVideoDelegate:self];
    [Appodeal showAd:AppodealShowStyleRewardedVideo rootViewController:self];
}

#pragma mark --- Actions

- (IBAction)hideBannerClick:(id)sender {
    [Appodeal hideBanner];
}

#pragma mark --- AppodealBannerDelegate
- (void)bannerDidShow {
    
    switch (_testNumber) {
        case 1:
        {
            UIView * newView = [[UIView alloc] initWithFrame:self.view.frame];
            newView.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.5];
            [self.view addSubview:newView];
            [self.view insertSubview:newView atIndex:[[self.view subviews] count] - 1];
            
        } break;
        case 2:
        {
            
        }
            break;
        default:
            break;
    }
    
    
}

#pragma mark --- AppodealRewardedVideoDelegate

- (void) rewardedVideoDidLoadAd {
    switch (_testNumber) {
        case 3:
        {
//            UIViewController * rootController = [(UIViewController *)[UIApplication sharedApplication].delegate presentedViewController];
            if (!_videoCrashController) {
                _videoCrashController = [UIViewController new];
                _videoCrashController.modalPresentationStyle = UIModalPresentationFullScreen;
                
                [self presentViewController:_videoCrashController animated:YES completion:^{
                    [Appodeal showAd:AppodealShowStyleRewardedVideo rootViewController:_videoCrashController];
                }];
            } else {
                [Appodeal showAd:AppodealShowStyleRewardedVideo rootViewController:_videoCrashController];
            }
        } break;
            
        default:
            break;
    }
}

@end
