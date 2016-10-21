//
//  APDNativeShowStyleView.m
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 6/14/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDNativeShowStyleView.h"

@implementation APDNativeShowStyleView

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.contentFeed];
        [self addSubview:self.contentStream];
        [self addSubview:self.collectionContent];
        [self addSubview:self.customContent];
        [self addSubview:self.bannerConent];
        [self addSubview:self.segmentControl];
        [self addSubview:self.helperSegmentedControl];
        [self addSubview:self.apdTypeSegmentedControl];
        
        [self addSubview:self.collectionHelperContent];
        [self addSubview:self.tableHelperContent];
        
        [self addSubview:self.capacitySlider];
        
        [self reloadViewWithOptions];
        [self updateConstraints];
    }
    return self;
}

- (void) reloadViewWithOptions {
    switch (self.helperSegmentedControl.selectedSegmentIndex) {
        case 0:
        { // WITH HELPER
            self.apdTypeSegmentedControl.hidden = NO;
            self.segmentControl.hidden = YES;
            
            self.contentFeed.hidden = YES;
            self.contentStream.hidden = YES;
            self.collectionContent.hidden = YES;
            self.bannerConent.hidden = YES;
            
            self.customContent.hidden = YES;
            self.capacitySlider.hidden = YES;
            
            self.collectionHelperContent.hidden = NO;
            self.tableHelperContent.hidden = NO;
        } break;
        case 1:
        { // WITHOUT HELPER
            self.segmentControl.hidden = NO;
            self.apdTypeSegmentedControl.hidden = YES;
            self.capacitySlider.hidden = NO;
            
            { // UNUSED VERSION - HIDDEN = YES
                self.contentFeed.hidden = YES;
                self.contentStream.hidden = YES;
                self.collectionContent.hidden = YES;
                self.bannerConent.hidden = YES;
            }
            
            {
                self.customContent.hidden = NO;
            }
            
            self.collectionHelperContent.hidden = YES;
            self.tableHelperContent.hidden = YES;
            
        } break;
    }
}

#pragma mark --- ACTIONS

- (IBAction)helperSegmentControlClick:(UISegmentedControl *)sender {
    [self reloadViewWithOptions];
}

- (IBAction)capacitySliderValueChanged:(UISlider *)sender{
    int discreteValue = roundl([sender value]);
    [sender setValue:(float)discreteValue];
    NSAttributedString * attrString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ (%li)",[NSLocalizedString(@"custom", nil) uppercaseString],@(sender.value).integerValue]
                                                                      attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20.0f weight:UIFontWeightLight],
                                                                                   NSKernAttributeName : @(2.0),
                                                                                   NSForegroundColorAttributeName : UIColor.lightGrayColor}];
    [self.customContent setAttributedTitle:attrString forState:UIControlStateNormal];
}

#pragma mark --- CONSTRAIN

- (void) updateConstraints {
    
    [self.contentFeed mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.equalTo(@250);
    }];
    
    [self.contentStream mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.contentFeed.mas_bottom).with.offset(10);
        make.width.equalTo(@250);
    }];
    
    [self.collectionContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.contentStream.mas_bottom).with.offset(10);
        make.width.equalTo(@250);
        make.centerY.equalTo(self);
    }];
    
    { // WITH HELPER
        [self.collectionHelperContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.contentStream.mas_bottom).with.offset(10);
            make.width.equalTo(@250);
            make.centerY.equalTo(self);
        }];
        
        [self.tableHelperContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.collectionContent.mas_bottom).with.offset(10);
            make.width.equalTo(@250);
        }];
    }
    
    { // WITHOUT HELPER
        [self.customContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.contentStream.mas_bottom).with.offset(10);
            make.width.equalTo(@250);
            make.centerY.equalTo(self);
        }];
        
        [self.capacitySlider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.customContent.mas_bottom).with.offset(10);
            make.width.equalTo(@200);
            make.centerX.equalTo(self);
        }];
    }
    
    [self.bannerConent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.collectionContent.mas_bottom).with.offset(10);
        make.width.equalTo(@250);
    }];
    
    [self.helperSegmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).with.offset(70);
        make.left.equalTo(self).with.offset(50);
        make.right.equalTo(self).with.offset(-50);
    }];
    
    [self.segmentControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.helperSegmentedControl.mas_bottom).with.offset(10);
        make.left.equalTo(self).with.offset(50);
        make.right.equalTo(self).with.offset(-50);
    }];
    
    [self.apdTypeSegmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.helperSegmentedControl.mas_bottom).with.offset(10);
        make.left.equalTo(self).with.offset(50);
        make.right.equalTo(self).with.offset(-50);
    }];
    
    [super updateConstraints];
}

