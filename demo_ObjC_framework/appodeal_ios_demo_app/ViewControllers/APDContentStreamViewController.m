//
//  APDContentStreamViewController.m
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 6/14/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDContentStreamViewController.h"
#import "APDContentStreamCell.h"
#import "APDContentStreamView.h"

@interface APDContentStreamViewController () <UITableViewDelegate, UITableViewDataSource, APDNativeAdLoaderDelegate>
{
    APDContentStreamView * _contentStreamView;
    APDNativeAdLoader * _nativeAdLoader;
    NSMutableArray * _nativeAdArray;
}
@end

@implementation APDContentStreamViewController

- (void) viewDidLoad {
    
    {
        self.navigationItem.title = [NSLocalizedString(@"Content Stream", nil) uppercaseString];
    }
    
    [super viewDidLoad];
    
    {
        _contentStreamView = [[APDContentStreamView alloc] initWithFrame:self.view.frame];
        self.view = _contentStreamView;
    }
    
    {
        _contentStreamView.tableView.delegate = self;
        _contentStreamView.tableView.dataSource = self;
    }
    
    {
        _nativeAdLoader = [APDNativeAdLoader new];
        _nativeAdLoader.delegate = self;
        [_nativeAdLoader loadAdWithType:self.nativeType];
    }
}

#pragma mark --- TABLE_VIEW_DELEGATE

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellName = NSStringFromClass([self class]);
    
    id cell = nil;
    if (indexPath.row == 3 && [_nativeAdArray count]) { // NATIVE_CELL ---> (cell == 3) can different
        cellName = [cellName stringByAppendingString:@"native"];
    }
    cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    
    if (!cell && [cellName isEqualToString:[NSStringFromClass([self class]) stringByAppendingString:@"native"]]) {
        cell = [[APDContentStreamCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        [(APDContentStreamCell *)cell setNativeAd:[_nativeAdArray firstObject] fromViewController:self];
    } else if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellName];
//        [[(UITableViewCell *)cell layer] insertSublayer:
//         [self gradientWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.parentViewController.view.frame), CGRectGetHeight([(UITableViewCell *)cell contentView].bounds))]
//                                                atIndex:0];
        
    }
    return cell;
}

#pragma mark --- NATIVE_AD_LOADER_DELEGATE

- (void)nativeAdLoader:(APDNativeAdLoader *)loader didLoadNativeAd:(APDNativeAd *)nativeAd{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.view withMessage:@"nativeAdLoader didLoadNativeAd"];
    }
    
    _nativeAdArray = [NSMutableArray array];
    [_nativeAdArray addObject:nativeAd];
    
    [_contentStreamView.tableView reloadData];
}

- (void)nativeAdLoader:(APDNativeAdLoader *)loader didFailToLoadWithError:(NSError *)error{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.view withMessage:@"nativeAdLoader didFailToLoadWithError"];
    }
}

@end
