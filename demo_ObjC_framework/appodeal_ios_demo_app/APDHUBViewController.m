//
//  APDHUBViewController.m
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 11/18/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDHUBViewController.h"
#import "APDViewModel.h"
#import "Masonry.h"

#import "APDBannerViewController.h"
#import "APDMRECViewController.h"
#import "APDNativeShowStyleViewController.h"
#import "APDBackgroundWorkPresentationViewController.h"
#import "APDViewabillityPresentationViewController.h"

@interface APDHUBViewController () <AppodealInterstitialDelegate, AppodealRewardedVideoDelegate, APDInterstitalAdDelegate, APDRewardedVideoDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableDictionary * cellStatusName;

@property (nonatomic, strong) APDRewardedVideo * rewardedVideo;
@property (nonatomic, strong) APDInterstitialAd * interstitial;

@end

@implementation APDHUBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateViewConstraints];
    
    {
        self.view.backgroundColor = UIColor.whiteColor;
    }
    
    {
        [Appodeal setInterstitialDelegate:self];
        [Appodeal setRewardedVideoDelegate:self];
    }
}

- (void) updateViewConstraints{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [super updateViewConstraints];
}

#pragma mark --- StatusName

- (NSMutableDictionary *) cellStatusName {
    if (!_cellStatusName) {
        NSString * statusString = self.isAutoCache && self.deprecateApi ? @"load" : @"";
        NSDictionary * cellName = @{[self i_Ps:0 index:0] : NSLocalizedString(statusString, nil),
                                    [self i_Ps:1 index:0] : NSLocalizedString(statusString, nil)};
        
        _cellStatusName = [[NSMutableDictionary alloc] initWithDictionary:cellName];
    }
    return _cellStatusName;
    
}

#pragma mark --- Property

-(UITableView *) tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.scrollEnabled = YES;
        _tableView.estimatedRowHeight = 44.0f;
        _tableView.estimatedSectionHeaderHeight = 44.0f;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [self.tableView registerClass:[DescriptionCell class] forCellReuseIdentifier:NSStringFromClass(self.class)];
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"next"];
        
        [self.view addSubview: _tableView];
    }
    return _tableView;
}

-(UIView *) headerView:(NSString *)title tintColor:(UIColor *)tintColor fontSize:(CGFloat)fontSize backgroundColor:(UIColor *)backgroundColor{
    UILabel * newLabel = [UILabel new];
    UIView * view = [UIView new];
    view.backgroundColor = backgroundColor;
    
    {
        [view addSubview:newLabel];
    }
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName: tintColor,
                                 NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Light" size:fontSize],
                                 NSKernAttributeName: @2};
    newLabel.attributedText = [[NSAttributedString alloc] initWithString:title attributes:attributes];
    
    [newLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view).with.offset(25);
        make.left.equalTo(view).with.offset(15);
        make.right.equalTo(view).with.offset(5);
        make.bottom.equalTo(view).with.offset(-2);
    }];
    
    return view;
}

- (NSIndexPath *) i_Ps:(NSUInteger)section index:(NSInteger)index{
    return [NSIndexPath indexPathForRow:index inSection:section];
}

#pragma mark --- APD_STATUS

-(void)apd_updateInterstitialStatusWithStatus:(APD_STATUS)status{
    NSIndexPath * indexPath = [self i_Ps:0 index:0];
    NSString * statusString = @"";
    
    switch (status) {
        case kAPD_STATUS_LOAD:
        {
            statusString = NSLocalizedString(@"interstitial start load", nil);
        } break;
        case kAPD_STATUS_FAIL_TO_LOAD:
        {
            statusString = NSLocalizedString(@"interstitial did fail to load", nil);
        } break;
        case kAPD_STATUS_FAIL_TO_PRESENT:
        {
            statusString = NSLocalizedString(@"interstitial did fail to present", nil);
        } break;
        case kAPD_STATUS_LOADED:
        {
            statusString = NSLocalizedString(@"interstitial loaded", nil);
        } break;
        case kAPD_STATUS_PRESENTED:
        {
            statusString = NSLocalizedString(@"interstitial presented", nil);
        } break;
        case kAPD_STATUS_NILL:
        {
            statusString = NSLocalizedString(@"", nil);
        } break;
    }
    
    _cellStatusName[indexPath] = statusString;
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
}


