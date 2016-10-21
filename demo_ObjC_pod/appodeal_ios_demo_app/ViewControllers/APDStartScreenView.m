//
//  APDStartScreenView.m
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 6/10/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDStartScreenView.h"

@implementation APDStartScreenView

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.legacyBtn];
        [self addSubview:self.favoriteBtn];
    }
    return self;
}

#pragma mark --- CONSTRAIN

- (void) updateConstraints {
    
    [self.legacyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.mas_centerY).with.offset(-20);
        make.width.equalTo(@150);
    }];
    
    [self.favoriteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.mas_centerY).with.offset(20);
        make.width.equalTo(@150);
    }];
    
    [super updateConstraints];
}

#pragma mark --- PROPERY

- (UIButton *) legacyBtn {
    if (!_legacyBtn) {
        _legacyBtn = k_apd_mainButtonWithTitle([NSLocalizedString(@"api 0.10.x", nil) uppercaseString]);
    }
    return _legacyBtn;
}

- (UIButton *) favoriteBtn{
    if (!_favoriteBtn) {
        _favoriteBtn = k_apd_mainButtonWithTitle([NSLocalizedString(@"api 1.0.x", nil) uppercaseString]);
    }
    return _favoriteBtn;
}

@end
