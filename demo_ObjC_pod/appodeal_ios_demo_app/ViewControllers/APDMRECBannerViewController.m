//
//  APDMRECBannerViewController.m
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 6/14/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDMRECBannerViewController.h"
#import "APDMRECBannerView.h"
#import <Appodeal/Appodeal.h>
#import <Appodeal/APDMRECView.h>

@interface APDMRECBannerViewController ()<APDBannerViewDelegate>
{
    APDMRECBannerView * _MRECview;
    APDMRECView * _bannerMRECView;
    
    NSTimer * _timer;
    CGFloat _timerDate;
}
@end

@implementation APDMRECBannerViewController

- (void) viewDidLoad {
    
    {
        self.navigationItem.title = [NSLocalizedString(@"MREC banner view", nil) uppercaseString];
    }
    
    [super viewDidLoad];
    
    {
        _MRECview = [[APDMRECBannerView alloc] initWithFrame:self.view.frame];
        self.view = _MRECview;
    }
    
    {
        [_MRECview.showMREC addTarget:self action:@selector(MRECShowClick:) forControlEvents:UIControlEventTouchUpInside];
        [_MRECview.hideMREC addTarget:self action:@selector(MRECHideClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self apd_updateButtonWithStatus:kAPD_STATUS_NILL];
}

#pragma mark --- ACTIONS

-(IBAction)MRECShowClick:(id)sender{
    
//    NSArray * dict = [NSArray array];
//    dict[5];
    
    if (!_bannerMRECView) {
        _bannerMRECView = [[APDMRECView alloc] init];
        _bannerMRECView.rootViewController = self;
        _bannerMRECView.delegate = self;
    }
    
    if (![_bannerMRECView isReady]) {
        [_bannerMRECView loadAd];
        [self apd_updateButtonWithStatus:kAPD_STATUS_LOAD];
    } else {
        [self.view addSubview:_bannerMRECView];
        [self startTimer];
        _MRECview.showMREC.enabled = NO;
        [_bannerMRECView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.size.mas_equalTo(kAPDAdSize300x250);
        }];
    }
}

-(IBAction)MRECHideClick:(id)sender{
    _bannerMRECView.hidden = YES;
    _bannerMRECView = nil;
    _MRECview.showMREC.enabled = YES;
    [self apd_updateButtonWithStatus:kAPD_STATUS_NILL];
    
    _MRECview.timerLabel.text = @"";
    [self stopTimer];

}

-(void)apd_updateButtonWithStatus:(APD_STATUS)status {
    NSString * statusString = @"";
    
    if (status == kAPD_STATUS_LOAD) {
        [_MRECview.showMREC apdSpinnerShowOnRight];
    } else {
        [_MRECview.showMREC apdSpinnerHide];
    }
    
    switch (status) {
        case kAPD_STATUS_LOAD:
        {
            statusString = @"load";
        } break;
        case kAPD_STATUS_FAIL_TO_LOAD:
        {
            statusString = @"fail";
        } break;
        case kAPD_STATUS_FAIL_TO_PRESENT:
        {
            statusString = @"fail";
        } break;
        case kAPD_STATUS_LOADED:
        {
            statusString = @"show";
        } break;
        case kAPD_STATUS_PRESENTED:
        {
            
        } break;
        case kAPD_STATUS_NILL:
        {
            statusString = @"start load";
        } break;
    }

    [_MRECview.showMREC setAttributedTitle:k_apd_mainAttributedFromMainButton([statusString uppercaseString]) forState:UIControlStateNormal];
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
    _MRECview.timerLabel.text = [NSString stringWithFormat:@"%1.1f",_timerDate];
    _timerDate += 0.2;
}


#pragma mark --- APPODEAL_BANNER_VEIW_DELEGATE

- (void)bannerViewDidLoadAd:(APDBannerView *)bannerView{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.view withMessage:@"bannerViewDidLoadAd"];
    }
    [self apd_updateButtonWithStatus:kAPD_STATUS_LOADED];
}

- (void)precacheBannerViewDidLoadAd:(APDBannerView *)precacheBannerView{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.view withMessage:@"precacheBannerViewDidLoadAd"];
    }
}

- (void)bannerViewDidRefresh:(APDBannerView *)bannerView{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.view withMessage:@"bannerViewDidRefresh"];
    }
    [self startTimer];
}

- (void)bannerView:(APDBannerView *)bannerView didFailToLoadAdWithError:(NSError *)error{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.view withMessage:@"bannerView didFailToLoadAdWithError"];
    }
    [self apd_updateButtonWithStatus:kAPD_STATUS_FAIL_TO_LOAD];
    _bannerMRECView = nil;
}

- (void)bannerViewDidReceiveTapAction:(APDBannerView *)bannerView{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.view withMessage:@"bannerViewDidReceiveTapAction"];
    }
}

@end
