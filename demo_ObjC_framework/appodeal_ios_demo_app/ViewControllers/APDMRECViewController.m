//
//  APDMRECBannerViewController.m
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 6/14/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDMRECViewController.h"
#import <Appodeal/Appodeal.h>
#import "Masonry.h"

@interface APDMRECViewController ()<APDBannerViewDelegate, AppodealBannerViewDelegate>
{
    AppodealMRECView * _bannerMRECView;
    APDMRECView * _apdBannerMRECView;
    
    NSTimer * _timer;
    CGFloat _timerDate;
}

@property (nonatomic, strong) UIButton * showMREC;
@property (nonatomic, strong) UIButton * hideMREC;
@property (nonatomic, strong) UILabel * timerLabel;

@end

@implementation APDMRECViewController

- (void) viewDidLoad {
    
    {
        self.navigationItem.title = [NSLocalizedString(@"MREC banner view", nil) uppercaseString];
    }
    
    [super viewDidLoad];
    
    {
        self.view.backgroundColor = UIColor.whiteColor;
    }
    
    {
        [self.showMREC addTarget:self action:@selector(MRECShowClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.hideMREC addTarget:self action:@selector(MRECHideClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self apd_updateButtonWithStatus:kAPD_STATUS_NILL];
}

-(void)updateViewConstraints{
    [self.showMREC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_centerX).with.offset(-5);
        make.top.equalTo(self.view).with.offset(80);
        make.width.equalTo(@170);
    }];
    
    [self.hideMREC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_centerX).with.offset(5);
        make.top.equalTo(self.view).with.offset(80);
        make.width.equalTo(@170);
    }];
    
    [self.timerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_centerY).with.offset(-130);
        make.width.equalTo(@200);
    }];
    [super updateViewConstraints];
}

#pragma mark --- PROPERTY

- (UIButton *) showMREC {
    if (!_showMREC) {
        _showMREC = k_apd_mainButtonWithTitle([NSLocalizedString(@"show MREC", nil) uppercaseString]);
        [self.view addSubview:_showMREC];
    }
    return _showMREC;
}

- (UIButton *) hideMREC {
    if (!_hideMREC) {
        _hideMREC = k_apd_mainButtonWithTitle([NSLocalizedString(@"hide MREC", nil) uppercaseString]);
        [self.view addSubview:_hideMREC];
    }
    return _hideMREC;
}

- (UILabel *) timerLabel{
    if (!_timerLabel) {
        _timerLabel = [UILabel new];
        _timerLabel.textAlignment = NSTextAlignmentCenter;
        _timerLabel.font = [UIFont systemFontOfSize:80.0f weight:UIFontWeightLight];
        _timerLabel.textColor = UIColor.lightGrayColor;
        [self.view addSubview:_timerLabel];
    }
    return _timerLabel;
}

#pragma mark --- ACTIONS

-(IBAction)MRECShowClick:(id)sender{
    
    if (self.deprecateApi) {
        if (!_bannerMRECView) {
            _bannerMRECView = [[AppodealMRECView alloc] initWithRootViewController:self];
            _bannerMRECView.delegate = self;
        }
        
        if (![_bannerMRECView isReady]) {
            [_bannerMRECView loadAd];
            [self apd_updateButtonWithStatus:kAPD_STATUS_LOAD];
        } else {
            [self.view addSubview:_bannerMRECView];
            [self startTimer];
            self.showMREC.enabled = NO;
            [_bannerMRECView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(self.view);
                make.size.mas_equalTo(kAPDAdSize300x250);
            }];
        }
        return;
    }
    
    if (!_apdBannerMRECView) {
        _apdBannerMRECView = [[APDMRECView alloc] init];
        _apdBannerMRECView.rootViewController = self;
        _apdBannerMRECView.delegate = self;
    }
    
    if (![_apdBannerMRECView isReady]) {
        [_apdBannerMRECView loadAd];
        [self apd_updateButtonWithStatus:kAPD_STATUS_LOAD];
    } else {
        [self.view addSubview:_apdBannerMRECView];
        [self startTimer];
        self.showMREC.enabled = NO;
        [_apdBannerMRECView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
            make.size.mas_equalTo(kAPDAdSize300x250);
        }];
    }
}

-(IBAction)MRECHideClick:(id)sender{
    if (self.deprecateApi) {
        _bannerMRECView.hidden = YES;
        _bannerMRECView = nil;
    } else {
        _apdBannerMRECView.hidden = YES;
        _apdBannerMRECView = nil;
    }
    
    self.showMREC.enabled = YES;
    [self apd_updateButtonWithStatus:kAPD_STATUS_NILL];
    
    self.timerLabel.text = @"";
    [self stopTimer];

}

-(void)apd_updateButtonWithStatus:(APD_STATUS)status {
    NSString * statusString = @"";
    
    if (status == kAPD_STATUS_LOAD) {
        [self.showMREC apdSpinnerShowOnRight];
    } else {
        [self.showMREC apdSpinnerHide];
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

    [self.showMREC setAttributedTitle:k_apd_mainAttributedFromMainButton([statusString uppercaseString]) forState:UIControlStateNormal];
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
    self.timerLabel.text = [NSString stringWithFormat:@"%1.1f",_timerDate];
    _timerDate += 0.2;
}


#pragma mark --- APPODEAL_BANNER_VEIW_DELEGATE

- (void)bannerViewDidLoadAd:(APDBannerView *)bannerView{ //
    if (self.toastMode) {
        [AppodealToast showToastInView:self.view withMessage:@"MREC DidLoadAd"];
    }
    [self apd_updateButtonWithStatus:kAPD_STATUS_LOADED];
}

- (void)precacheBannerViewDidLoadAd:(APDBannerView *)precacheBannerView{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.view withMessage:@"precache MREC DidLoadAd"];
    }
}

- (void)bannerViewDidRefresh:(APDBannerView *)bannerView{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.view withMessage:@"MREC DidRefresh"];
    }
    [self startTimer];
}

- (void)bannerView:(APDBannerView *)bannerView didFailToLoadAdWithError:(NSError *)error{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.view withMessage:@"MREC didFailToLoadAdWithError"];
    }
    [self apd_updateButtonWithStatus:kAPD_STATUS_FAIL_TO_LOAD];

//    if (self.deprecateApi) {
//       _bannerMRECView = nil;
//    } else {
//        _apdBannerMRECView = nil;
//    }
}

- (void)bannerViewDidReceiveTapAction:(APDBannerView *)bannerView{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.view withMessage:@"MREC DidReceiveTapAction"];
    }
}

#pragma mark ----

- (void)bannerViewDidInteract:(APDBannerView *)bannerView{
    [self bannerViewDidReceiveTapAction:bannerView];
}

@end
