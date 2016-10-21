//
//  APDBannerHiddenView.m
//  AppodealApp
//
//  Created by Lozhkin Ilya on 5/24/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDBannerHiddenView.h"
#import <Appodeal/Appodeal.h>

@interface APDBannerHiddenView ()
{
    
}
@property (nonatomic, strong) UIView * heightView;

@end

@implementation APDBannerHiddenView

-(instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        
        {
            [self addSubview:self.heightView];
            [self.heightView addSubview:self.hideBannerButton];
            
            self.hideBannerButton.frame = CGRectMake(self.center.x - 75, self.center.y - 25, 150, 50);
        }
    }
    return self;
}

#pragma mark --- PROPERTY

-(UIView *) heightView {
    if (!_heightView) {
        _heightView = [[UIView alloc] initWithFrame:self.frame];
        _heightView.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.3];
    }
    return _heightView;
}

- (UIButton *) hideBannerButton {
    if (!_hideBannerButton) {
        _hideBannerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _hideBannerButton.layer.cornerRadius = 5.0;
        _hideBannerButton.clipsToBounds = YES;
        [_hideBannerButton setTitle:[NSLocalizedString(@"hide banner", nil) uppercaseString] forState:UIControlStateNormal];
        [_hideBannerButton setTitle:[NSLocalizedString(@"show banner", nil) uppercaseString] forState:UIControlStateSelected];
        _hideBannerButton.backgroundColor = UIColor.redColor;
        
        [_hideBannerButton addTarget:self action:@selector(hideBanner:) forControlEvents:UIControlEventTouchUpInside];
        _hideBannerButton.hidden = YES;
    }
    return _hideBannerButton;
}

#pragma mark --- PUBLIC

- (void) setTopView{
    _hideBannerButton.hidden = NO;
    [self insertSubview:self.heightView aboveSubview:[self.subviews lastObject]];
}

#pragma mark --- ACTION

-(IBAction)hideBanner:(id)sender{
    if (self.hideBannerButton.selected) {
        self.hideBannerButton.selected = NO;
        
        for (id banner in self.subviews) {
            if ([banner isKindOfClass:NSClassFromString(@"APDBannerView")]) {
                [(UIView *)banner setHidden:NO];
            }
        }
    } else {
        self.hideBannerButton.selected = YES;
        
        for (id banner in self.subviews) {
            if ([banner isKindOfClass:NSClassFromString(@"APDBannerView")]) {
                [(UIView *)banner setHidden:YES];
            }
        }
    }
    
}

@end
