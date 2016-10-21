//
//  APDBannerViewInTableViewController.m
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 6/13/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDBannerViewInTableViewController.h"
#import "APDBannerViewInTableView.h"
#import <Appodeal/Appodeal.h>

@interface APDBannerViewInTableViewController () <UITableViewDelegate, UITableViewDataSource, APDBannerViewDelegate>
{
    APDBannerViewInTableView * _tableBannerView;
    
    NSMutableDictionary * _cellDictName;
    
    APDBannerView * _headerBannerView;
    APDBannerView * _footerBannerView;
    APDBannerView * _cellBannerView;
}
@end

@implementation APDBannerViewInTableViewController

- (void) viewDidLoad {
    
    {
        self.navigationItem.title = [NSLocalizedString(@"banner view in table", nil) uppercaseString];
    }
    
    [super viewDidLoad];
    
    {
        _tableBannerView = [[APDBannerViewInTableView alloc] initWithFrame:self.view.frame];
        self.view = _tableBannerView;
    }
    
    {
        _tableBannerView.tableView.delegate = self;
        _tableBannerView.tableView.dataSource = self;
    }
    
    {
        _cellDictName = [self cellDictName];
    }
}

- (NSMutableDictionary *) cellDictName {
    if (!_cellDictName) {
        NSDictionary * cellName = @{[self i_Ps:0 index:0] : NSLocalizedString(@"Banner View in table header", nil),
                                    [self i_Ps:0 index:1] : NSLocalizedString(@"Banner View in table cell", nil),
                                    [self i_Ps:0 index:2] : NSLocalizedString(@"Banner View in table footer", nil)};
        
        _cellDictName = [[NSMutableDictionary alloc] initWithDictionary:cellName];
    }
    return _cellDictName;
}

- (NSIndexPath *) i_Ps:(NSUInteger)section index:(NSInteger)index{
    return [NSIndexPath indexPathForRow:index inSection:section];
}

#pragma mark --- TABLE_VIEW_DELEGATE

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? 3 : 0;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (!_headerBannerView) {
        return 0.f;
    }
    return IS_IPAD ? 90.0f : 50.f;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (!_footerBannerView) {
        return 0.f;
    }
    return IS_IPAD ? 90.0f : 50.f;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1 && !_cellBannerView) {
        return tableView.estimatedRowHeight;
    } else if (indexPath.row == 1) {
        return IS_IPAD ? 90.0f : 50.f;
    }
    return tableView.estimatedRowHeight;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (!_headerBannerView) {
        return nil;
    }
    
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.parentViewController.view.frame), IS_IPAD ? 90.0f : 50.f)];
    [headerView addSubview:_headerBannerView];
    [_headerBannerView setFrame:headerView.bounds];
    
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (!_footerBannerView) {
        return nil;
    }
    
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.parentViewController.view.frame), IS_IPAD ? 90.0f : 50.f)];
    [headerView addSubview:_footerBannerView];
    [_footerBannerView setFrame:headerView.bounds];
    
    return headerView;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellName = NSStringFromClass([self class]);
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (_cellDictName[indexPath]) {
        NSDictionary *attributes = @{NSForegroundColorAttributeName: UIColor.blackColor,
                                     NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:16],
                                     NSKernAttributeName: @(1.2)};
        cell.textLabel.attributedText = [[NSAttributedString alloc] initWithString:_cellDictName[indexPath] attributes:attributes];
    }
    
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 1:
                {
                    if (_cellBannerView) {
                        [cell.contentView addSubview:_cellBannerView];
                        [_cellBannerView setFrame:cell.contentView.bounds];
                    }
                } break;
            }
        } break;
    }
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0: // BANNER HEADER
                {
                    if (!_headerBannerView) {
                        _headerBannerView = [[APDBannerView alloc] initWithSize:IS_IPAD?kAPDAdSize728x90:kAPDAdSize320x50];
                        _headerBannerView.rootViewController = self;
                        _headerBannerView.delegate = self;
                    }
                    
                    if (![_headerBannerView isReady]) {
                        [_headerBannerView loadAd];
                    }
                } break;
                case 1: // BANNER CELL
                {
                    if (!_cellBannerView) {
                        _cellBannerView = [[APDBannerView alloc] initWithSize:IS_IPAD?kAPDAdSize728x90:kAPDAdSize320x50];
                        _cellBannerView.rootViewController = self;
                        _cellBannerView.delegate = self;
                    }
                    
                    if (![_cellBannerView isReady]) {
                        [_cellBannerView loadAd];
                    }

                } break;
                case 2: // BANNER FOOTER
                {
                    if (!_footerBannerView) {
                        _footerBannerView = [[APDBannerView alloc] initWithSize:IS_IPAD?kAPDAdSize728x90:kAPDAdSize320x50];
                        _footerBannerView.rootViewController = self;
                        _footerBannerView.delegate = self;
                    }
                    
                    if (![_footerBannerView isReady]) {
                        [_footerBannerView loadAd];
                    }
                } break;
            }
        } break;
    }
}

#pragma mark --- APPODEAL_BANNER_VEIW_DELEGATE

- (void)bannerViewDidLoadAd:(APDBannerView *)bannerView{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.view withMessage:@"bannerViewDidLoadAd"];
    }
    [_tableBannerView.tableView reloadData];
}

- (void)precacheBannerViewDidLoadAd:(APDBannerView *)precacheBannerView{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.view withMessage:@"precacheBannerViewDidLoadAd"];
    }
}

- (void)bannerViewDidRefresh:(APDBannerView *)bannerView{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.view withMessage:@"bannerViewDidRefresh"];
    }
}

- (void)bannerView:(APDBannerView *)bannerView didFailToLoadAdWithError:(NSError *)error{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.view withMessage:@"bannerView didFailToLoadAdWithError"];
    }
    bannerView = nil;
}

- (void)bannerViewDidReceiveTapAction:(APDBannerView *)bannerView{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.view withMessage:@"bannerViewDidReceiveTapAction"];
    }
}

@end
