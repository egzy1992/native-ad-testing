//
//  APDNativeAdViewTemplate.m
//  appodeal_ios_demo_app
//
//  Created by Stas Kochkin on 16/08/2017.
//  Copyright © 2017 Lozhkin Ilya. All rights reserved.
//

#import "APDNativeAdViewTemplate.h"
#import "Masonry.h"


@interface APDNativeAdViewTemplate ()


@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UILabel *callToActionLabel;
@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UIView *mediaContainerView;
@property (nonatomic, strong) UILabel *contentRatingLabel;
@property (nonatomic, strong) UIView *adChoicesView;

@end

@implementation APDNativeAdViewTemplate

- (instancetype)init {
    if (self = [super init]) {
        [self designSubviews];
        [self layoutSubviews];
    }
    return self;
}

- (void)designSubviews {
    self.titleLabel = [UILabel new];
    self.titleLabel.textColor = [UIColor redColor];
    
    self.descriptionLabel = [UILabel new];
    self.descriptionLabel.textColor = [UIColor grayColor];
    
    self.callToActionLabel = [UILabel new];
    self.callToActionLabel.textColor = [UIColor redColor];
    
    self.mediaContainerView = [UIView new];
    
    self.iconView = [UIImageView new];
    
    self.contentRatingLabel = [UILabel new];
    self.contentRatingLabel.textColor = [UIColor lightTextColor];
    
    self.adChoicesView = [UIView new];
}

- (void)layoutSubviews {
    [self addSubview:self.titleLabel];
    [self addSubview:self.descriptionLabel];
    [self addSubview:self.callToActionLabel];
    [self addSubview:self.mediaContainerView];
    [self addSubview:self.iconView];
    [self addSubview:self.contentRatingLabel];
    [self addSubview:self.adChoicesView];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.top.equalTo(self);
    }];
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.bottom.equalTo(self);
    }];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(55, 55));
        make.left.equalTo(self);
        make.top.equalTo(self.titleLabel.mas_bottom);
    }];
    [self.callToActionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self.iconView);
    }];
    [self.mediaContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.centerX.equalTo(self);
        make.top.equalTo(self.iconView.mas_bottom);
        make.bottom.equalTo(self.descriptionLabel.mas_top);
    }];
    [self.contentRatingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconView);
        make.right.equalTo(self);
    }];
    [self.adChoicesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.iconView);
        make.right.equalTo(self);
    }];
}

@end
