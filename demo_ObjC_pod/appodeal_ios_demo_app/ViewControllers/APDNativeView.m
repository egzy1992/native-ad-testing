//
//  APDNativeView.m
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 8/8/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDNativeView.h"

@interface APDNativeView () <APDMediaViewDelegate>

{
    BOOL needUpdateConstrain;
    BOOL _muted;
}

@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UILabel* descriptionLabel;
@property (nonatomic, strong) UILabel* callToActionLabel;
@property (nonatomic, strong) APDMediaView * mediaView;
@property (nonatomic, strong) UILabel* adBadgeLabel;

@property (nonatomic, strong) UIImageView * shadowImageView;
@property (nonatomic, strong) APDNativeAd* nativeAd;

@property (nonatomic, strong) UIButton * muteButton;

@end

@implementation APDNativeView

- (void) makeConstrain {
    
    self.backgroundColor = UIColor.whiteColor;
    self.layer.borderColor = UIColor.lightGrayColor.CGColor;
    self.layer.borderWidth = 1.0;
    self.layer.cornerRadius = 3.0;
    
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    CGFloat heigth = width * 9 / 16;
    
    self.mediaView.frame = CGRectMake(0, 0, width, heigth);
    self.callToActionLabel.frame = CGRectMake(CGRectGetWidth(self.frame) - 125, heigth + 25, 120, 30);
    self.adBadgeLabel.frame = CGRectMake(CGRectGetWidth(self.frame) - 30, heigth + 5, 25, 12);
    self.titleLabel.frame = CGRectMake(5, heigth + 5, CGRectGetWidth(self.frame) - 100, 15);
    self.descriptionLabel.frame = CGRectMake(5, heigth + CGRectGetHeight(self.titleLabel.frame) + 10, CGRectGetWidth(self.frame) - 130, 40);
    
//    needUpdateConstrain = YES;
}

- (void)muteButtonPressed {
    if (_muted) {
        _muted = NO;
        [self.mediaView setMuted:NO];
        [self.muteButton setImage:[UIImage imageNamed:@"appodeal_mute_off"] forState:UIControlStateNormal];
    } else {
        _muted = YES;
        [self.mediaView setMuted:YES];
        [self.muteButton setImage:[UIImage imageNamed:@"appodeal_mute_on"] forState:UIControlStateNormal];
    }
}

- (void)addMuteButton {
    CGSize sizeOfMediaView = self.mediaView.bounds.size;
    [self.muteButton setFrame:CGRectMake(5, sizeOfMediaView.height - 20, 15, 15)];
    [self.mediaView addSubview:self.muteButton];
}

#pragma mark --- APDMediaViewDelegate

- (void)mediaViewStartPlaying:(APDMediaView *)mediaView {
    [self addMuteButton];
    [self muteButtonPressed];
}

// Call when video finsih playing
- (void)mediaViewFinishPlaying:(APDMediaView *)mediaView videoWasSkipped:(BOOL)wasSkipped {
    [self.muteButton removeFromSuperview];
}

// Call wnen media view present fullscreen
// If type APDMediaViewTypeIcon -mediaViewStartPlaying: call firstly!
- (void)mediaViewDidPresentFullScreen:(APDMediaView *)mediaView {
    [self.muteButton removeFromSuperview];
    [self addMuteButton];
}

// Call wnen media view dismiss fullscreen
- (void)mediaViewDidDismissFullScreen:(APDMediaView *)mediaView {
    [self.muteButton removeFromSuperview];
    [self addMuteButton];
}



#pragma mark --- PROPERTY

- (APDMediaView *)mediaView {
    if (!_mediaView) {
        CGFloat width = [[UIScreen mainScreen] bounds].size.width;
        CGFloat heigth = width * 9 / 16;
        _mediaView = [[APDMediaView alloc] initWithFrame:CGRectMake(0, 0, width, heigth)];
        _mediaView.skippable = YES;
        _mediaView.type = APDMediaViewTypeMainImage;
        _mediaView.delegate = self;
        [self addSubview:_mediaView];
    }
    return _mediaView;
}

- (UIImageView *)shadowImageView {
    if (!_shadowImageView) {
        _shadowImageView = [[UIImageView alloc] init];
        [_shadowImageView setImage:[UIImage imageNamed:@"shadow"]];
        [self addSubview:_shadowImageView];
    }
    return _shadowImageView;
}

- (UIButton *)muteButton {
    if (!_muteButton) {
        _muteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_muteButton addTarget:self action:@selector(muteButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        _muteButton.alpha = .6f;
    }
    return _muteButton;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont boldSystemFontOfSize:17];
        _titleLabel.textColor = [UIColor darkTextColor];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)callToActionLabel{
    if (!_callToActionLabel){
        _callToActionLabel = [UILabel new];
        _callToActionLabel.textColor = [UIColor darkGrayColor];
        _callToActionLabel.textAlignment = NSTextAlignmentCenter;
        _callToActionLabel.font = [UIFont boldSystemFontOfSize:14];
        _callToActionLabel.layer.cornerRadius = 5.0f;
        _callToActionLabel.layer.borderWidth = 2.0f;
        _callToActionLabel.layer.borderColor = [UIColor darkGrayColor].CGColor;
        [self addSubview:_callToActionLabel];
    }
    return _callToActionLabel;
}

- (UILabel *)descriptionLabel {
    if (!_descriptionLabel){
        _descriptionLabel = [UILabel new];
        _descriptionLabel.font = [UIFont boldSystemFontOfSize:14];
        _descriptionLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _descriptionLabel.numberOfLines = 3;
        _descriptionLabel.textAlignment = NSTextAlignmentLeft;
        _descriptionLabel.textColor = [UIColor grayColor];
        [self addSubview:_descriptionLabel];
    }
    return _descriptionLabel;
}

@end
