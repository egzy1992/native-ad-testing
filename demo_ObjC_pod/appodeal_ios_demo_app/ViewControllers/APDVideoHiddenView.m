//
//  APDVideoHiddenView.m
//  AppodealApp
//
//  Created by Lozhkin Ilya on 5/24/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDVideoHiddenView.h"

@interface APDVideoHiddenView ()
{
    UIWindow * topLvLwindow;
}

@property (nonatomic, strong) UILabel * descriptLabel;

@end

@implementation APDVideoHiddenView

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        
        {
            [self addSubview:self.descriptLabel];
            [self addSubview:self.showVideo];
            self.descriptLabel.frame = CGRectMake(20, self.center.y - 30, CGRectGetWidth(self.frame) - 40, 60);
            self.showVideo.frame = CGRectMake(self.center.x - 75, self.descriptLabel.frame.origin.y + 65, 150, 50);
        }
        
        {
            topLvLwindow = [[UIWindow alloc] initWithFrame:self.frame];
            topLvLwindow.rootViewController = [self bluredController];
            topLvLwindow.hidden = YES;
            topLvLwindow.windowLevel = 999;
        }
    }
    return self;
}

#pragma mark --- PROPERTY

- (UIButton *) showVideo {
    if (!_showVideo) {
        _showVideo = [UIButton buttonWithType:UIButtonTypeCustom];
        _showVideo.layer.cornerRadius = 5.0;
        _showVideo.clipsToBounds = YES;
        [_showVideo setTitle:[NSLocalizedString(@"show video", nil) uppercaseString] forState:UIControlStateNormal];
        _showVideo.backgroundColor = UIColor.redColor;
        _showVideo.enabled = NO;
    }
    return _showVideo;
}

-(UILabel * )descriptLabel {
    if (!_descriptLabel) {
        _descriptLabel = [UILabel new];
        _descriptLabel.textAlignment = NSTextAlignmentCenter;
        _descriptLabel.font = [UIFont systemFontOfSize:20.0f weight:UIFontWeightLight];
        _descriptLabel.numberOfLines = 0;
        _descriptLabel.textColor = UIColor.lightGrayColor;
        
        _descriptLabel.text = @"";
    }
    return _descriptLabel;
}

- (UIViewController *)bluredController{
    UIViewController * controller = [UIViewController new];
    controller.view.backgroundColor = UIColor.clearColor;
    
    UIBlurEffect * blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView * blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurView.alpha = 0.4;
    blurView.frame = controller.view.frame;
    [controller.view addSubview:blurView];
    return controller;
}

#pragma mark --- METHODS

- (void) hideTopLvlWindow{
    topLvLwindow.hidden = YES;
}

- (void) showTopLvlWindow{
    topLvLwindow.hidden = NO;
}

- (void) setTextDescription:(NSString *)text{
    self.descriptLabel.text = text;
}

@end
