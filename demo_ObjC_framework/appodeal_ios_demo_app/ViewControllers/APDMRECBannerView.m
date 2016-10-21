//
//  APDMRECBannerView.m
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 6/14/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDMRECBannerView.h"

@implementation APDMRECBannerView

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.showMREC];
        [self addSubview:self.hideMREC];
        [self addSubview:self.timerLabel];
    }
    return self;
}

#pragma mark --- CONSTRAIN

- (void) updateConstraints {
    
    [self.showMREC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_centerX).with.offset(-5);
        make.top.equalTo(self).with.offset(80);
        make.width.equalTo(@170);
    }];
    
    [self.hideMREC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX).with.offset(5);
        make.top.equalTo(self).with.offset(80);
        make.width.equalTo(@170);
    }];
    
    [self.timerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.mas_centerY).with.offset(-130);
        make.width.equalTo(@200);
    }];
    
    [super updateConstraints];
}

#pragma mark --- PROPERTY

- (UIButton *) showMREC {
    if (!_showMREC) {
        _showMREC = k_apd_mainButtonWithTitle([NSLocalizedString(@"show MREC", nil) uppercaseString]);
    }
    return _showMREC;
}

- (UIButton *) hideMREC {
    if (!_hideMREC) {
        _hideMREC = k_apd_mainButtonWithTitle([NSLocalizedString(@"hide MREC", nil) uppercaseString]);
    }
    return _hideMREC;
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
