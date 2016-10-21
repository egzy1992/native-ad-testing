//
//  APDAdTypePresentationViewController.m
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 6/10/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDAdTypePresentationViewController.h"
#import "APDAdTypePresentationView.h"
#import "APDBannerPresentationViewController.h"
#import "APDBannerViewShowStyleViewController.h"
#import "APDMRECBannerViewController.h"
#import "APDNativeShowStyleViewController.h"
#import "APDBackgroundWorkPresentationViewController.h"
#import "APDViewabillityPresentationViewController.h"

#import "APDSVC.h"

#import <Appodeal/Appodeal.h>

@interface APDAdTypePresentationViewController () <UITableViewDelegate, UITableViewDataSource, AppodealInterstitialDelegate, AppodealRewardedVideoDelegate, AppodealSkippableVideoDelegate>
{
    APDAdTypePresentationView * _presentationView;
    NSMutableDictionary * _cellDictName;
    NSMutableDictionary * _cellHeaderName;
    NSMutableDictionary * _cellStatusName;
}
@end

@implementation APDAdTypePresentationViewController

- (void) viewDidLoad {
    {
        self.navigationItem.title = [NSLocalizedString(@"Presentation AD", nil) uppercaseString];
    }
    
    [super viewDidLoad];
    
    {
        _presentationView = [[APDAdTypePresentationView alloc] initWithFrame:self.view.frame];
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
    
    {
        [Appodeal setInterstitialDelegate:self];
        [Appodeal setSkippableVideoDelegate:self];
        [Appodeal setRewardedVideoDelegate:self];
    }
}

#pragma mark --- CELL_NAME

- (NSMutableDictionary *) cellDictName {
    if (!_cellDictName) {
        NSDictionary * cellName = @{[self i_Ps:0 index:0] : NSLocalizedString(@"Interstitial", nil),
                                    [self i_Ps:0 index:1] : NSLocalizedString(@"Skippable Video", nil),
                                    [self i_Ps:0 index:2] : NSLocalizedString(@"Video or Interstitial", nil),
                                    [self i_Ps:0 index:3] : NSLocalizedString(@"Rewarded Video", nil),
                                    [self i_Ps:1 index:0] : NSLocalizedString(@"Banner",nil),
                                    [self i_Ps:1 index:1] : NSLocalizedString(@"MREC",nil),
                                    [self i_Ps:1 index:2] : NSLocalizedString(@"Banner View",nil),
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
        NSString * statusString = self.isAutoCache ? @"load" : @"";
        NSDictionary * cellName = @{[self i_Ps:0 index:0] : NSLocalizedString(statusString, nil),
                                    [self i_Ps:0 index:1] : NSLocalizedString(statusString, nil),
                                    [self i_Ps:0 index:2] : NSLocalizedString(@"", nil),
                                    [self i_Ps:0 index:3] : NSLocalizedString(statusString, nil)};
        
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

-(void)apd_updateInterstitialOrVideoStatusWithStatus:(APD_STATUS)status{
    NSIndexPath * indexPath = [self i_Ps:0 index:2];
    NSString * statusString = @"";
    
    switch (status) {
        case kAPD_STATUS_LOAD:
        {
            statusString = NSLocalizedString(@"start load", nil);
        } break;
        case kAPD_STATUS_FAIL_TO_LOAD:
        {
            statusString = NSLocalizedString(@"did fail to load", nil);
        } break;
        case kAPD_STATUS_FAIL_TO_PRESENT:
        {
            statusString = NSLocalizedString(@"did fail to present", nil);
        } break;
        case kAPD_STATUS_LOADED:
        {
            statusString = NSLocalizedString(@"loaded", nil);
        } break;
        case kAPD_STATUS_PRESENTED:
        {
            statusString = NSLocalizedString(@"presented", nil);
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
    NSIndexPath * indexPath = [self i_Ps:0 index:3];
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
    return section == 0 ? 4 : section == 1 ? 3 : 1;
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
                    [Appodeal showAd:AppodealShowStyleInterstitial rootViewController:self];
                } break;
                case 1: // SKIPPABLE
                {
                   [Appodeal showAd:AppodealShowStyleSkippableVideo rootViewController:self];
                } break;
                case 2: // VIDEO OR INTERSTITIAL
                {
                    [Appodeal showAd:AppodealShowStyleVideoOrInterstitial rootViewController:self];
                } break;
                case 3: // REWARDED VIDEO
                {
                    [Appodeal showAd:AppodealShowStyleRewardedVideo rootViewController:self];
                } break;
            }
        } break;
        case 1: // BANNER
        {
            switch (indexPath.row) {
                case 0: // BANNER
                {
                    APDBannerPresentationViewController * nextController = [APDBannerPresentationViewController new];
                    nextController.toastMode = self.toastMode;
                    [self.navigationController pushViewController:nextController animated:YES];
                } break;
                case 1: // MREC
                {
                    APDMRECBannerViewController * nextController = [APDMRECBannerViewController new];
                    nextController.toastMode = self.toastMode;
                    [self.navigationController pushViewController:nextController animated:YES];
                } break;
                case 2: // BANNER_VIEW
                {
                    APDBannerViewShowStyleViewController * nextController = [APDBannerViewShowStyleViewController new];
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
            APDViewabillityPresentationViewController * nextController = [APDViewabillityPresentationViewController new];
            nextController.toastMode = self.toastMode;
            [self.navigationController pushViewController:nextController animated:YES];
        } break;
    }
}

#pragma mark --- APPODEAL_INTERSTITIAL_DELEGATE

- (void)interstitialDidLoadAdisPrecache:(BOOL)precache{
    if (self.toastMode) {
        [AppodealToast showToastInView:_presentationView.tableView withMessage:@"interstitialDidLoadAdisPrecache"];
    }
    [self apd_updateInterstitialStatusWithStatus:kAPD_STATUS_LOADED];
}
- (void)interstitialDidFailToLoadAd{
    if (self.toastMode) {
        [AppodealToast showToastInView:_presentationView.tableView withMessage:@"interstitialDidFailToLoadAd"];
    }
    [self apd_updateInterstitialStatusWithStatus:kAPD_STATUS_FAIL_TO_LOAD];
}
- (void)interstitialWillPresent{
    if (self.toastMode) {
        [AppodealToast showToastInView:_presentationView.tableView withMessage:@"interstitialWillPresent"];
    }
    [self apd_updateInterstitialStatusWithStatus:kAPD_STATUS_PRESENTED];
}
- (void)interstitialDidDismiss{
    if (self.toastMode) {
        [AppodealToast showToastInView:_presentationView.tableView withMessage:@"interstitialDidDismiss"];
    }
    [self apd_updateInterstitialStatusWithStatus:kAPD_STATUS_NILL];
}
- (void)interstitialDidClick{
    if (self.toastMode) {
        [AppodealToast showToastInView:_presentationView.tableView withMessage:@"interstitialDidClick"];
    }
}

#pragma mark --- APPODEAL_SKIPPABLE_VIDEO_DELEGATE

- (void)skippableVideoDidLoadAd{
    if (self.toastMode) {
        [AppodealToast showToastInView:_presentationView.tableView withMessage:@"skippableVideoDidLoadAd"];
    }
    [self apd_updateVideoStatusWithStatus:kAPD_STATUS_LOADED];
}
- (void)skippableVideoDidFailToLoadAd{
    if (self.toastMode) {
        [AppodealToast showToastInView:_presentationView.tableView withMessage:@"skippableVideoDidFailToLoadAd"];
    }
    [self apd_updateVideoStatusWithStatus:kAPD_STATUS_FAIL_TO_LOAD];
}
- (void)skippableVideoDidPresent{
    if (self.toastMode) {
        [AppodealToast showToastInView:_presentationView.tableView withMessage:@"skippableVideoDidPresent"];
    }
    [self apd_updateVideoStatusWithStatus:kAPD_STATUS_PRESENTED];
}
- (void)skippableVideoWillDismiss{
    if (self.toastMode) {
        [AppodealToast showToastInView:_presentationView.tableView withMessage:@"skippableVideoWillDismiss"];
    }
    [self apd_updateVideoStatusWithStatus:kAPD_STATUS_NILL];
}
- (void)skippableVideoDidFinish{
    if (self.toastMode) {
        [AppodealToast showToastInView:_presentationView.tableView withMessage:@"skippableVideoDidFinish"];
    }
}
- (void)skippableVideoDidClick{
    if (self.toastMode) {
        [AppodealToast showToastInView:_presentationView.tableView withMessage:@"skippableVideoDidClick"];
    }
}

#pragma mark --- APPODEAL_REWARDED_VIDEO_DELEGATE

- (void)rewardedVideoDidLoadAd{
    if (self.toastMode) {
        [AppodealToast showToastInView:_presentationView.tableView withMessage:@"rewardedVideoDidLoadAd"];
    }
    [self apd_updateRewardedVideoStatusWithStatus:kAPD_STATUS_LOADED];
}
- (void)rewardedVideoDidFailToLoadAd{
    if (self.toastMode) {
        [AppodealToast showToastInView:_presentationView.tableView withMessage:@"rewardedVideoDidFailToLoadAd"];
    }
    [self apd_updateRewardedVideoStatusWithStatus:kAPD_STATUS_FAIL_TO_LOAD];
}
- (void)rewardedVideoDidPresent{
    if (self.toastMode) {
        [AppodealToast showToastInView:_presentationView.tableView withMessage:@"rewardedVideoDidPresent"];
    }
    [self apd_updateRewardedVideoStatusWithStatus:kAPD_STATUS_PRESENTED];
}
- (void)rewardedVideoWillDismiss{
    if (self.toastMode) {
        [AppodealToast showToastInView:_presentationView.tableView withMessage:@"rewardedVideoWillDismiss"];
    }
    [self apd_updateRewardedVideoStatusWithStatus:kAPD_STATUS_NILL];
}
- (void)rewardedVideoDidFinish:(NSUInteger)rewardAmount name:(NSString *)rewardName{
    if (self.toastMode) {
        [AppodealToast showToastInView:_presentationView.tableView withMessage:@"rewardedVideoDidFinish"];
    }
}
- (void)rewardedVideoDidClick{
    if (self.toastMode) {
        [AppodealToast showToastInView:_presentationView.tableView withMessage:@"rewardedVideoDidClick"];
    }
}

@end
