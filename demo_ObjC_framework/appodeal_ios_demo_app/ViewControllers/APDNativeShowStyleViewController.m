//
//  APDNativeShowStyleViewController.m
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 6/14/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDNativeShowStyleViewController.h"
#import "APDCustomContentViewController.h"
#import "Masonry.h"
#import "UIView+APD_Spinner.h"
#import <Appodeal/Appodeal.h>
#import "APDNativeAdViewTemplate.h"


@interface APDNativeShowStyleViewController () <APDNativeAdLoaderDelegate>

@property (nonatomic, strong) APDNativeAdLoader * adLoader;
@property (nonatomic, strong) UILabel * informLabel;
@property (nonatomic, strong) UIButton * loadButton;
@property (nonatomic, strong) UIView * currentAdView;

//@property (nonatomic, strong) UISegmentedControl * segmentControl;
//@property (nonatomic, strong) UIButton * customContent;
//@property (nonatomic, strong) UISlider * capacitySlider;

@end

@implementation APDNativeShowStyleViewController

- (void)viewDidLoad {
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self createInformLabel];
    [self layoutInformLabel];
    
    [self createLoadButton];
    [self layoutLoadButton];
    
    [self createAdLoader];
}

#pragma mark - UI

- (void)createInformLabel {
    self.informLabel = [UILabel new];
    self.informLabel.textColor      = [UIColor lightGrayColor];
    self.informLabel.font           = [UIFont systemFontOfSize:10.0];
    self.informLabel.text           = @"Native Ad API v2 beta";
    self.informLabel.textAlignment  = NSTextAlignmentCenter;
}

- (void)createLoadButton {
    self.loadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loadButton addTarget:self
                        action:@selector(loadButtonPressed)
              forControlEvents:UIControlEventTouchUpInside];
    self.loadButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [self.loadButton setTitleColor:[UIColor grayColor]
                          forState:UIControlStateNormal];
    self.loadButton.layer.borderWidth = 0.5f;
    self.loadButton.layer.borderColor = [UIColor grayColor].CGColor;
    self.loadButton.layer.cornerRadius = 2.0f;
    [self.loadButton setTitle:@"Load Ad"
                     forState:UIControlStateNormal];
}

- (void)showActivity {
    self.loadButton.userInteractionEnabled = NO;
    [self.loadButton apdSpinnerShow];
    [self.loadButton setTitle:@"Loading..."
                     forState:UIControlStateNormal];
}

- (void)hideActivity {
    self.loadButton.userInteractionEnabled = YES;
    [self.loadButton apdSpinnerHide];
    [self.loadButton setTitle:@"Reload Ad"
                     forState:UIControlStateNormal];
}

- (void)replaceCurrentAdViewWithView:(UIView *)view {
    [self.currentAdView removeFromSuperview];
    self.currentAdView = view;
    [self.view addSubview:self.currentAdView];
}

#pragma mark - Layout

- (void)layoutInformLabel {
    [self.view addSubview:self.informLabel];
    [self.informLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.and.bottom.equalTo(self.view);
    }];
}

- (void)layoutLoadButton {
    [self.view addSubview:self.loadButton];
    [self.loadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 30));
        make.top.equalTo(self.view).with.offset(70);
        make.centerX.equalTo(self.view);
    }];
}

- (void)layoutAdView {
    [self.currentAdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view).offset(-10);
        make.center.equalTo(self.view);
        make.height.equalTo(@200);
    }];
}

#pragma mark - User Interaction

- (void)loadButtonPressed {
    [self.adLoader loadAd];
    [self showActivity];
}

#pragma mark - Ads 

- (void)createAdLoader {
    self.adLoader = [APDNativeAdLoader new];
    self.adLoader.delegate = self;
    APDNativeAdSettings * settings = [APDNativeAdSettings defaultSettings];
    settings.adViewClass = [APDNativeAdViewTemplate class];
    self.adLoader.settings = settings;
}

#pragma mark - APDNativeAdLoaderDelegate

- (void)nativeAdLoader:(APDNativeAdLoader *)loader
      didLoadNativeAds:(NSArray <__kindof APDNativeAd *> *)nativeAds {
    [self hideActivity];
    [self replaceCurrentAdViewWithView:[nativeAds.firstObject getAdViewForController:self]];
}

