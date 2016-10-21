//
//  APDVideoView.m
//  AppodealApp
//
//  Created by Lozhkin Ilya on 5/23/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDVideoView.h"
#import <AVFoundation/AVFoundation.h>

@interface APDVideoView ()
{
    UIView * _pBackView;
    AVPlayer * avPlayer;
    BOOL _isPlayed;
}

@property (nonatomic, strong) UIButton * muteButton;

@end

@implementation APDVideoView

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self avVideoPlayerMake];
        
        {
            [_pBackView addSubview:self.muteButton];
            self.muteButton.frame = CGRectMake(CGRectGetWidth(_pBackView.frame) - 25, 5, 20, 20);
        }
    }
    return self;
}

- (void) updateConstraints {
    [_pBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(80);
        make.width.equalTo(@300);
        make.centerX.equalTo(self);
        make.height.equalTo(@180);
    }];
    
    [self.muteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_pBackView).with.offset(5);
        make.right.equalTo(_pBackView).with.offset(-5);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    [super updateConstraints];
}

#pragma mark --- PROPERTY

- (UIButton *) muteButton {
    if (!_muteButton) {
        _muteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _muteButton.layer.cornerRadius = 2.0;
        _muteButton.clipsToBounds = YES;
        [_muteButton setBackgroundImage:[UIImage imageNamed:@"muteOffIcon"] forState:UIControlStateNormal];
        [_muteButton setBackgroundImage:[UIImage imageNamed:@"muteOnIcon"] forState:UIControlStateSelected];
        
        [_muteButton addTarget:self action:@selector(muteClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _muteButton;
}

#pragma mark --- PRIVATE

- (void) avVideoPlayerMake{
    _pBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 180)];
    _pBackView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.95];
    [_pBackView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playClick:)]];
    [self addSubview:_pBackView];
    
    avPlayer = [AVPlayer playerWithURL:[NSURL URLWithString:@"https://s3.amazonaws.com/appodeal-campaign-images/test_banners/video.mp4"]];
    AVPlayerLayer *avPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:avPlayer];
    
    avPlayerLayer.frame = CGRectMake(0, 0, CGRectGetWidth(_pBackView.frame), CGRectGetHeight(_pBackView.frame));
    [_pBackView.layer addSublayer:avPlayerLayer];
}

#pragma mark --- ACTIONS

-(IBAction)playClick:(id)sender{
    
    if (avPlayer.status == AVPlayerStatusReadyToPlay) {
        if (_isPlayed) {
            _isPlayed = NO;
            [avPlayer pause];
            return;
        }
        [avPlayer play];
        _isPlayed = YES;
    }
}

-(IBAction)muteClick:(UIButton *)sender{
    sender.selected = sender.selected ? NO : YES;
    avPlayer.muted = sender.selected;
}

@end
