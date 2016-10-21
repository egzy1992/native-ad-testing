//
//  APDHelperCollectionViewController.m
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 8/8/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDHelperCollectionViewController.h"
#import "APDHelperCollectionView.h"
#import "APDNativeView.h"
#import "APDRSSCollectionStreamCell.h"

#import "APDNativeAdRenderView.h"
#import "APDCollectionViewPlacer.h"

#import "RSSStream.h"
#import "RSSModel.h"

@interface APDHelperCollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout ,APDCollectionViewPlacerDataSource>
{
    APDHelperCollectionView * _apdHelperView;
    NSString * _cellIdentifier;
}

@property (nonatomic, strong) APDCollectionViewPlacer * adPlacer;

@end

@implementation APDHelperCollectionViewController

- (void)viewDidLoad {
    {
        self.navigationItem.title = self.navigationItem.title = [NSLocalizedString(@"collection with helper", nil) uppercaseString];
    }
    [super viewDidLoad];
    
    {
        _apdHelperView = [[APDHelperCollectionView alloc] initWithFrame:self.view.frame];
        self.view = _apdHelperView;
    }
    
    {
        _apdHelperView.collectionView.delegate = self;
        _apdHelperView.collectionView.dataSource = self;
        _cellIdentifier = NSStringFromClass([self class]);
        [_apdHelperView.collectionView registerClass:[APDRSSCollectionStreamCell class] forCellWithReuseIdentifier:_cellIdentifier];
    }
    
    [self appodealHelperConfig];
}

- (void) appodealHelperConfig {
    self.adPlacer = [[APDCollectionViewPlacer alloc] initWithCollectionView:_apdHelperView.collectionView
                                                             viewController:self
                                                                 dataSource:self];
    self.adPlacer.ignoreNetworkPlacerSettings = YES;
    [self.adPlacer setDefaultPostions:@[[NSIndexPath indexPathForRow:2 inSection:0]]
         withDefaultRepeatingInterval:4
                            forAdType:self.adType];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self.adPlacer fillCollectionView];
}

#pragma mark --- APDCollectionViewPlacer

- (UIView<APDNativeAdRenderView> *)viewForPlacer:(APDCollectionViewPlacer *)placer {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat heigth = width * 9 / 16 + 70;
    APDNativeView * nativeView = [[APDNativeView alloc] initWithFrame:CGRectMake(0, 0, width, heigth)];
    [nativeView makeConstrain];
    return nativeView;
}

#pragma mark --- UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    APDRSSCollectionStreamCell *cell = nil;
    RSSModel * model = _contentArray[indexPath.row % ([_contentArray count] - 1)];
    
    cell = [collectionView apd_dequeueReusableCellWithReuseIdentifier:_cellIdentifier forIndexPath:indexPath];
    
    [cell contentWithRssModel:model];
    cell.contentView.backgroundColor = UIColor.whiteColor;
    cell.layer.borderWidth = .9;
    cell.layer.borderColor = UIColor.lightGrayColor.CGColor;
    
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 3.f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return [[UIDevice currentDevice] userInterfaceIdiom]== UIUserInterfaceIdiomPhone ? 1.f : 3.f;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(CGRectGetWidth(self.view.frame), 300);
}

@end
