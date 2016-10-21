//
//  APDCustomContentViewController.m
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 8/9/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDCustomContentViewController.h"
#import "APDCustomContentView.h"

@interface APDCustomContentViewController () <APDNativeAdLoaderDelegate, APDMediaViewDelegate>
{
    APDCustomContentView * _customContentView;
    APDNativeAdLoader * _nativeAdLoader;
    NSArray <__kindof APDNativeAd *> * _nativeArray;
    NSInteger _selectedIndex;
    
    APDMediaView * mediaView;
    APDNativeAd * _nativeAd;
}
@end

@implementation APDCustomContentViewController

- (void)viewDidLoad {
    {
        self.navigationItem.title = self.navigationItem.title = [NSLocalizedString(@"custom content", nil) uppercaseString];
    }
    [super viewDidLoad];
    {
        _customContentView = [[APDCustomContentView alloc] initWithFrame:self.view.frame];
        self.view = _customContentView;
        _selectedIndex = 0;
    }
    
    {
        [_customContentView.nextButton addTarget:self action:@selector(nextButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_customContentView.prevButton addTarget:self action:@selector(prevButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_customContentView.loadNativeButton addTarget:self action:@selector(loadButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    _nativeAd = [_nativeArray firstObject];
    [_nativeAd attachToView:self.view viewController:self];
    
    mediaView = [[APDMediaView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    [mediaView setNativeAd:_nativeAd rootViewController:self];
    mediaView.delegate = self;
    
    mediaView.muted = YES;
    mediaView.skippable = YES;
    mediaView.type = APDMediaViewTypeMainImage; // APDMediaViewTypeIcon
}

- (void)viewWillDisappear:(BOOL)animated{
    [_nativeAd detachFromView];
}

#pragma mark --- APPODEAL LOADER INITIAL

-(void) appodealLoaderInitial{
    
    if (!_nativeAdLoader) {
        _nativeAdLoader = [APDNativeAdLoader new];
        _nativeAdLoader.delegate = self;
    }
    
    [_customContentView.loadNativeButton apdSpinnerShowOnRight];
    [_nativeAdLoader loadAdWithType:self.nativeType];
//    [_nativeAdLoader loadAdWithType:self.nativeType capacity:self.capacityCount];
}

#pragma mark --- ACTIONS

- (IBAction)nextButtonClick:(id)sender {
    if (_selectedIndex + 2 >= [_nativeArray count]) {
        _customContentView.nextButton.hidden = YES;
    }
    _customContentView.prevButton.hidden = NO;
    _selectedIndex += 1;
    [_customContentView updateNativeViewWith:_nativeArray[_selectedIndex] onRootViewController:self];
    _customContentView.countLabel.text = [NSString stringWithFormat:@"%li / %li",_selectedIndex + 1, [_nativeArray count]];
}

- (IBAction)prevButtonClick:(id)sender {
    if (_selectedIndex - 1 <= 0) {
        _customContentView.prevButton.hidden = YES;
    }
    _customContentView.nextButton.hidden = NO;
    _selectedIndex -= 1;
    [_customContentView updateNativeViewWith:_nativeArray[_selectedIndex] onRootViewController:self];
    _customContentView.countLabel.text = [NSString stringWithFormat:@"%li / %li",_selectedIndex + 1, [_nativeArray count]];
}

- (IBAction)loadButtonClick:(id)sender {
    [self appodealLoaderInitial];
}

#pragma mark --- NATIVE_AD_LOADER_DELEGATE

- (void)nativeAdLoader:(APDNativeAdLoader *)loader didLoadNativeAd:(APDNativeAd *)nativeAd{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.view withMessage:@"nativeAdLoader didLoadNativeAd"];
    }
    _nativeArray = [NSArray arrayWithObject:nativeAd];
    [_customContentView.loadNativeButton apdSpinnerHide];
    
    {
        _customContentView.loadNativeButton.enabled = YES;
        _customContentView.loadNativeButton.hidden = YES;
        
        _customContentView.countLabel.hidden = NO;
        _customContentView.prevButton.hidden = YES;
        _customContentView.nextButton.hidden = [_nativeArray count] > 1 ? NO : YES;
        
        [_customContentView updateNativeViewWith:_nativeArray[_selectedIndex] onRootViewController:self];
        _customContentView.countLabel.text = [NSString stringWithFormat:@"%li / %li",_selectedIndex + 1, [_nativeArray count]];
    }
    
    UIView * nativeView = [[UIView alloc] initWithFrame:self.view.frame];
    APDNativeAd * nativeAds = [_nativeArray firstObject];
    UIView * adChoicesView = nativeAds.adChoicesView;
    [adChoicesView setFrame:CGRectMake(0,0,24,24)];
    [nativeView addSubview:adChoicesView];
}

//- (void)nativeAdLoader:(APDNativeAdLoader *)loader didLoadNativeAds:(NSArray <APDNativeAd *>*)nativeAds{
//    if (self.toastMode) {
//        [AppodealToast showToastInView:self.view withMessage:@"nativeAdLoader didLoadNativeAd"];
//    }
//    _nativeArray = nativeAds;
//    [_customContentView.loadNativeButton apdSpinnerHide];
//    
//    {
//        _customContentView.loadNativeButton.enabled = YES;
//        _customContentView.loadNativeButton.hidden = YES;
//        
//        _customContentView.countLabel.hidden = NO;
//        _customContentView.prevButton.hidden = YES;
//        _customContentView.nextButton.hidden = [nativeAds count] > 1 ? NO : YES;
//        
//        [_customContentView updateNativeViewWith:_nativeArray[_selectedIndex] onRootViewController:self];
//        _customContentView.countLabel.text = [NSString stringWithFormat:@"%li / %li",_selectedIndex + 1, [_nativeArray count]];
//    }
//    
//    UIView * nativeView = [[UIView alloc] initWithFrame:self.view.frame];
//    APDNativeAd * nativeAd = [nativeAds firstObject];
//    UIView * adChoicesView = nativeAd.adChoicesView;
//    [adChoicesView setFrame:CGRectMake(0,0,24,24)];
//    [nativeView addSubview:adChoicesView];
//}

- (void)nativeAdLoader:(APDNativeAdLoader *)loader didFailToLoadWithError:(NSError *)error{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.view withMessage:@"nativeAdLoader didFailToLoadWithError"];
    }
    
    {
        _customContentView.loadNativeButton.enabled = YES;
        [_customContentView.loadNativeButton apdSpinnerHide];
    }
}

@end