#pragma mark --- PROPERTY

- (UIButton *) contentFeed {
    if (!_contentFeed) {
        _contentFeed = [UIButton buttonWithType:UIButtonTypeCustom];
        
        NSAttributedString * attrString = [[NSAttributedString alloc] initWithString:[NSLocalizedString(@"content feed", nil) uppercaseString]
                                                                          attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20.0f weight:UIFontWeightLight],
                                                                                       NSKernAttributeName : @(2.0),
                                                                                       NSForegroundColorAttributeName : UIColor.lightGrayColor}];
        [_contentFeed setAttributedTitle:attrString forState:UIControlStateNormal];
        
        _contentFeed.clipsToBounds = YES;
        _contentFeed.layer.cornerRadius = 4.0f;
        _contentFeed.layer.borderWidth = 1.0f;
        _contentFeed.layer.borderColor = UIColor.lightGrayColor.CGColor;
    }
    return _contentFeed;
}

- (UIButton *) contentStream {
    if (!_contentStream) {
        _contentStream = [UIButton buttonWithType:UIButtonTypeCustom];
        
        NSAttributedString * attrString = [[NSAttributedString alloc] initWithString:[NSLocalizedString(@"content stream", nil) uppercaseString]
                                                                          attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20.0f weight:UIFontWeightLight],
                                                                                       NSKernAttributeName : @(2.0),
                                                                                       NSForegroundColorAttributeName : UIColor.lightGrayColor}];
        [_contentStream setAttributedTitle:attrString forState:UIControlStateNormal];
        
        _contentStream.clipsToBounds = YES;
        _contentStream.layer.cornerRadius = 4.0f;
        _contentStream.layer.borderWidth = 1.0f;
        _contentStream.layer.borderColor = UIColor.lightGrayColor.CGColor;
    }
    return _contentStream;
}

- (UIButton *) collectionContent {
    if (!_collectionContent) {
        _collectionContent = [UIButton buttonWithType:UIButtonTypeCustom];
        
        NSAttributedString * attrString = [[NSAttributedString alloc] initWithString:[NSLocalizedString(@"collection", nil) uppercaseString]
                                                                          attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20.0f weight:UIFontWeightLight],
                                                                                       NSKernAttributeName : @(2.0),
                                                                                       NSForegroundColorAttributeName : UIColor.lightGrayColor}];
        [_collectionContent setAttributedTitle:attrString forState:UIControlStateNormal];
        
        _collectionContent.clipsToBounds = YES;
        _collectionContent.layer.cornerRadius = 4.0f;
        _collectionContent.layer.borderWidth = 1.0f;
        _collectionContent.layer.borderColor = UIColor.lightGrayColor.CGColor;
    }
    return _collectionContent;
}

- (UIButton *) customContent {
    if (!_customContent) {
        _customContent = [UIButton buttonWithType:UIButtonTypeCustom];
        
        NSAttributedString * attrString = [[NSAttributedString alloc] initWithString:[NSLocalizedString(@"custom", nil) uppercaseString]
                                                                          attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20.0f weight:UIFontWeightLight],
                                                                                       NSKernAttributeName : @(2.0),
                                                                                       NSForegroundColorAttributeName : UIColor.lightGrayColor}];
        [_customContent setAttributedTitle:attrString forState:UIControlStateNormal];
        
        _customContent.clipsToBounds = YES;
        _customContent.layer.cornerRadius = 4.0f;
        _customContent.layer.borderWidth = 1.0f;
        _customContent.layer.borderColor = UIColor.lightGrayColor.CGColor;
    }
    return _customContent;
}

- (UISlider *) capacitySlider {
    if (!_capacitySlider) {
        _capacitySlider = [[UISlider alloc] init];
        _capacitySlider.minimumValue = 1;
        _capacitySlider.maximumValue = 8;
        _capacitySlider.tintColor = UIColor.redColor;
        [_capacitySlider addTarget:self action:@selector(capacitySliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        
        _capacitySlider.value = 5;
    }
    return _capacitySlider;
}

- (UIButton *) bannerConent {
    if (!_bannerConent) {
        _bannerConent = [UIButton buttonWithType:UIButtonTypeCustom];
        
        NSAttributedString * attrString = [[NSAttributedString alloc] initWithString:[NSLocalizedString(@"banner", nil) uppercaseString]
                                                                          attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20.0f weight:UIFontWeightLight],
                                                                                       NSKernAttributeName : @(2.0),
                                                                                       NSForegroundColorAttributeName : UIColor.lightGrayColor}];
        [_bannerConent setAttributedTitle:attrString forState:UIControlStateNormal];
        
        _bannerConent.clipsToBounds = YES;
        _bannerConent.layer.cornerRadius = 4.0f;
        _bannerConent.layer.borderWidth = 1.0f;
        _bannerConent.layer.borderColor = UIColor.lightGrayColor.CGColor;
    }
    return _bannerConent;
}

