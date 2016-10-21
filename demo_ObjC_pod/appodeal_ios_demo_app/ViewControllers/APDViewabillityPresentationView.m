//
//  APDViewabillityPresentationView.m
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 8/9/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDViewabillityPresentationView.h"

@implementation APDViewabillityPresentationView

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bannerHiddenButton];
        [self addSubview:self.twoInterstitialButton];
        [self addSubview:self.threeBannerButton];
        [self addSubview:self.videoHiddenButton];
    }
    return self;
}

-(void) updateConstraints {
    
    [self.bannerHiddenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.equalTo(@250);
    }];
    [self.threeBannerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.equalTo(@250);
        make.top.equalTo(self.bannerHiddenButton.mas_bottom).with.offset(10);
    }];
    [self.twoInterstitialButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.equalTo(@250);
        make.top.equalTo(self.threeBannerButton.mas_bottom).with.offset(10);
        make.centerY.equalTo(self);
    }];
    [self.videoHiddenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.equalTo(@250);
        make.top.equalTo(self.twoInterstitialButton.mas_bottom).with.offset(10);
    }];
    
    [super updateConstraints];
}

#pragma mark --- PROPERTY

- (UIButton *) bannerHiddenButton {
    if (!_bannerHiddenButton) {
        _bannerHiddenButton = k_apd_mainButtonWithTitle([NSLocalizedString(@"banner hidden", nil) uppercaseString]);
    }
    return _bannerHiddenButton;
}

- (UIButton *) twoInterstitialButton {
    if (!_twoInterstitialButton) {
        _twoInterstitialButton = k_apd_mainButtonWithTitle([NSLocalizedString(@"two interstitial", nil) uppercaseString]);
    }
    return _twoInterstitialButton;
}

- (UIButton *) threeBannerButton {
    if (!_threeBannerButton) {
        _threeBannerButton = k_apd_mainButtonWithTitle([NSLocalizedString(@"three banner", nil) uppercaseString]);
    }
    return _threeBannerButton;
}

- (UIButton *) videoHiddenButton {
    if (!_videoHiddenButton) {
        _videoHiddenButton = k_apd_mainButtonWithTitle([NSLocalizedString(@"video hidden", nil) uppercaseString]);
    }
    return _videoHiddenButton;
}

@end
