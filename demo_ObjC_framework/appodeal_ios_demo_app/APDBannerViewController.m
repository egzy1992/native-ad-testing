//
//  BannerViewController.m
//  apd_test_project
//
//  Created by Lozhkin Ilya on 11/11/16.
//  Copyright © 2016 appodeal. All rights reserved.
//

#import "APDBannerViewController.h"
#import "Masonry.h"

@interface APDBannerViewController () <AppodealBannerDelegate, APDBannerViewRequestDelegate, AppodealBannerViewDelegate, APDBannerViewDelegate>

@property (nonatomic, strong) UIButton * bannerTop;
@property (nonatomic, strong) UIButton * bannerBottom;

@property (nonatomic, strong) AppodealBannerView * bannerViewTop;
@property (nonatomic, strong) AppodealBannerView * bannerViewBottom;

@property (nonatomic, strong) APDBannerView * apdBannerViewTop;
@property (nonatomic, strong) APDBannerView * apdBannerViewBottom;

@property (nonatomic, assign, getter=isTablet) BOOL tablet;

@end

@implementation APDBannerViewController

+ (instancetype)bannerCustom:(BOOL)custom{
    APDBannerViewController * bannerController = [APDBannerViewController new];
    bannerController.custom = custom;
    return bannerController;
}

- (void)viewDidLoad {
    {
        NSString * titleString = @"";
        if (self.deprecateApi && self.custom) {
            titleString = @"Appodeal Banner View";
        } else if (self.deprecateApi) {
            titleString = @"Appodeal Banner";
        } else {
            titleString = @"APD Banner View";
        }
        
        self.navigationItem.title = [NSLocalizedString(titleString, nil) uppercaseString];
    }
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    self.tablet = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ? NO : YES;
    [self updateViewConstraints];
    
    if (self.deprecateApi && !self.custom) {
        [Appodeal setBannerDelegate:self];
    }
    
    [self defAction];
}

- (void) defAction{
    [self.bannerTop addTarget:self action:@selector(bannerTopClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.bannerBottom addTarget:self action:@selector(bannerBottomClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) updateViewConstraints {
    
    [self.bannerTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_centerY);
        make.left.equalTo(self.view).with.offset(20);
        make.right.equalTo(self.view).with.offset(-20);
    }];
    
    [self.bannerBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bannerTop.mas_bottom).with.offset(5);
        make.left.equalTo(self.view).with.offset(20);
        make.right.equalTo(self.view).with.offset(-20);
    }];
    
    
    [super updateViewConstraints];
}

#pragma mark --- Action

- (IBAction)bannerTopClick:(id)sender {
    
    if (self.deprecateApi && self.custom) {
        
        [self.bannerViewTop removeFromSuperview];
        self.bannerViewTop = [[AppodealBannerView alloc] initWithSize:self.isTablet ? kAPDAdSize728x90 : kAPDAdSize320x50 rootViewController:self];
        self.bannerViewTop.delegate = self;
        self.bannerViewTop.requestDelegate = self;
        [self.bannerViewTop loadAd];
        
    } else if (self.deprecateApi) {
        
        [Appodeal showAd:AppodealShowStyleBannerTop rootViewController:self];
        
    } else {
        
        [self.apdBannerViewTop removeFromSuperview];
        self.apdBannerViewTop = [[APDBannerView alloc] initWithSize:self.isTablet ? kAPDAdSize728x90 : kAPDAdSize320x50];
        self.apdBannerViewTop.rootViewController = self;
        self.apdBannerViewTop.delegate = self;
        self.bannerViewBottom.requestDelegate = self;
        [self.apdBannerViewTop loadAd];
    }
}

- (IBAction)bannerBottomClick:(id)sender {
    
    if (self.deprecateApi && self.custom) {
        
        [self.bannerViewBottom removeFromSuperview];
        self.bannerViewBottom = [[AppodealBannerView alloc] initWithSize:self.isTablet ? kAPDAdSize728x90 : kAPDAdSize320x50 rootViewController:self];
        self.bannerViewBottom.delegate = self;
        [self.bannerViewBottom loadAd];
        
    } else if (self.deprecateApi) {
        
        [Appodeal showAd:AppodealShowStyleBannerBottom rootViewController:self];
        
    } else {
        
        [self.apdBannerViewBottom removeFromSuperview];
        self.apdBannerViewBottom = [[APDBannerView alloc] initWithSize:self.isTablet ? kAPDAdSize728x90 : kAPDAdSize320x50];
        self.apdBannerViewBottom.rootViewController = self;
        self.apdBannerViewBottom.delegate = self;
        [self.apdBannerViewBottom loadAd];
    }
}

#pragma mark - APDBannerViewRequestDelegate

- (void)bannerViewDidStartMediation:(APDBannerView *)bannerView {
    NSLog(@"[RRI] Banner start mediation");
}

