//
//  APDFavoriteAdTypePresentationViewController.m
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 6/10/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDFavoriteAdTypePresentationViewController.h"
#import "APDFavoriteAdTypePresentationView.h"
#import "APDBannerViewShowStyleViewController.h"
#import "APDMRECBannerViewController.h"
#import "APDNativeShowStyleViewController.h"
#import "APDBackgroundWorkPresentationViewController.h"
#import "APDViewabillityPresentationViewController.h"

#import "APDSVC.h"

#import <Appodeal/Appodeal.h>

@interface APDFavoriteAdTypePresentationViewController ()<UITableViewDelegate, UITableViewDataSource, APDInterstitalAdDelegate, APDSkippableVideoDelegate, APDRewardedVideoDelegate>
{
    APDFavoriteAdTypePresentationView * _presentationView;
    NSMutableDictionary * _cellDictName;
    NSMutableDictionary * _cellHeaderName;
    NSMutableDictionary * _cellStatusName;
    
    APDInterstitialAd * _interstitial;
    APDSkippableVideo * _skippableVideo;
    APDRewardedVideo * _rewardedVideo;
}
@end

@implementation APDFavoriteAdTypePresentationViewController

- (void) viewDidLoad {
    {
        self.navigationItem.title = [NSLocalizedString(@"Presentation AD", nil) uppercaseString];
    }
    
    [super viewDidLoad];
    
    {
        _presentationView = [[APDFavoriteAdTypePresentationView alloc] initWithFrame:self.view.frame];
        self.view = _presentationView;
    }
    
    {
        _presentationView.tableView.delegate = self;
        _presentationView.tableView.dataSource = self;
    }
    
    {
        _cellDictName = [self cellDictName];
        _cellHeaderName = [self cellHeaderName];
        _cellStatusName = [self cellStatusName];
    }
}

#pragma mark --- CELL_NAME

- (NSMutableDictionary *) cellDictName {
    if (!_cellDictName) {
        NSDictionary * cellName = @{[self i_Ps:0 index:0] : NSLocalizedString(@"Interstitial", nil),
                                    [self i_Ps:0 index:1] : NSLocalizedString(@"Skippable Video", nil),
                                    [self i_Ps:0 index:2] : NSLocalizedString(@"Rewarded video", nil),
                                    [self i_Ps:1 index:0] : NSLocalizedString(@"Banner",nil),
                                    [self i_Ps:1 index:1] : NSLocalizedString(@"MREC",nil),
                                    [self i_Ps:2 index:0] : NSLocalizedString(@"Native ADS", nil),
                                    [self i_Ps:3 index:0] : NSLocalizedString(@"Background Work", nil),
                                    [self i_Ps:4 index:0] : NSLocalizedString(@"Viewabillity", nil)};
        
        _cellDictName = [[NSMutableDictionary alloc] initWithDictionary:cellName];
    }
    return _cellDictName;
}

- (NSMutableDictionary *) cellHeaderName{
    if (!_cellHeaderName) {
        NSDictionary * cellName = @{@0 : NSLocalizedString(@"Presented", nil),
                                    @1 : NSLocalizedString(@"Banner", nil),
                                    @1 : NSLocalizedString(@"Native", nil),
                                    @1 : NSLocalizedString(@"Background Work", nil),
                                    @1 : NSLocalizedString(@"Viewabillity", nil)};
        
        _cellHeaderName = [[NSMutableDictionary alloc] initWithDictionary:cellName];
    }
    return _cellHeaderName;
}


