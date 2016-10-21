//
//  APDBannerPresentationViewController.m
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 6/13/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDBannerPresentationViewController.h"
#import "APDBannerPresentationView.h"
#import <Appodeal/Appodeal.h>

@interface APDBannerPresentationViewController () <AppodealBannerDelegate>
{
    APDBannerPresentationView * _bannerPresentationView;
    
    APDBannerView * _bannerView;
    
    NSTimer * _timer;
    CGFloat _timerDate;
}
@end

@implementation APDBannerPresentationViewController

- (void) viewDidLoad {
    
    {
        self.navigationItem.title = [NSLocalizedString(@"Banner Presentation AD", nil) uppercaseString];
    }
    
    [super viewDidLoad];
    
    {
        _bannerPresentationView = [[APDBannerPresentationView alloc] initWithFrame:self.view.frame];
        self.view = _bannerPresentationView;
    }
    
    {
        [_bannerPresentationView.bannerTop addTarget:self action:@selector(bannerTopClick:) forControlEvents:UIControlEventTouchUpInside];
        [_bannerPresentationView.bannerBottom addTarget:self action:@selector(bannerBottomClick:) forControlEvents:UIControlEventTouchUpInside];
        [_bannerPresentationView.hideBanner addTarget:self action:@selector(bannerHideClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    {
        [Appodeal setBannerDelegate:self];
    }
}

- (void) viewDidDisappear:(BOOL)animated{
    [self bannerHideClick:nil];
}

#pragma mark --- ACTIONS

-(IBAction)bannerTopClick:(id)sender{
    [Appodeal showAd:AppodealShowStyleBannerTop rootViewController:self];
}

-(IBAction)bannerBottomClick:(id)sender{
    [Appodeal showAd:AppodealShowStyleBannerBottom rootViewController:self];
}

-(IBAction)bannerHideClick:(id)sender{
    [Appodeal hideBanner];
    _bannerPresentationView.timerLabel.text = @"";
    [self stopTimer];
}

#pragma mark --- TIMER

- (void) initializeTimer{
    _timerDate = 0.0f;
    _timer = [NSTimer timerWithTimeInterval:0.2 target:self selector:@selector(timerTick:) userInfo:nil repeats:YES];
}

- (void) startTimer{
    if (!_timer) {
        [self initializeTimer];
    } else {
        [_timer invalidate];
        [self initializeTimer];
    }
    
    NSRunLoop *runner = [NSRunLoop currentRunLoop];
    [runner addTimer:_timer forMode: NSDefaultRunLoopMode];
    
    [_timer fire];
}

- (void) stopTimer{
    [_timer invalidate];
    _timer = nil;
}

- (void) timerTick:(id)object{
    _bannerPresentationView.timerLabel.text = [NSString stringWithFormat:@"%1.1f",_timerDate];
    _timerDate += 0.2;
}

#pragma mark --- APPODEAL_BANNER_DELEGATE

- (void)bannerDidLoadAdIsPrecache:(BOOL)precache{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.view withMessage:@"bannerDidLoadAdisPrecache"];
    }
}

- (void)bannerDidLoadAd { // deprecate
    if (self.toastMode) {
        [AppodealToast showToastInView:self.view withMessage:@"bannerDidLoadAd"];
    }
}

- (void)bannerDidFailToLoadAd{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.view withMessage:@"bannerDidFailToLoadAd"];
    }
}
- (void)bannerDidClick{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.view withMessage:@"bannerDidClick"];
    }
}

- (void)bannerDidRefresh{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.view withMessage:@"bannerDidRefresh"];
    }
    
    [self startTimer];
}

- (void)bannerDidShow{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.view withMessage:@"bannerDidShow"];
    }
    
    [self startTimer];
}

@end
