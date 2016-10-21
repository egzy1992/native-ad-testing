//
//  UIView+APD_Spinner.m
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 8/11/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "UIView+APD_Spinner.h"
#import "Masonry.h"

@implementation UIView (APD_Spinner)

- (void) apdSpinnerShow {
    UIActivityIndicatorView * spinner = [self spinnerWithStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [spinner startAnimating];
    [self addSubview:spinner];
    
    [spinner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
}

- (void) apdSpinnerShowOnRight {
    UIActivityIndicatorView * spinner = [self spinnerWithStyle:UIActivityIndicatorViewStyleWhite];
    [spinner startAnimating];
    [self addSubview:spinner];
    
    [spinner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).with.offset(-5);
    }];
}

- (void) apdSpinnerHide {
    
    [[self viewWithTag:100] removeFromSuperview];
}

- (UIActivityIndicatorView *) spinnerWithStyle:(UIActivityIndicatorViewStyle)style{
    UIActivityIndicatorView * spinner = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    spinner.tag = 100;
    spinner.activityIndicatorViewStyle = style;
    spinner.color = UIColor.redColor;
    return spinner;
}

@end