- (UIButton *) collectionHelperContent {
    if (!_collectionHelperContent) {
        _collectionHelperContent = [UIButton buttonWithType:UIButtonTypeCustom];
        
        NSAttributedString * attrString = [[NSAttributedString alloc] initWithString:[NSLocalizedString(@"collection", nil) uppercaseString]
                                                                          attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20.0f weight:UIFontWeightLight],
                                                                                       NSKernAttributeName : @(2.0),
                                                                                       NSForegroundColorAttributeName : UIColor.lightGrayColor}];
        [_collectionHelperContent setAttributedTitle:attrString forState:UIControlStateNormal];
        
        _collectionHelperContent.clipsToBounds = YES;
        _collectionHelperContent.layer.cornerRadius = 4.0f;
        _collectionHelperContent.layer.borderWidth = 1.0f;
        _collectionHelperContent.layer.borderColor = UIColor.lightGrayColor.CGColor;
    }
    return _collectionHelperContent;
}

- (UIButton *) tableHelperContent {
    if (!_tableHelperContent) {
        _tableHelperContent = [UIButton buttonWithType:UIButtonTypeCustom];
        
        NSAttributedString * attrString = [[NSAttributedString alloc] initWithString:[NSLocalizedString(@"table view", nil) uppercaseString]
                                                                          attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20.0f weight:UIFontWeightLight],
                                                                                       NSKernAttributeName : @(2.0),
                                                                                       NSForegroundColorAttributeName : UIColor.lightGrayColor}];
        [_tableHelperContent setAttributedTitle:attrString forState:UIControlStateNormal];
        
        _tableHelperContent.clipsToBounds = YES;
        _tableHelperContent.layer.cornerRadius = 4.0f;
        _tableHelperContent.layer.borderWidth = 1.0f;
        _tableHelperContent.layer.borderColor = UIColor.lightGrayColor.CGColor;
    }
    return _tableHelperContent;
}

- (UISegmentedControl *) segmentControl {
    if (!_segmentControl) {
        _segmentControl = [[UISegmentedControl alloc] initWithItems:@[NSLocalizedString(@"combo", nil), NSLocalizedString(@"video", nil), NSLocalizedString(@"no video", nil)]];
        _segmentControl.selectedSegmentIndex = 0;
        _segmentControl.tintColor = UIColor.redColor;
        
        _segmentControl.clipsToBounds = YES;
        _segmentControl.layer.cornerRadius = 4.0f;
        _segmentControl.layer.borderWidth = 1.0f;
        _segmentControl.layer.borderColor = UIColor.redColor.CGColor;
    }
    return _segmentControl;
}

- (UISegmentedControl *) helperSegmentedControl {
    if (!_helperSegmentedControl) {
        _helperSegmentedControl = [[UISegmentedControl alloc] initWithItems:@[NSLocalizedString(@"with helper", nil), NSLocalizedString(@"without helper", nil)]];
        _helperSegmentedControl.selectedSegmentIndex = 1;
        _helperSegmentedControl.tintColor = UIColor.redColor;
        _helperSegmentedControl.hidden = YES;
        
        _helperSegmentedControl.clipsToBounds = YES;
        _helperSegmentedControl.layer.cornerRadius = 4.0f;
        _helperSegmentedControl.layer.borderWidth = 1.0f;
        _helperSegmentedControl.layer.borderColor = UIColor.redColor.CGColor;
        
        [_helperSegmentedControl addTarget:self action:@selector(helperSegmentControlClick:) forControlEvents:UIControlEventValueChanged];
    }
    return _helperSegmentedControl;
}

- (UISegmentedControl *) apdTypeSegmentedControl {
    if (!_apdTypeSegmentedControl) {
        _apdTypeSegmentedControl = [[UISegmentedControl alloc] initWithItems:@[NSLocalizedString(@"Native", nil), NSLocalizedString(@"Banner", nil), NSLocalizedString(@"MREC", nil)]];
        _apdTypeSegmentedControl.selectedSegmentIndex = 0;
        _apdTypeSegmentedControl.tintColor = UIColor.redColor;
        
        _apdTypeSegmentedControl.clipsToBounds = YES;
        _apdTypeSegmentedControl.layer.cornerRadius = 4.0f;
        _apdTypeSegmentedControl.layer.borderWidth = 1.0f;
        _apdTypeSegmentedControl.layer.borderColor = UIColor.redColor.CGColor;
    }
    return _apdTypeSegmentedControl;
}

@end
