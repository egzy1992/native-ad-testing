//
//  APDCustomContentView.m
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 8/9/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDCustomContentView.h"
#import "APDCustomNativeView.h"

@interface APDCustomContentView ()
{
    
}

@property (nonatomic, strong) APDCustomNativeView * customNativeView;

@end

@implementation APDCustomContentView

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.customNativeView];
        [self addSubview:self.loadNativeButton];
        [self addSubview:self.prevButton];
        [self addSubview:self.nextButton];
        [self addSubview:self.countLabel];
    }
    return self;
}

#pragma mark --- CONSTRAIN

- (void) updateConstraints {
    
    [self.customNativeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.equalTo(self).with.offset(-20);
        make.height.lessThanOrEqualTo(@(CGRectGetWidth(self.frame)*0.8));
    }];
    
    [self.loadNativeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.customNativeView.mas_bottom).with.offset(10);
        make.width.equalTo(@250);
    }];
    
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.loadNativeButton);
        make.left.equalTo(self.mas_centerX).with.offset(10);
        make.width.equalTo(@150);
    }];
    
    [self.prevButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.loadNativeButton);
        make.right.equalTo(self.mas_centerX).with.offset(-10);
        make.width.equalTo(@150);
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.customNativeView.mas_top).with.offset(-10);
        make.left.and.right.equalTo(self);
    }];
    
    [super updateConstraints];
}

- (void) updateNativeViewWith:(APDNativeAd *)nativeAd onRootViewController:(UIViewController *)controller {
    _customNativeView.hidden = NO;
    [self.customNativeView setNativeAd:nativeAd fromViewController:controller];
}

#pragma mark --- PROPERTY

- (APDCustomNativeView *) customNativeView {
    if (!_customNativeView) {
        _customNativeView = [[APDCustomNativeView alloc] init];
        
        _customNativeView.layer.borderColor = UIColor.lightGrayColor.CGColor;
        _customNativeView.layer.borderWidth = .9;
        _customNativeView.layer.cornerRadius = 2.;
        
        _customNativeView.hidden = YES;
    }
    return _customNativeView;
}

-(UILabel * )countLabel {
    if (!_countLabel) {
        _countLabel = [UILabel new];
        _countLabel.textAlignment = NSTextAlignmentCenter;
        _countLabel.font = [UIFont systemFontOfSize:80.0f weight:UIFontWeightLight];
        _countLabel.textColor = UIColor.lightGrayColor;
        _countLabel.hidden = YES;
        
        _countLabel.text = @"";
    }
    return _countLabel;
}

- (UIButton *) loadNativeButton {
    if (!_loadNativeButton) {
        _loadNativeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        NSAttributedString * attrString = [[NSAttributedString alloc] initWithString:[NSLocalizedString(@"load native ad", nil) uppercaseString]
                                                                          attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20.0f weight:UIFontWeightLight],
                                                                                       NSKernAttributeName : @(2.0),
                                                                                       NSForegroundColorAttributeName : UIColor.lightGrayColor}];
        [_loadNativeButton setAttributedTitle:attrString forState:UIControlStateNormal];
        
        _loadNativeButton.clipsToBounds = YES;
        _loadNativeButton.layer.cornerRadius = 4.0f;
        _loadNativeButton.layer.borderWidth = 1.0f;
        _loadNativeButton.layer.borderColor = UIColor.lightGrayColor.CGColor;
    }
    return _loadNativeButton;
}

- (UIButton *) prevButton {
    if (!_prevButton) {
        _prevButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        NSAttributedString * attrString = [[NSAttributedString alloc] initWithString:[NSLocalizedString(@"prev ad", nil) uppercaseString]
                                                                          attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20.0f weight:UIFontWeightLight],
                                                                                       NSKernAttributeName : @(2.0),
                                                                                       NSForegroundColorAttributeName : UIColor.lightGrayColor}];
        [_prevButton setAttributedTitle:attrString forState:UIControlStateNormal];
        
        _prevButton.clipsToBounds = YES;
        _prevButton.layer.cornerRadius = 4.0f;
        _prevButton.layer.borderWidth = 1.0f;
        _prevButton.layer.borderColor = UIColor.lightGrayColor.CGColor;
        
        _prevButton.hidden = YES;
    }
    return _prevButton;
}

- (UIButton *) nextButton {
    if (!_nextButton) {
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        NSAttributedString * attrString = [[NSAttributedString alloc] initWithString:[NSLocalizedString(@"next ad", nil) uppercaseString]
                                                                          attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20.0f weight:UIFontWeightLight],
                                                                                       NSKernAttributeName : @(2.0),
                                                                                       NSForegroundColorAttributeName : UIColor.lightGrayColor}];
        [_nextButton setAttributedTitle:attrString forState:UIControlStateNormal];
        
        _nextButton.clipsToBounds = YES;
        _nextButton.layer.cornerRadius = 4.0f;
        _nextButton.layer.borderWidth = 1.0f;
        _nextButton.layer.borderColor = UIColor.lightGrayColor.CGColor;
        
        _nextButton.hidden = YES;
    }
    return _nextButton;
}

@end
