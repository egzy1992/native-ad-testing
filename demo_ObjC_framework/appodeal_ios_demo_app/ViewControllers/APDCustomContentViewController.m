//
//  APDCustomContentViewController.m
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 8/9/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDCustomContentViewController.h"
#import "APDCustomNativeView.h"
#import "Masonry.h"

@interface APDCustomContentViewController () <APDNativeAdLoaderDelegate, APDNativeAdPresentationDelegate>
{
    APDNativeAdLoader * _nativeAdLoader;
    NSArray <__kindof APDNativeAd *> * _nativeArray;
    NSInteger _selectedIndex;
}

@property (nonatomic, strong) UIButton * loadNativeButton;
@property (nonatomic, strong) UIButton * nextButton;
@property (nonatomic, strong) UIButton * prevButton;

@property (nonatomic, strong) UILabel * countLabel;

@property (nonatomic, strong) APDCustomNativeView * customNativeView;

@end

@implementation APDCustomContentViewController

- (void)viewDidLoad {
    {
        self.navigationItem.title = self.navigationItem.title = [NSLocalizedString(@"custom content", nil) uppercaseString];
    }
    [super viewDidLoad];
    {
        self.view.backgroundColor = UIColor.whiteColor;
        _selectedIndex = 0;
    }
    
    {
        [self.nextButton addTarget:self action:@selector(nextButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.prevButton addTarget:self action:@selector(prevButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.loadNativeButton addTarget:self action:@selector(loadButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self updateViewConstraints];
}

#pragma mark --- APPODEAL LOADER INITIAL

-(void) appodealLoaderInitial{
    
    if (!_nativeAdLoader) {
        _nativeAdLoader = [APDNativeAdLoader new];
        _nativeAdLoader.delegate = self;
    }
    
    [self.loadNativeButton apdSpinnerShowOnRight];
    [_nativeAdLoader loadAdWithType:self.nativeType capacity:self.capacityCount];
}

- (void) updateNativeViewWith:(APDNativeAd *)nativeAd onRootViewController:(UIViewController *)controller {
    _customNativeView.hidden = NO;
    [self.customNativeView setNativeAd:nativeAd fromViewController:controller];
}


#pragma mark --- CONSTRAIN

- (void) updateViewConstraints {
    
    [self.customNativeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(self.view).with.offset(-20);
        make.height.lessThanOrEqualTo(@(CGRectGetWidth(self.view.frame)*0.8));
    }];
    
    [self.loadNativeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.customNativeView.mas_bottom).with.offset(10);
        make.width.equalTo(@250);
    }];
    
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.loadNativeButton);
        make.left.equalTo(self.view.mas_centerX).with.offset(10);
        make.width.equalTo(@150);
    }];
    
    [self.prevButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.loadNativeButton);
        make.right.equalTo(self.view.mas_centerX).with.offset(-10);
        make.width.equalTo(@150);
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.customNativeView.mas_top).with.offset(-10);
        make.left.and.right.equalTo(self.view);
    }];
    
    [super updateViewConstraints];
}

#pragma mark --- PROPERTY

- (APDCustomNativeView *) customNativeView {
    if (!_customNativeView) {
        _customNativeView = [[APDCustomNativeView alloc] init];
        
        _customNativeView.layer.borderColor = UIColor.darkGrayColor.CGColor;
        _customNativeView.layer.borderWidth = .9;
        _customNativeView.layer.cornerRadius = 2.;
        
        _customNativeView.hidden = YES; //
        _customNativeView.backgroundColor = [UIColor colorWithWhite:0.90 alpha:1]; 
        [self.view addSubview:_customNativeView];
    }
    return _customNativeView;
}

-(UILabel * )countLabel {
    if (!_countLabel) {
        _countLabel = [UILabel new];
        _countLabel.textAlignment = NSTextAlignmentCenter;
        _countLabel.font = [UIFont systemFontOfSize:80.0f weight:UIFontWeightLight];
        _countLabel.textColor = UIColor.lightGrayColor;
        _countLabel.hidden = YES;
        
        _countLabel.text = @"";
        [self.view addSubview:_countLabel];
    }
    return _countLabel;
}

