//
//  APDBannerPresentationView.m
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 6/13/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDBannerPresentationView.h"

@implementation APDBannerPresentationView

-(instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bannerTop];
        [self addSubview:self.bannerBottom];
        [self addSubview:self.hideBanner];
        [self addSubview:self.timerLabel];
    }
    [self updateConstraints];
    return self;
}

#pragma mark --- CONSTRAIN

- (void) updateConstraints {
    
    [self.bannerTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.bannerBottom.mas_top).with.offset(-20);
        make.width.equalTo(@200);
    }];
    
    [self.bannerBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
        make.width.equalTo(@200);
    }];
    
    [self.hideBanner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.bannerBottom.mas_bottom).with.offset(20);
        make.width.equalTo(@200);
    }];
    
    [self.timerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.bannerTop.mas_top).with.offset(-40);
        make.width.equalTo(@200);
    }];
    
    [super updateConstraints];
}

#pragma mark --- PROPERY

- (UIButton *) bannerTop {
    if (!_bannerTop) {
        _bannerTop = k_apd_mainButtonWithTitle([NSLocalizedString(@"banner top", nil) uppercaseString]);
    }
    return _bannerTop;
}

- (UIButton *) bannerBottom {
    if (!_bannerBottom) {
        _bannerBottom = k_apd_mainButtonWithTitle([NSLocalizedString(@"banner bottom", nil) uppercaseString]);
    }
    return _bannerBottom;
}

- (UIButton *) hideBanner {
    if (!_hideBanner) {
        _hideBanner = k_apd_mainButtonWithTitle([NSLocalizedString(@"hide banner", nil) uppercaseString]);
    }
    return _hideBanner;
}

- (UILabel *) timerLabel{
    if (!_timerLabel) {
        _timerLabel = [UILabel new];
        _timerLabel.textAlignment = NSTextAlignmentCenter;
        _timerLabel.font = [UIFont systemFontOfSize:80.0f weight:UIFontWeightLight];
        _timerLabel.textColor = UIColor.lightGrayColor;
    }
    return _timerLabel;
}

@end