- (NSMutableDictionary *) cellStatusName {
    if (!_cellStatusName) {
        NSDictionary * cellName = @{[self i_Ps:0 index:0] : NSLocalizedString(@"", nil),
                                    [self i_Ps:0 index:1] : NSLocalizedString(@"", nil),
                                    [self i_Ps:0 index:2] : NSLocalizedString(@"", nil)};
        
        _cellStatusName = [[NSMutableDictionary alloc] initWithDictionary:cellName];
    }
    return _cellStatusName;

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
    [_presentationView.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)apd_updateVideoStatusWithStatus:(APD_STATUS)status{
    NSIndexPath * indexPath = [self i_Ps:0 index:1];
    NSString * statusString = @"";
    
    switch (status) {
        case kAPD_STATUS_LOAD:
        {
            statusString = NSLocalizedString(@"video start load", nil);
        } break;
        case kAPD_STATUS_FAIL_TO_LOAD:
        {
            statusString = NSLocalizedString(@"video did fail to load", nil);
        } break;
        case kAPD_STATUS_FAIL_TO_PRESENT:
        {
            statusString = NSLocalizedString(@"video did fail to present", nil);
        } break;
        case kAPD_STATUS_LOADED:
        {
            statusString = NSLocalizedString(@"video loaded", nil);
        } break;
        case kAPD_STATUS_PRESENTED:
        {
            statusString = NSLocalizedString(@"video presented", nil);
        } break;
        case kAPD_STATUS_NILL:
        {
            statusString = NSLocalizedString(@"", nil);
        } break;
    }
    
    _cellStatusName[indexPath] = statusString;
    [_presentationView.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)apd_updateRewardedVideoStatusWithStatus:(APD_STATUS)status{
    NSIndexPath * indexPath = [self i_Ps:0 index:2];
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
    [_presentationView.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark --- TABLE_VIEW_DELEGATE

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? 3 : section == 1 ?  2 : 1;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (!_cellHeaderName[@(section)]) {
        return nil;
    }
    
    return [_presentationView headerView:[_cellHeaderName[@(section)] uppercaseString]
                               tintColor:UIColor.blackColor
                                fontSize:12
                         backgroundColor:[UIColor colorWithWhite:0.95 alpha:1]];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellName = NSStringFromClass([self class]);
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellName];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (_cellDictName[indexPath]) {
        NSDictionary *attributes = @{NSForegroundColorAttributeName: UIColor.blackColor,
                                     NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:16],
                                     NSKernAttributeName: @(1.2)};
        cell.textLabel.attributedText = [[NSAttributedString alloc] initWithString:_cellDictName[indexPath] attributes:attributes];
    }
    
    if (_cellStatusName[indexPath]) {
        NSDictionary *attributes = @{NSForegroundColorAttributeName: UIColor.lightGrayColor,
                                     NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:12],
                                     NSKernAttributeName: @(1.2)};
        cell.detailTextLabel.attributedText = [[NSAttributedString alloc] initWithString:_cellStatusName[indexPath] attributes:attributes];
    }
    
    switch (indexPath.section) {
        case 0:
        {
            
        } break;
        case 1:
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } break;
        case 2:
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } break;
        case 3:
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } break;
        case 4:
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } break;
    }
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0: // INTERSTITIAL
                {
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
                } break;
                case 1: // SKIPPABLE
                {
                    if (!_skippableVideo) {
                        _skippableVideo = [[APDSkippableVideo alloc] init];
                        _skippableVideo.delegate = self;
                    }
                    
                    if ([_skippableVideo isReady]) {
                        [_skippableVideo presentFromViewController:self];
                        [self apd_updateVideoStatusWithStatus:kAPD_STATUS_PRESENTED];
                    } else {
                        [self apd_updateVideoStatusWithStatus:kAPD_STATUS_LOAD];
                        [_skippableVideo loadAd];
                    }
                    
                    
                } break;
                case 2: // REWARDED VIDEO
                {
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
                } break;
            }
        } break;
        case 1: // BANNER
        {
            switch (indexPath.row) {
                case 0: // BANNER
                {
                    APDBannerViewShowStyleViewController * nextController = [APDBannerViewShowStyleViewController new];
                    nextController.toastMode = self.toastMode;
                    [self.navigationController pushViewController:nextController animated:YES];
                } break;
                case 1: // MREC
                {
                    APDMRECBannerViewController * nextController = [APDMRECBannerViewController new];
                    nextController.toastMode = self.toastMode;
                    [self.navigationController pushViewController:nextController animated:YES];
                } break;
            }
        } break;
        case 2: // NATIVE
        {
            APDNativeShowStyleViewController * nextController = [APDNativeShowStyleViewController new];
            nextController.toastMode = self.toastMode;
            [self.navigationController pushViewController:nextController animated:YES];
        } break;
        case 3: // BACKGROUND WORK
        {
            APDBackgroundWorkPresentationViewController * nextController = [APDBackgroundWorkPresentationViewController new];
            nextController.toastMode = self.toastMode;
            [self.navigationController pushViewController:nextController animated:YES];
        } break;
        case 4: // VIEWABILLITY
        {
//            APDSVC * nextController = [APDSVC new];
            APDViewabillityPresentationViewController * nextController = [APDViewabillityPresentationViewController new];
            nextController.toastMode = self.toastMode;
            [self.navigationController pushViewController:nextController animated:YES];
        } break;
    }
}

