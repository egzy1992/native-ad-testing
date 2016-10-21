//
//  APDBannerHiddenViewController.m
//  AppodealApp
//
//  Created by Lozhkin Ilya on 5/24/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDBannerHiddenViewController.h"
#import "APDBannerHiddenView.h"
#import <Appodeal/Appodeal.h>

@interface APDBannerHiddenViewController ()
{
    APDBannerHiddenView * _bannerHiddenView;
}
@end

@implementation APDBannerHiddenViewController

- (void) viewDidLoad{
    [super viewDidLoad];
    
    {
        _bannerHiddenView = [[APDBannerHiddenView alloc] initWithFrame:self.view.frame];
        self.view = _bannerHiddenView;
    }
    
    [self apdBannerViewOnBottom];
     [_bannerHiddenView setTopView];
}

@end
