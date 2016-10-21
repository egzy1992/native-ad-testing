//
//  APDBannerViewShowStyleViewController.m
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 6/13/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDBannerViewShowStyleViewController.h"
#import "APDBannerViewShowStyleView.h"
#import "APDBannerViewInTableViewController.h"
#import "APDBannerViewInCollectionViewController.h"

@interface APDBannerViewShowStyleViewController ()
{
    APDBannerViewShowStyleView * _bannerViewShowStyleView;
}
@end

@implementation APDBannerViewShowStyleViewController

- (void) viewDidLoad {
    
    {
        self.navigationItem.title = [NSLocalizedString(@"banner show context", nil) uppercaseString];
    }
    
    [super viewDidLoad];
    
    {
        _bannerViewShowStyleView = [[APDBannerViewShowStyleView alloc] initWithFrame:self.view.frame];
        self.view = _bannerViewShowStyleView;
    }
    
    {
        [_bannerViewShowStyleView.tableBanner addTarget:self action:@selector(bannerInTableClick:) forControlEvents:UIControlEventTouchUpInside];
        [_bannerViewShowStyleView.collectionBanner addTarget:self action:@selector(bannerInCollectionClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark --- ACTIONS

-(IBAction)bannerInTableClick:(id)sender{
    APDBannerViewInTableViewController * nextController = [APDBannerViewInTableViewController new];
    nextController.toastMode = self.toastMode;
    [self.navigationController pushViewController:nextController animated:YES];
}

-(IBAction)bannerInCollectionClick:(id)sender{
    APDBannerViewInCollectionViewController * nextController = [APDBannerViewInCollectionViewController new];
    nextController.toastMode = self.toastMode;
    [self.navigationController pushViewController:nextController animated:YES];
}

@end