#pragma mark --- INTERSTITIAL_DELEGATE

// Call when interstital did load
- (void)interstitialAdDidLoad:(APDInterstitialAd *)interstitialAd{
    if (self.toastMode) {
        [AppodealToast showToastInView:_presentationView.tableView withMessage:@"interstitialAdDidLoad"];
    }
    [self apd_updateInterstitialStatusWithStatus:kAPD_STATUS_LOADED];
}

// Call if usePrecache set to YES, and precache (cheap and fast) interstital did load
- (void)precacheInterstitialAdDidLoad:(APDInterstitialAd *)precacheInterstitial{
    if (self.toastMode) {
        [AppodealToast showToastInView:_presentationView.tableView withMessage:@"precacheInterstitialAdDidLoad"];
    }
}

// Call if interstitial did fail while loading
- (void)interstitialAd:(APDInterstitialAd *)interstitialAd didFailToLoadWithError:(NSError *)error{
    if (self.toastMode) {
        [AppodealToast showToastInView:_presentationView.tableView withMessage:@"interstitialAd didFailToLoadWithError"];
    }
    [self apd_updateInterstitialStatusWithStatus:kAPD_STATUS_FAIL_TO_LOAD];
    _interstitial = nil;
}

// Call after interstital present screen
- (void)interstitialAdDidAppear:(APDInterstitialAd *)interstitialAd{
    if (self.toastMode) {
        [AppodealToast showToastInView:_presentationView.tableView withMessage:@"interstitialAdDidAppear"];
    }
    [self apd_updateInterstitialStatusWithStatus:kAPD_STATUS_PRESENTED];
}

// Call after interstital dismissed from screen
- (void)interstitialAdDidDisappear:(APDInterstitialAd *)interstitialAd{
    if (self.toastMode) {
        [AppodealToast showToastInView:_presentationView.tableView withMessage:@"interstitialAdDidDisappear"];
    }
    [self apd_updateInterstitialStatusWithStatus:kAPD_STATUS_NILL];
    _interstitial = nil;
}

// Call if interstitial did fail while presenting
- (void)interstitialAd:(APDInterstitialAd *)interstitialAd didFailToPresentWithError:(NSError *)error{
    if (self.toastMode) {
        [AppodealToast showToastInView:_presentationView.tableView withMessage:@"interstitialAd didFailToPresentWithError"];
    }
    [self apd_updateInterstitialStatusWithStatus:kAPD_STATUS_FAIL_TO_PRESENT];
    _interstitial = nil;
}

// Call when user tap on interstital
- (void)interstitialAdDidRecieveTapAction:(APDInterstitialAd *)interstitialAd{
    if (self.toastMode) {
        [AppodealToast showToastInView:_presentationView.tableView withMessage:@"interstitialAdDidRecieveTapAction"];
    }
}


#pragma mark --- SKIPPABLE_VIDEO_DELEGATE

- (void)skippableVideoDidLoad:(APDSkippableVideo *)rewardedVideo{
    if (self.toastMode) {
        [AppodealToast showToastInView:_presentationView.tableView withMessage:@"skippableVideoDidLoad"];
    }
    [self apd_updateVideoStatusWithStatus:kAPD_STATUS_LOADED];
}

- (void)skippableVideo:(APDSkippableVideo *)skippableVideo didFailToLoadWithError:(NSError *)error{
    if (self.toastMode) {
        [AppodealToast showToastInView:_presentationView.tableView withMessage:@"skippableVideo didFailToLoadWithError"];
    }
    [self apd_updateVideoStatusWithStatus:kAPD_STATUS_FAIL_TO_LOAD];
    _skippableVideo = nil;
}

