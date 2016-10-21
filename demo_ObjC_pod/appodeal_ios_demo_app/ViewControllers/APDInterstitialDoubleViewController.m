//
//  APDInterstitialDoubleViewController.m
//  AppodealApp
//
//  Created by Lozhkin Ilya on 5/24/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDInterstitialDoubleViewController.h"
#import "APDInterstitialDoubleView.h"
#import <Appodeal/Appodeal.h>

@interface APDInterstitialDoubleViewController ()<AppodealInterstitialDelegate>
{
    APDInterstitialDoubleView * _interstitialDoubleView;
}
@end

@implementation APDInterstitialDoubleViewController

- (void) viewDidLoad{
    [super viewDidLoad];
    
    {
        _interstitialDoubleView = [[APDInterstitialDoubleView alloc] initWithFrame:self.view.frame];
        self.view = _interstitialDoubleView;
    }
    
    [self addInterstitials];
}

- (void) addInterstitials{
    AppodealShowStyle style = AppodealShowStyleInterstitial;
    [Appodeal setInterstitialDelegate:self];
    [Appodeal showAd:style rootViewController:self];
}

-(void)interstitialWillPresent{
    
}

@end
