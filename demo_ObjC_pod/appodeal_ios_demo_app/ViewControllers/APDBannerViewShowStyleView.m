//
//  APDBannerViewShowStyleView.m
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 6/13/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDBannerViewShowStyleView.h"

@implementation APDBannerViewShowStyleView

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tableBanner];
        [self addSubview:self.collectionBanner];
    }
    return self;
}

#pragma mark --- CONSTRAIN

- (void) updateConstraints {
    
    [self.tableBanner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.mas_centerY).with.offset(-5);
        make.width.equalTo(@250);
    }];
    
    [self.collectionBanner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.mas_centerY).with.offset(5);
        make.width.equalTo(@250);
    }];
    
    [super updateConstraints];
}

#pragma mark --- PROPERY

- (UIButton *) tableBanner {
    if (!_tableBanner) {
        _tableBanner =  k_apd_mainButtonWithTitle([NSLocalizedString(@"table", nil) uppercaseString]);
    }
    return _tableBanner;
}

- (UIButton *) collectionBanner {
    if (!_collectionBanner) {
        _collectionBanner = k_apd_mainButtonWithTitle([NSLocalizedString(@"collection", nil) uppercaseString]);

    }
    return _collectionBanner;
}


@end
