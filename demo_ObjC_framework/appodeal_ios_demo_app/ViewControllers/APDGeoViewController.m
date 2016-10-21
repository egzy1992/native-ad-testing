//
//  APDGeoViewController.m
//  AppodealApp
//
//  Created by Lozhkin Ilya on 5/23/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDGeoViewController.h"
#import "APDGeoView.h"
#import <Appodeal/Appodeal.h>

@interface APDGeoViewController ()
{
    APDGeoView * _geoView;
}
@end

@implementation APDGeoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    {
        _geoView = [[APDGeoView alloc] initWithFrame:self.view.frame];
        self.view = _geoView;
    }
    [self apdBannerViewOnBottom];
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

@end
