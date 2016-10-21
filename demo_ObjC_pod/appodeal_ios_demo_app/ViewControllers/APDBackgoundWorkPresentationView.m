//
//  APDBackgoundWorkPresentationView.m
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 8/9/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDBackgoundWorkPresentationView.h"

@implementation APDBackgoundWorkPresentationView

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.geoButton];
        [self addSubview:self.videoButton];
        [self addSubview:self.timerButton];
        [self addSubview:self.audioRecordButton];
        [self addSubview:self.bluetoothButton];
        [self addSubview:self.phoneCallButton];
    }
    return self;
}

-(void) updateConstraints {
    
    [self.geoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.equalTo(@250);
    }];
    [self.videoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.equalTo(@250);
        make.top.equalTo(self.geoButton.mas_bottom).with.offset(10);
    }];
    [self.timerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.equalTo(@250);
        make.top.equalTo(self.videoButton.mas_bottom).with.offset(10);
        make.bottom.equalTo(self.mas_centerY);
    }];
    [self.audioRecordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.equalTo(@250);
        make.top.equalTo(self.timerButton.mas_bottom).with.offset(10);
    }];
    [self.bluetoothButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.equalTo(@250);
        make.top.equalTo(self.audioRecordButton.mas_bottom).with.offset(10);
    }];
    [self.phoneCallButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.equalTo(@250);
        make.top.equalTo(self.bluetoothButton.mas_bottom).with.offset(10);
    }];
    
    [super updateConstraints];
}

#pragma mark --- PROPERTY

- (UIButton *) geoButton {
    if (!_geoButton) {
        _geoButton = k_apd_mainButtonWithTitle([NSLocalizedString(@"geo", nil) uppercaseString]);
    }
    return _geoButton;
}

- (UIButton *) videoButton {
    if (!_videoButton) {
        _videoButton = k_apd_mainButtonWithTitle([NSLocalizedString(@"video", nil) uppercaseString]);
    }
    return _videoButton;
}

- (UIButton *) timerButton {
    if (!_timerButton) {
        _timerButton = k_apd_mainButtonWithTitle([NSLocalizedString(@"timer", nil) uppercaseString]);
    }
    return _timerButton;
}

- (UIButton *) audioRecordButton {
    if (!_audioRecordButton) {
        _audioRecordButton = k_apd_mainButtonWithTitle([NSLocalizedString(@"audio", nil) uppercaseString]);
    }
    return _audioRecordButton;
}

- (UIButton *) bluetoothButton {
    if (!_bluetoothButton) {
        _bluetoothButton = k_apd_mainButtonWithTitle([NSLocalizedString(@"bluetooth", nil) uppercaseString]);
    }
    return _bluetoothButton;
}

- (UIButton *) phoneCallButton {
    if (!_phoneCallButton) {
        _phoneCallButton = k_apd_mainButtonWithTitle([NSLocalizedString(@"phone call", nil) uppercaseString]);
    }
    return _phoneCallButton;
}

@end