- (void)nativeAdLoader:(APDNativeAdLoader *)loader
didFailToLoadWithError:(NSError *)error {
    [self hideActivity];
}

#pragma mark - Legacy

//- (void) viewDidLoad {
//    {
//        self.navigationItem.title = [NSLocalizedString(@"native show context", nil) uppercaseString];
//    }
//    
//    [super viewDidLoad];
//    
//    {
//        self.view.backgroundColor = UIColor.whiteColor;
//        [self updateViewConstraints];
//    }
//    
//    [self.customContent addTarget:self action:@selector(customContentClick:) forControlEvents:UIControlEventTouchUpInside];
//}

//#pragma mark --- ACTIONS
//
//- (IBAction)capacitySliderValueChanged:(UISlider *)sender{
//    int discreteValue = roundl([sender value]);
//    [sender setValue:(float)discreteValue];
//    NSAttributedString * attrString = k_apd_mainAttributedFromMainButton([NSString stringWithFormat:@"%@ (%li)",[NSLocalizedString(@"custom", nil) uppercaseString],@(sender.value).integerValue]);
//    [self.customContent setAttributedTitle:attrString forState:UIControlStateNormal];
//}
//
//#pragma mark --- CONSTRAIN
//
//- (void) updateViewConstraints {
//    
//    [self.customContent mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.view);
//        make.width.equalTo(@250);
//        make.centerY.equalTo(self.view);
//    }];
//    
//    [self.capacitySlider mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.customContent.mas_bottom).with.offset(10);
//        make.width.equalTo(@200);
//        make.centerX.equalTo(self.view);
//    }];
//    
//    [self.segmentControl mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view);
//        make.top.equalTo(self.view).with.offset(64);
//        make.left.equalTo(self.view).with.offset(50);
//        make.right.equalTo(self.view).with.offset(-50);
//    }];
//    
//    [super updateViewConstraints];
//}
//
//#pragma mark --- PROPERTY
//
//- (UIButton *) customContent {
//    if (!_customContent) {
//        _customContent = k_apd_mainButtonWithTitle([NSString stringWithFormat:@"%@ (%li)",[NSLocalizedString(@"custom", nil) uppercaseString],@(self.capacitySlider.value).integerValue]);
//        [self.view addSubview:_customContent];
//    }
//    return _customContent;
//}
//
//- (UISlider *) capacitySlider {
//    if (!_capacitySlider) {
//        _capacitySlider = [[UISlider alloc] init];
//        _capacitySlider.minimumValue = 1;
//        _capacitySlider.maximumValue = 8;
//        _capacitySlider.tintColor = UIColor.redColor;
//        [_capacitySlider addTarget:self action:@selector(capacitySliderValueChanged:) forControlEvents:UIControlEventValueChanged];
//        
//        _capacitySlider.value = 5;
//        
//        [self.view addSubview:_capacitySlider];
//    }
//    return _capacitySlider;
//}
//
//- (UISegmentedControl *) segmentControl {
//    if (!_segmentControl) {
//        _segmentControl = [[UISegmentedControl alloc] initWithItems:@[NSLocalizedString(@"auto", nil), NSLocalizedString(@"video", nil), NSLocalizedString(@"no video", nil)]];
//        _segmentControl.selectedSegmentIndex = 0;
//        _segmentControl.tintColor = UIColor.redColor;
//        
//        _segmentControl.clipsToBounds = YES;
//        _segmentControl.layer.cornerRadius = 4.0f;
//        _segmentControl.layer.borderWidth = 1.0f;
//        _segmentControl.layer.borderColor = UIColor.redColor.CGColor;
//        
//        [self.view addSubview:_segmentControl];
//    }
//    return _segmentControl;
//}
//
//#pragma mark -- Segue
//
//- (IBAction)customContentClick:(id)sender{
//    APDCustomContentViewController * nextController = [APDCustomContentViewController new];
//    nextController.capacityCount = roundl(self.capacitySlider.value);
//    nextController.toastMode = self.toastMode;
//    nextController.nativeType = self.segmentControl.selectedSegmentIndex;
//    [self.navigationController pushViewController:nextController animated:YES];
//}
//

@end