- (void)bannerView:(APDBannerView *)bannerView willSendRequestToAdNetwork:(NSString *)adNetwork{
    NSLog(@"[RRI] Banner send request for ad network %@", adNetwork);
}

- (void)bannerView:(APDBannerView *)bannerView didRecieveResponseFromAdNetwork:(NSString *)adNetwork wasFilled:(BOOL)filled {
    NSLog(@"[RRI] Banner recieve response from ad network %@, ad was filled %@", adNetwork, filled ? @"true" : @"false");
}

- (void)bannerView:(APDBannerView *)bannerView didFinishMediationAdWasFilled:(BOOL)filled {
    NSLog(@"[RRI] Banner finish mediation, ad was filled %@", filled ? @"true" : @"false");
}

- (void)bannerView:(APDBannerView *)bannerView logImpressionForAdNetwork:(NSString *)adNetwork {
    NSLog(@"[RRI] Banner log imoression from ad network %@", adNetwork);
}

- (void)bannerView:(APDBannerView *)bannerView logClickForAdNetwork:(NSString *)adNetwork {
    NSLog(@"[RRI] Banner log user interaction from ad network %@", adNetwork);
}

#pragma mark --- Property

- (UIButton *) bannerTop {
    if (!_bannerTop) {
        _bannerTop = k_apd_mainButtonWithTitle([NSLocalizedString(@"banner top", nil) uppercaseString]);
        [self.view addSubview:_bannerTop];
    }
    return _bannerTop;
}

- (UIButton *) bannerBottom {
    if (!_bannerBottom) {
        _bannerBottom = k_apd_mainButtonWithTitle([NSLocalizedString(@"banner bottom", nil) uppercaseString]);
        [self.view addSubview:_bannerBottom];
    }
    return _bannerBottom;
}

#pragma mark --- AppodealBannerViewDelegate;

- (void)bannerViewDidLoadAd:(APDBannerView *)bannerView {
    
    if (self.deprecateApi) {
        AppLog(@"%@",[bannerView isEqual:self.bannerViewTop] ? @"banner view top" : @"banner view bottom");
        if ([bannerView isEqual:self.bannerViewTop]) {
            [self bannerViewTopConstrain:bannerView];
        } else {
            [self bannerViewBottomConstrain:bannerView];
        }
    } else {
        AppLog(@"%@",[bannerView isEqual:self.apdBannerViewTop] ? @"banner view top" : @"banner view bottom");
        if ([bannerView isEqual:self.apdBannerViewTop]) {
            [self bannerViewTopConstrain:bannerView];
        } else {
            [self bannerViewBottomConstrain:bannerView];
        }
    }
}

- (void)bannerViewDidRefresh:(APDBannerView *)bannerView {
    if (self.deprecateApi) {
        AppLog(@"%@",[bannerView isEqual:self.bannerViewTop] ? @"banner view top" : @"banner view bottom");
    } else {
        AppLog(@"%@",[bannerView isEqual:self.apdBannerViewTop] ? @"banner view top" : @"banner view bottom");
    }
}

- (void)bannerViewDidInteract:(APDBannerView *)bannerView {
    if (self.deprecateApi) {
        AppLog(@"%@",[bannerView isEqual:self.bannerViewTop] ? @"banner view top" : @"banner view bottom");
    } else {
        AppLog(@"%@",[bannerView isEqual:self.apdBannerViewTop] ? @"banner view top" : @"banner view bottom");
    }
}

- (void)bannerView:(APDBannerView *)bannerView didFailToLoadAdWithError:(NSError *)error {
    if (self.deprecateApi) {
        AppLog(@"%@ --- \nError: %@",[bannerView isEqual:self.bannerViewTop] ? @"banner view top" : @"banner view bottom", error);
    } else {
        AppLog(@"%@ --- \nError: %@",[bannerView isEqual:self.apdBannerViewTop] ? @"banner view top" : @"banner view bottom", error);
    }
}


#pragma mark --- APDBannerView

- (void)precacheBannerViewDidLoadAd:(APDBannerView *)precacheBannerView{
    AppLog();
}

- (void)bannerViewDidReceiveTapAction:(APDBannerView *)bannerView{
    AppLog(@"%@",[bannerView isEqual:self.apdBannerViewTop] ? @"banner view top" : @"banner view bottom");
}

#pragma mark --- Constrain

- (void) bannerViewTopConstrain:(APDBannerView *)banner{
    [self.view addSubview:self.bannerViewTop];
    [self.bannerViewTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.isTablet ? kAPDAdSize728x90 : kAPDAdSize320x50);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(50);
    }];
}

- (void) bannerViewBottomConstrain:(APDBannerView *)banner{
    [self.view addSubview:self.bannerViewBottom];
    [self.bannerViewBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.isTablet ? kAPDAdSize728x90 : kAPDAdSize320x50);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).with.offset(-50);
    }];
}

@end