-(void)apd_updateRewardedVideoStatusWithStatus:(APD_STATUS)status{
    NSIndexPath * indexPath = [self i_Ps:1 index:0];
    NSString * statusString = @"";
    
    switch (status) {
        case kAPD_STATUS_LOAD:
        {
            statusString = NSLocalizedString(@"rewarded video start load", nil);
        } break;
        case kAPD_STATUS_FAIL_TO_LOAD:
        {
            statusString = NSLocalizedString(@"rewarded video did fail to load", nil);
        } break;
        case kAPD_STATUS_FAIL_TO_PRESENT:
        {
            statusString = NSLocalizedString(@"rewarded video did fail to present", nil);
        } break;
        case kAPD_STATUS_LOADED:
        {
            statusString = NSLocalizedString(@"rewarded video loaded", nil);
        } break;
        case kAPD_STATUS_PRESENTED:
        {
            statusString = NSLocalizedString(@"rewarded video presented", nil);
        } break;
        case kAPD_STATUS_NILL:
        {
            statusString = NSLocalizedString(@"", nil);
        } break;
    }
    
    _cellStatusName[indexPath] = statusString;
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
}


#pragma mark --- tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0: return 1; break;
        case 1: return 1; break;
        case 2: if (self.isDeprecateApi) return 3; else return 2; break;
        case 3: return 1; break;
        case 4: return 2; break;
        default: break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self.class) forIndexPath:indexPath];
    if (indexPath.section > 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"next" forIndexPath:indexPath];
    }
    
    NSString * text = @"";
    NSString * detail = self.cellStatusName[indexPath] ? self.cellStatusName[indexPath] : @"";
    
    switch (indexPath.section) {
        case 0: text = @"Interstitial";                             break;
        case 1: text = @"Rewarded Video";                           break;
        case 2:
        {
            if (self.deprecateApi) {
                switch (indexPath.row) {
                    case 0: text = @"Appodeal Banner";              break;
                    case 1: text = @"Appodeal Custom Banner";       break;
                    case 2: text = @"MREC"; break;
                } break;
            } else {
                switch (indexPath.row) {
                    case 0: text = @"Appodeal Custom Banner";       break;
                    case 1: text = @"MREC";                         break;
                } break;
            }
        } break;
        case 3: text = @"Native Ads";                               break;
        case 4:
            switch (indexPath.row) {
                case 0: text = @"Background Work";                  break;
                case 1: text = @"Viewabillity";                     break;
            } break;
    }
    
    NSDictionary *attributesDetail = @{NSForegroundColorAttributeName: UIColor.lightGrayColor,
                                       NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:12],
                                       NSKernAttributeName: @(1.2)};
    NSDictionary *attributesMainText = @{NSForegroundColorAttributeName: UIColor.blackColor,
                                         NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:16],
                                         NSKernAttributeName: @(1.2)};
    
    cell.textLabel.attributedText = [[NSAttributedString alloc] initWithString:text attributes:attributesMainText];
    
    if (indexPath.section <= 1) {
        cell.detailTextLabel.attributedText = [[NSAttributedString alloc] initWithString:detail attributes:attributesDetail];
    } else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            if (self.deprecateApi) {
                [Appodeal showAd:AppodealShowStyleInterstitial rootViewController:self];
            } else {
                if (!_interstitial || [_interstitial hasBeenPresented]) {
                    _interstitial = [[APDInterstitialAd alloc] init];
                    _interstitial.delegate = self;
                }
                if ([_interstitial isReady]) {
                    [_interstitial presentFromViewController:self];
                } else {
                    [self apd_updateInterstitialStatusWithStatus:kAPD_STATUS_LOAD];
                    [_interstitial loadAd];
                }
            }
        } break;
        case 1:
        {
            if (self.deprecateApi) {
                [Appodeal showAd:AppodealShowStyleRewardedVideo rootViewController:self];
            } else {
                if (!_rewardedVideo) {
                    _rewardedVideo =[[APDRewardedVideo alloc] init];
                    _rewardedVideo.delegate = self;
                }
                
                if ([_rewardedVideo isReady]) {
                    [_rewardedVideo presentFromViewController:self];
                    [self apd_updateRewardedVideoStatusWithStatus:kAPD_STATUS_PRESENTED];
                } else {
                    [self apd_updateRewardedVideoStatusWithStatus:kAPD_STATUS_LOAD];
                    [_rewardedVideo loadAd];
                }
            }
        } break;
        case 2:
        {
            if (self.deprecateApi) {
                switch (indexPath.row) {
                    case 0: [self pushOnViewController:[APDBannerViewController bannerCustom:NO]];                  break; // banner
                    case 1: [self pushOnViewController:[APDBannerViewController bannerCustom:YES]];                 break; // custom banner
                    case 2: [self pushOnViewController:[APDMRECViewController new]];                                break; // mrec
                } break;
            } else {
                switch (indexPath.row) {
                    case 0: [self pushOnViewController:[APDBannerViewController bannerCustom:YES]];                 break; // custom banner
                    case 1: [self pushOnViewController:[APDMRECViewController new]];                                break; // mrec
                } break;
            }
        } break;
        case 3:
        {
             [self pushOnViewController: [APDNativeShowStyleViewController new]];
        } break;
        case 4:
            switch (indexPath.row) {
                case 0:
                {
                     [self pushOnViewController:[APDBackgroundWorkPresentationViewController new]];
                } break;
                case 1:
                {
                    [self pushOnViewController:[APDViewabillityPresentationViewController new]];
                    
                } break;
            } break;
    }
}

