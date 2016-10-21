//
//  APDTimerView.m
//  AppodealApp
//
//  Created by Lozhkin Ilya on 5/23/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDTimerView.h"

@interface APDTimerView ()
{
    NSTimer * _timer;
}

@property (nonatomic, strong) UILabel * timerLabel;
@property (nonatomic, strong) UIButton * startButton;

@end

@implementation APDTimerView

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        
        {
            [self addSubview:self.timerLabel];
            [self addSubview:self.startButton];
        }
    }
    return self;
}

- (void) updateConstraints {
    [self.timerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.startButton.mas_top).with.offset(-10);
        make.centerX.equalTo(self);
    }];
    [self.startButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.equalTo(@150);
        make.height.equalTo(@50);
    }];
    [super updateConstraints];
}

#pragma mark --- PROPERTY

-(UILabel * )timerLabel {
    if (!_timerLabel) {
        _timerLabel = [UILabel new];
        _timerLabel.textAlignment = NSTextAlignmentCenter;
        _timerLabel.font = [UIFont systemFontOfSize:80.0f weight:UIFontWeightLight];
        _timerLabel.textColor = UIColor.lightGrayColor;
        
        _timerLabel.text = @"60";
    }
    return _timerLabel;
}

- (UIButton *) startButton {
    if (!_startButton) {
        _startButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _startButton.layer.cornerRadius = 5.0;
        _startButton.clipsToBounds = YES;
        [_startButton setTitle:[NSLocalizedString(@"start timer", nil) uppercaseString] forState:UIControlStateNormal];
        [_startButton setTitle:[NSLocalizedString(@"waiting ...", nil) uppercaseString] forState:UIControlStateDisabled];
        _startButton.backgroundColor = UIColor.redColor;
        
        [_startButton addTarget:self action:@selector(startClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startButton;
}

#pragma mark --- ACTION

-(IBAction)startClick:(id)sender{
    _timerLabel.text = @(60).stringValue;
    self.startButton.enabled = NO;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerTick) userInfo:nil repeats:YES];
}

#pragma mark --- TICK

-(void)timerTick{
    NSInteger tick = [self.timerLabel.text integerValue];
    NSLog(@"%@",self.timerLabel.text);
    if (tick == 1) {
        self.timerLabel.text = @(tick - 1).stringValue;
        self.startButton.enabled = YES;
        [_timer invalidate];
        return;
    }
    self.timerLabel.text = @(tick - 1).stringValue;
}

- (void) timerStop {
    [_timer invalidate];
    _timer = nil;
}

@end
