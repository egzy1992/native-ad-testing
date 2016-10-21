//
//  APDHelperTableViewController.m
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 8/8/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDHelperTableViewController.h"
#import "APDHelperTableView.h"
#import "APDNativeView.h"
#import "APDRSSStreamCell.h"

#import "APDNativeAdRenderView.h"
#import "APDTableViewAdPlacer.h"

#import "RSSStream.h"
#import "RSSModel.h"

@interface APDHelperTableViewController () <UITableViewDelegate, UITableViewDataSource, APDTableViewAdPlacerDataSource>
{
    APDHelperTableView * _apdHelperView;
    APDNativeView * _nativeView;
}

@property (nonatomic, strong) APDTableViewAdPlacer * adPlacer;

@end

@implementation APDHelperTableViewController

- (void)viewDidLoad {
    {
        self.navigationItem.title = self.navigationItem.title = [NSLocalizedString(@"table with helper", nil) uppercaseString];
    }
    
    [super viewDidLoad];
    
    {
        _apdHelperView = [[APDHelperTableView alloc] initWithFrame:self.view.frame];
        self.view = _apdHelperView;
    }
    
    {
        _apdHelperView.tableView.delegate = self;
        _apdHelperView.tableView.dataSource = self;
        [_apdHelperView.tableView registerClass:[APDRSSStreamCell class] forCellReuseIdentifier:NSStringFromClass([APDRSSStreamCell class])];
    }

    [self appodealHelperConfig];
}

- (void) appodealHelperConfig {
    self.adPlacer = [[APDTableViewAdPlacer alloc] initWithTableView:_apdHelperView.tableView
                                                     viewController:self
                                                         dataSource:self];
    self.adPlacer.ignoreNetworkPlacerSettings = YES;
    [self.adPlacer setDefaultPostions:@[[NSIndexPath indexPathForRow:0 inSection:5]]
         withDefaultRepeatingInterval:4
                            forAdType:self.adType];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

  //  [UIView setAnimationsEnabled:NO];
    [self.adPlacer fillTable];
}

#pragma mark --- APDTableViewAdPlacerDataSource

- (UIView<APDNativeAdRenderView> *)viewForPlacer:(APDTableViewAdPlacer *)placer {
    if (!_nativeView) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat heigth = width * 9 / 16 + 70;
        APDNativeView * nativeView = [[APDNativeView alloc] initWithFrame:CGRectMake(0, 0, width, heigth)];
        _nativeView = nativeView;
    }
    CGFloat width = CGRectGetWidth(self.view.frame);
    CGFloat heigth = width * 9 / 16 + 70;
    [_nativeView setFrame:CGRectMake(0, 0, width, heigth)];
    [_nativeView makeConstrain];
    
    return _nativeView;
}

#pragma mark --- UITableViewDelegate && UITableViewDataSource

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = CGRectGetWidth(self.view.frame) * 0.4 + 110;
    return height;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 100;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RSSModel * model = _contentArray[indexPath.section % ([_contentArray count] - 1)];
    
    NSString * cellName = NSStringFromClass([APDRSSStreamCell class]);
    APDRSSStreamCell * cell = [tableView apd_dequeueReusableCellWithIdentifier:cellName forIndexPath:indexPath];
    
    [cell contentWithRssModel:model];
    
    return cell;
}

@end
