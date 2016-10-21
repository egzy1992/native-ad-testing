//
//  APDViewabillityPresentationViewController.m
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 8/9/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDViewabillityPresentationViewController.h"
#import "APDViewabillityPresentationView.h"

#import "APDBannerHiddenViewController.h"
#import "APDInterstitialDoubleViewController.h"
#import "APDTripleBannerViewController.h"
#import "APDVideoHiddenViewController.h"

@interface APDViewabillityPresentationViewController ()
{
    APDViewabillityPresentationView * _apdViewabillityView;
}

@end

@implementation APDViewabillityPresentationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    {
        _apdViewabillityView = [[APDViewabillityPresentationView alloc] initWithFrame:self.view.frame];
        self.view = _apdViewabillityView;
    }
    
    {
        [_apdViewabillityView.bannerHiddenButton addTarget:self action:@selector(bannerHiddenClick:) forControlEvents:UIControlEventTouchUpInside];
        [_apdViewabillityView.threeBannerButton addTarget:self action:@selector(threeBannerClick:) forControlEvents:UIControlEventTouchUpInside];
        [_apdViewabillityView.twoInterstitialButton addTarget:self action:@selector(twoInterstitialClick:) forControlEvents:UIControlEventTouchUpInside];
        [_apdViewabillityView.videoHiddenButton addTarget:self action:@selector(videoHiddenClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark --- ACTIONS

-(IBAction)bannerHiddenClick:(id)sender{
    APDBannerHiddenViewController * nextController = [APDBannerHiddenViewController new];
    [self.navigationController pushViewController:nextController animated:YES];
}

-(IBAction)threeBannerClick:(id)sender{
    APDTripleBannerViewController * nextController = [APDTripleBannerViewController new];
    [self.navigationController pushViewController:nextController animated:YES];
}

-(IBAction)twoInterstitialClick:(id)sender{
    APDInterstitialDoubleViewController * nextController = [APDInterstitialDoubleViewController new];
    [self.navigationController pushViewController:nextController animated:YES];
}

-(IBAction)videoHiddenClick:(id)sender{
    APDVideoHiddenViewController * nextController = [APDVideoHiddenViewController new];
    [self.navigationController pushViewController:nextController animated:YES];
}

@end
