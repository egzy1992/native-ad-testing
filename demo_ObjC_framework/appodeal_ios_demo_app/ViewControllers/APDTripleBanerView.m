//
//  APDTripleBanerView.m
//  AppodealApp
//
//  Created by Lozhkin Ilya on 5/24/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDTripleBanerView.h"

@interface APDTripleBanerView ()
{
    
}

@property (nonatomic, strong) UILabel * countLabel;

@end

@implementation APDTripleBanerView

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        
        {
            [self addSubview:self.countLabel];
            self.countLabel.frame = CGRectMake(self.center.x - 40, self.center.y / 2 - 40 + 44, 80, 80);
        }
    }
    return self;
}

#pragma mark --- PROPERTY

-(UILabel * )countLabel {
    if (!_countLabel) {
        _countLabel = [UILabel new];
        _countLabel.textAlignment = NSTextAlignmentCenter;
        _countLabel.font = [UIFont systemFontOfSize:80.0f weight:UIFontWeightLight];
        _countLabel.textColor = UIColor.lightGrayColor;
        
        _countLabel.text = @"0";
    }
    return _countLabel;
}

- (void)setCount:(NSUInteger)count{
    NSUInteger sCount = 0;
    for (UIView * banner in self.subviews) {
        if ([banner isKindOfClass:NSClassFromString(@"APDBannerView")]) {
            [(UIView *)banner setAlpha:0.8];
            sCount += 1;
        }
    }
    self.countLabel.text = @(sCount).stringValue;
}

@end