- (void) pushOnViewController:(APDRootViewController *)controller {
    controller.toastMode = self.toastMode;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void) appodealShow:(AppodealShowStyle)style{
    BOOL isReady = [Appodeal isReadyForShowWithStyle:style];
    BOOL isShow = [Appodeal showAd:style rootViewController:self];
    
    NSLog(@"\nAppodeal isReady : %@\nAppodeal show : %@\n", isReady ? @"YES" : @"NO", isShow ? @"YES" : @"NO");
}

#pragma mark --- APPODEAL_INTERSTITIAL_DELEGATE

- (void)interstitialDidLoadAdisPrecache:(BOOL)precache{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.tableView withMessage:@"interstitialDidLoadAdisPrecache"];
    }
    [self apd_updateInterstitialStatusWithStatus:kAPD_STATUS_LOADED];
    AppLog()
}
- (void)interstitialDidFailToLoadAd{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.tableView withMessage:@"interstitialDidFailToLoadAd"];
    }
    [self apd_updateInterstitialStatusWithStatus:kAPD_STATUS_FAIL_TO_LOAD];
    AppLog()
}
- (void)interstitialWillPresent{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.tableView withMessage:@"interstitialWillPresent"];
    }
    [self apd_updateInterstitialStatusWithStatus:kAPD_STATUS_PRESENTED];
    AppLog()
}
- (void)interstitialDidDismiss{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.tableView withMessage:@"interstitialDidDismiss"];
    }
    AppLog(@"\n")
    //    [self apd_updateInterstitialStatusWithStatus:kAPD_STATUS_NILL];
}
- (void)interstitialDidClick{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.tableView withMessage:@"interstitialDidClick"];
    }
    AppLog()
}

#pragma mark --- APPODEAL_REWARDED_VIDEO_DELEGATE

- (void)rewardedVideoDidLoadAd{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.tableView withMessage:@"rewardedVideoDidLoadAd"];
    }
    AppLog()
    [self apd_updateRewardedVideoStatusWithStatus:kAPD_STATUS_LOADED];
}
- (void)rewardedVideoDidFailToLoadAd{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.tableView withMessage:@"rewardedVideoDidFailToLoadAd"];
    }
    AppLog()
    [self apd_updateRewardedVideoStatusWithStatus:kAPD_STATUS_FAIL_TO_LOAD];
}
- (void)rewardedVideoDidPresent{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.tableView withMessage:@"rewardedVideoDidPresent"];
    }
    AppLog()
    [self apd_updateRewardedVideoStatusWithStatus:kAPD_STATUS_PRESENTED];
}
- (void)rewardedVideoWillDismiss{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.tableView withMessage:@"rewardedVideoWillDismiss"];
    }
    AppLog(@"\n")
    //    [self apd_updateRewardedVideoStatusWithStatus:kAPD_STATUS_NILL];
}
- (void)rewardedVideoDidFinish:(NSUInteger)rewardAmount name:(NSString *)rewardName{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.tableView withMessage:@"rewardedVideoDidFinish"];
    }
    AppLog(@"reward name: %@", rewardName)
}
- (void)rewardedVideoDidClick{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.tableView withMessage:@"rewardedVideoDidClick"];
    }
    AppLog()
}

#pragma mark -----------------


#pragma mark --- INTERSTITIAL_DELEGATE

// Call when interstital did load
- (void)interstitialAdDidLoad:(APDInterstitialAd *)interstitialAd{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.tableView withMessage:@"interstitialAdDidLoad"];
    }
    [self apd_updateInterstitialStatusWithStatus:kAPD_STATUS_LOADED];
    AppLog()
}

