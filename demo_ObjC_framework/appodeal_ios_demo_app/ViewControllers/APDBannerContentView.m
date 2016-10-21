//
//  APDBannerContentView.m
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 6/14/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDBannerContentView.h"
#import "Haneke.h"

@interface APDBannerContentView ()

@property (nonatomic, strong) UIImageView* iconView;
@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UILabel* descriptionLabel;
@property (nonatomic, strong) APDMediaView* mediaView;
@property (nonatomic, strong) UILabel* callToActionLabel;
@property (nonatomic, strong) UILabel* adBadgeLabel;

@property (nonatomic, strong) APDNativeAd* nativeAd;

@end

@implementation APDBannerContentView

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        {
            self.layer.borderWidth = 1.0;
            self.layer.borderColor = UIColor.lightGrayColor.CGColor;
        }
        
        [self makeConstrain];
    }
    return self;
}

#pragma mark --- PUBLICK

- (void) setNativeAd:(APDNativeAd *)nativeAd fromViewController:(UIViewController *)controller{
    self.nativeAd = nativeAd;
    [self.nativeAd attachToView:self viewController:controller];
    
    [self.mediaView setNativeAd:self.nativeAd rootViewController:controller];
    self.titleLabel.text = self.nativeAd.title;
    self.callToActionLabel.text = self.nativeAd.callToActionText;
}

#pragma mark --- CONSTRAIN

- (void) makeConstrain {
    
    [self.mediaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.left.equalTo(self).with.offset(2);
        make.centerY.equalTo(self);
    }];
    [self.adBadgeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mediaView);
        make.right.equalTo(self).with.offset(-2);
        make.width.lessThanOrEqualTo(@24);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mediaView);
        make.left.equalTo(self.mediaView.mas_right).with.offset(5);
        make.right.equalTo(self.adBadgeLabel.mas_left).with.offset(-5);
    }];
    [self.callToActionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(120, 30));
        make.bottom.and.right.equalTo(self).with.offset(-2);
    }];
}

#pragma mark --- PROPERTY

- (APDMediaView *)mediaView {
    if (!_mediaView) {
        _mediaView = [[APDMediaView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        _mediaView.skippable = YES;
        _mediaView.type = APDMediaViewTypeIcon;
        [self addSubview:_mediaView];
    }
    return _mediaView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.textColor = [UIColor darkTextColor];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)adBadgeLabel {
    if (!_adBadgeLabel){
        _adBadgeLabel = [UILabel new];
        _adBadgeLabel.backgroundColor = [UIColor darkGrayColor];
        _adBadgeLabel.text = @"Ad";
        _adBadgeLabel.textColor = [UIColor whiteColor];
        _adBadgeLabel.textAlignment = NSTextAlignmentCenter;
        _adBadgeLabel.font = [UIFont systemFontOfSize:10];
        _adBadgeLabel.layer.cornerRadius = 2.0f;
        [self addSubview:_adBadgeLabel];
    }
    return _adBadgeLabel;
}

- (UILabel *)callToActionLabel{
    if (!_callToActionLabel){
        _callToActionLabel = [UILabel new];
        _callToActionLabel.textColor = [UIColor darkGrayColor];
        _callToActionLabel.textAlignment = NSTextAlignmentCenter;
        _callToActionLabel.font = [UIFont systemFontOfSize:12];
        _callToActionLabel.layer.cornerRadius = 5.0f;
        _callToActionLabel.layer.borderWidth = 1.0f;
        _callToActionLabel.layer.borderColor = [UIColor darkGrayColor].CGColor;
        [self addSubview:_callToActionLabel];
    }
    return _callToActionLabel;
}

@end