- (UIButton *) loadNativeButton {
    if (!_loadNativeButton) {
        _loadNativeButton = k_apd_mainButtonWithTitle([NSLocalizedString(@"load native ad", nil) uppercaseString]);
        [self.view addSubview:_loadNativeButton];
    }
    return _loadNativeButton;
}

- (UIButton *) prevButton {
    if (!_prevButton) {
        _prevButton = k_apd_mainButtonWithTitle([NSLocalizedString(@"prev ad", nil) uppercaseString]);
        [self.view addSubview:_prevButton];
        _prevButton.hidden = YES;
    }
    return _prevButton;
}

- (UIButton *) nextButton {
    if (!_nextButton) {
        _nextButton = k_apd_mainButtonWithTitle([NSLocalizedString(@"next ad", nil) uppercaseString]);
        [self.view addSubview:_nextButton];
        _nextButton.hidden = YES;
    }
    return _nextButton;
}

#pragma mark --- ACTIONS

- (IBAction)nextButtonClick:(id)sender {
    if (_selectedIndex + 2 >= [_nativeArray count]) {
        self.nextButton.hidden = YES;
    }
    self.prevButton.hidden = NO;
    _selectedIndex += 1;
    [self updateNativeViewWith:_nativeArray[_selectedIndex] onRootViewController:self];
    self.countLabel.text = [NSString stringWithFormat:@"%li / %li",_selectedIndex + 1, [_nativeArray count]];
}

- (IBAction)prevButtonClick:(id)sender {
    if (_selectedIndex - 1 <= 0) {
        self.prevButton.hidden = YES;
    }
    self.nextButton.hidden = NO;
    _selectedIndex -= 1;
    [self updateNativeViewWith:_nativeArray[_selectedIndex] onRootViewController:self];
    self.countLabel.text = [NSString stringWithFormat:@"%li / %li",_selectedIndex + 1, [_nativeArray count]];
}

- (IBAction)loadButtonClick:(id)sender {
    [self appodealLoaderInitial];
}

#pragma mark --- NATIVE_AD_LOADER_DELEGATE

- (void)nativeAdLoader:(APDNativeAdLoader *)loader didLoadNativeAds:(NSArray <APDNativeAd *>*)nativeAds{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.view withMessage:@"nativeAdLoader didLoadNativeAd"];
    }
    _nativeArray = nativeAds;
    [_nativeArray enumerateObjectsUsingBlock:^(__kindof APDNativeAd * _Nonnull nativeAd, NSUInteger idx, BOOL * _Nonnull stop) {
        nativeAd.delegate = self;
    }];
    [self.loadNativeButton apdSpinnerHide];
    
    {
        self.loadNativeButton.enabled = YES;
        self.loadNativeButton.hidden = YES;
        
        self.countLabel.hidden = NO;
        self.prevButton.hidden = YES;
        self.nextButton.hidden = [nativeAds count] > 1 ? NO : YES;
        
        [self updateNativeViewWith:_nativeArray[_selectedIndex] onRootViewController:self];
        self.countLabel.text = [NSString stringWithFormat:@"%li / %li",_selectedIndex + 1, [_nativeArray count]];
    }
}

- (void)nativeAdLoader:(APDNativeAdLoader *)loader didFailToLoadWithError:(NSError *)error{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.view withMessage:@"nativeAdLoader didFailToLoadWithError"];
    }
    
    {
        self.loadNativeButton.enabled = YES;
        [self.loadNativeButton apdSpinnerHide];
    }
}

#pragma mark - APDNativeAdPresentationDelegate

- (void)nativeAdWillLogImpression:(APDNativeAd *)nativeAd {
    if (self.toastMode) {
        [AppodealToast showToastInView:self.view withMessage:[NSString stringWithFormat:@"nativeAdWillLogImpression at index %lu", (unsigned long)[_nativeArray indexOfObject:nativeAd]]];
    }
}

- (void)nativeAdWillLogUserInteraction:(APDNativeAd *)nativeAd {
    if (self.toastMode) {
        [AppodealToast showToastInView:self.view withMessage:[NSString stringWithFormat:@"nativeAdWillLogUserInteraction at index %lu", (unsigned long)[_nativeArray indexOfObject:nativeAd]]];
    }
}

@end
