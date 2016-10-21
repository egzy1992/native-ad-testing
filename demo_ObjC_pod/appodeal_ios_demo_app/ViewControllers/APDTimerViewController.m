//
//  APDTimerViewController.m
//  AppodealApp
//
//  Created by Lozhkin Ilya on 5/23/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDTimerViewController.h"
#import "APDTimerView.h"

@interface APDTimerViewController ()
{
    APDTimerView * _timerView;
}
@end

@implementation APDTimerViewController

- (void) viewDidLoad{
    [super viewDidLoad];
    {
        _timerView = [[APDTimerView alloc]initWithFrame:self.view.frame];
        self.view = _timerView;
    }
    
    [self apdBannerViewOnBottom];
}

- (void) viewWillDisappear:(BOOL)animated{
    [_timerView timerStop];
    [super viewWillDisappear:animated];
}

@end