- (void)skippableVideoDidBecomeUnavailable:(APDSkippableVideo *)skippableVideo{
    if (self.toastMode) {
        [AppodealToast showToastInView:_presentationView.tableView withMessage:@"skippableVideoDidBecomeUnavailable"];
    }
}

- (void)skippableVideoDidAppear:(APDSkippableVideo *)skippableVideo{
    if (self.toastMode) {
        [AppodealToast showToastInView:_presentationView.tableView withMessage:@"skippableVideoDidAppear"];
    }
}

- (void)skippableVideoDidFinish:(APDSkippableVideo *)skippableVideo{
    if (self.toastMode) {
        [AppodealToast showToastInView:_presentationView.tableView withMessage:@"skippableVideoDidFinish"];
    }
}

- (void)skippableVideoDidDisappear:(APDSkippableVideo *)skippableVideo{
    if (self.toastMode) {
        [AppodealToast showToastInView:_presentationView.tableView withMessage:@"skippableVideoDidDisappear"];
    }
    [self apd_updateVideoStatusWithStatus:kAPD_STATUS_NILL];
    _skippableVideo = nil;
}

- (void)skippableVideo:(APDSkippableVideo *)skippableVideo didFailToPresentWithError:(NSError *)error{
    if (self.toastMode) {
        [AppodealToast showToastInView:_presentationView.tableView withMessage:@"skippableVideo didFailToPresentWithError"];
    }
    [self apd_updateVideoStatusWithStatus:kAPD_STATUS_FAIL_TO_PRESENT];
    _skippableVideo = nil;
}

#pragma mark --- REWARDED_VIDEO_DELEGATE

- (void)rewardedVideoDidLoad:(APDRewardedVideo *)rewardedVideo{
    if (self.toastMode) {
        [AppodealToast showToastInView:_presentationView.tableView withMessage:@"rewardedVideoDidLoad"];
    }
    [self apd_updateRewardedVideoStatusWithStatus:kAPD_STATUS_LOADED];
}

- (void)rewardedVideo:(APDRewardedVideo *)rewardedVideo didFailToLoadWithError:(NSError *)error{
    if (self.toastMode) {
        [AppodealToast showToastInView:_presentationView.tableView withMessage:@"rewardedVideo didFailToLoadWithError"];
    }
    [self apd_updateRewardedVideoStatusWithStatus:kAPD_STATUS_FAIL_TO_LOAD];
    _rewardedVideo = nil;
}

- (void)rewardedVideoDidBecomeUnavailable:(APDRewardedVideo *)rewardedVideo{
    if (self.toastMode) {
        [AppodealToast showToastInView:_presentationView.tableView withMessage:@"rewardedVideoDidBecomeUnavailable"];
    }
}

- (void)rewardedVideoDidAppear:(APDRewardedVideo *)rewardedVideo{
    if (self.toastMode) {
        [AppodealToast showToastInView:_presentationView.tableView withMessage:@"rewardedVideoDidAppear"];
    }
}

- (void)rewardedVideoDidDisappear:(APDRewardedVideo *)rewardedVideo{
    
    if (self.toastMode) {
        [AppodealToast showToastInView:_presentationView.tableView withMessage:@"rewardedVideoDidDisappear"];
    }
    [self apd_updateRewardedVideoStatusWithStatus:kAPD_STATUS_NILL];
    _rewardedVideo = nil;
}

- (void)rewardedVideo:(APDRewardedVideo *)rewardedVideo didFinishWithReward:(id<APDReward>)reward{
    if (self.toastMode) {
        [AppodealToast showToastInView:_presentationView.tableView withMessage:@"rewardedVideo didFinishWithReward"];
    }
}

- (void)rewardedVideo:(APDRewardedVideo *)rewardedVideo didFailToPresentWithError:(NSError *)error{
    if (self.toastMode) {
        [AppodealToast showToastInView:_presentationView.tableView withMessage:@"rewardedVideo didFailToPresentWithError"];
    }
    [self apd_updateRewardedVideoStatusWithStatus:kAPD_STATUS_FAIL_TO_PRESENT];
    _rewardedVideo = nil;
}

@end