// Call if usePrecache set to YES, and precache (cheap and fast) interstital did load
- (void)precacheInterstitialAdDidLoad:(APDInterstitialAd *)precacheInterstitial{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.tableView withMessage:@"precacheInterstitialAdDidLoad"];
    }
    AppLog()
}

// Call if interstitial did fail while loading
- (void)interstitialAd:(APDInterstitialAd *)interstitialAd didFailToLoadWithError:(NSError *)error{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.tableView withMessage:@"interstitialAd didFailToLoadWithError"];
    }
    [self apd_updateInterstitialStatusWithStatus:kAPD_STATUS_FAIL_TO_LOAD];
    _interstitial = nil;
    AppLog(@"\n")
}

// Call after interstital present screen
- (void)interstitialAdDidAppear:(APDInterstitialAd *)interstitialAd{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.tableView withMessage:@"interstitialAdDidAppear"];
    }
    [self apd_updateInterstitialStatusWithStatus:kAPD_STATUS_PRESENTED];
    AppLog()
}

// Call after interstital dismissed from screen
- (void)interstitialAdDidDisappear:(APDInterstitialAd *)interstitialAd{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.tableView withMessage:@"interstitialAdDidDisappear"];
    }
    [self apd_updateInterstitialStatusWithStatus:kAPD_STATUS_NILL];
    _interstitial = nil;
    AppLog(@"\n")
}

// Call if interstitial did fail while presenting
- (void)interstitialAd:(APDInterstitialAd *)interstitialAd didFailToPresentWithError:(NSError *)error{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.tableView withMessage:@"interstitialAd didFailToPresentWithError"];
    }
    [self apd_updateInterstitialStatusWithStatus:kAPD_STATUS_FAIL_TO_PRESENT];
    _interstitial = nil;
    AppLog(@"\n")
}

// Call when user tap on interstital
- (void)interstitialAdDidRecieveTapAction:(APDInterstitialAd *)interstitialAd{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.tableView withMessage:@"interstitialAdDidRecieveTapAction"];
    }
    AppLog()
}


#pragma mark --- REWARDED_VIDEO_DELEGATE

- (void)rewardedVideoDidLoad:(APDRewardedVideo *)rewardedVideo{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.tableView withMessage:@"rewardedVideoDidLoad"];
    }
    [self apd_updateRewardedVideoStatusWithStatus:kAPD_STATUS_LOADED];
    AppLog()
}

- (void)rewardedVideo:(APDRewardedVideo *)rewardedVideo didFailToLoadWithError:(NSError *)error{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.tableView withMessage:@"rewardedVideo didFailToLoadWithError"];
    }
    [self apd_updateRewardedVideoStatusWithStatus:kAPD_STATUS_FAIL_TO_LOAD];
    _rewardedVideo = nil;
    AppLog(@"%@\n",error)
}

- (void)rewardedVideoDidBecomeUnavailable:(APDRewardedVideo *)rewardedVideo{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.tableView withMessage:@"rewardedVideoDidBecomeUnavailable"];
    }
    AppLog()
}

- (void)rewardedVideoDidAppear:(APDRewardedVideo *)rewardedVideo{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.tableView withMessage:@"rewardedVideoDidAppear"];
    }
    AppLog()
}

- (void)rewardedVideoDidDisappear:(APDRewardedVideo *)rewardedVideo{
    
    if (self.toastMode) {
        [AppodealToast showToastInView:self.tableView withMessage:@"rewardedVideoDidDisappear"];
    }
    [self apd_updateRewardedVideoStatusWithStatus:kAPD_STATUS_NILL];
    _rewardedVideo = nil;
    AppLog(@"\n")
}

- (void)rewardedVideo:(APDRewardedVideo *)rewardedVideo didFinishWithReward:(id<APDReward>)reward{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.tableView withMessage:@"rewardedVideo didFinishWithReward"];
    }
    AppLog(@"reward: %@ - %li",reward.currencyName, reward.amount)
}

- (void)rewardedVideo:(APDRewardedVideo *)rewardedVideo didFailToPresentWithError:(NSError *)error{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.tableView withMessage:@"rewardedVideo didFailToPresentWithError"];
    }
    [self apd_updateRewardedVideoStatusWithStatus:kAPD_STATUS_FAIL_TO_PRESENT];
    _rewardedVideo = nil;
    AppLog(@"%@\n",error);
}

@end
