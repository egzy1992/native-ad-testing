//
//  APDVideoHiddenViewController.m
//  AppodealApp
//
//  Created by Lozhkin Ilya on 5/24/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDVideoHiddenViewController.h"
#import "APDVideoHiddenView.h"
#import <Appodeal/Appodeal.h>

static AppodealShowStyle style = AppodealShowStyleRewardedVideo;

@interface APDVideoHiddenViewController ()<AppodealRewardedVideoDelegate>
{
    APDVideoHiddenView * _videoHiddenView;
}

@end

@implementation APDVideoHiddenViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    
    {
        _videoHiddenView = [[APDVideoHiddenView alloc] initWithFrame:self.view.frame];
        self.view = _videoHiddenView;
    }
    
    [_videoHiddenView.showVideo addTarget:self action:@selector(showVideo:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addVideo];
}

- (void) addVideo{
    [Appodeal setRewardedVideoDelegate:self];
    [Appodeal cacheAd:AppodealAdTypeRewardedVideo];
    [_videoHiddenView setTextDescription:NSLocalizedString(@"video start load", nil)];
}

-(IBAction)showVideo:(id)sender{
    [Appodeal showAd:style rootViewController:self];
    [_videoHiddenView showTopLvlWindow];
}

#pragma mark --- REWARDED_VIDEO

- (void)rewardedVideoDidLoadAd{
    _videoHiddenView.showVideo.enabled = YES;
    [_videoHiddenView setTextDescription:NSLocalizedString(@"video did load", nil)];
}
- (void)rewardedVideoDidFailToLoadAd{
    [Appodeal cacheAd:AppodealAdTypeRewardedVideo];
    [_videoHiddenView setTextDescription:NSLocalizedString(@"video did fail to load", nil)];
}
- (void)rewardedVideoDidPresent{
    _videoHiddenView.showVideo.enabled = NO;
    [_videoHiddenView setTextDescription:NSLocalizedString(@"video did present", nil)];
}
- (void)rewardedVideoDidFinish:(NSUInteger)rewardAmount name:(NSString *)rewardName{
    [_videoHiddenView hideTopLvlWindow];
}

@end
