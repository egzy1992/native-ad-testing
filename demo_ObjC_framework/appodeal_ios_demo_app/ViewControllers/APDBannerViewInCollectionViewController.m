//
//  APDBannerViewInCollectionViewController.m
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 6/13/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDBannerViewInCollectionViewController.h"
#import "APDBannerViewInCollectionView.h"
#import <Appodeal/Appodeal.h>

@interface APDBannerViewInCollectionViewController () <APDBannerViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource>
{
    APDBannerViewInCollectionView * _collectionBannerView;
    
    NSMutableDictionary * _cellDict;
    
    APDBannerView * _bannerView;
}
@end

@implementation APDBannerViewInCollectionViewController

- (void) viewDidLoad {
    
    {
        self.navigationItem.title = [NSLocalizedString(@"banner view in collection", nil) uppercaseString];
    }
    
    [super viewDidLoad];
    
    {
        _collectionBannerView = [[APDBannerViewInCollectionView alloc] initWithFrame:self.view.frame];
        self.view = _collectionBannerView;
    }
    
    {
        _collectionBannerView.collectionView.delegate = self;
        _collectionBannerView.collectionView.dataSource = self;
        [_collectionBannerView.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([self class])];
    }
    
    {
        _cellDict = [self cellDict];
    }
    
    {
        _bannerView = [[APDBannerView alloc] initWithSize:IS_IPAD?kAPDAdSize728x90:kAPDAdSize320x50];
        _bannerView.delegate = self;
        _bannerView.rootViewController = self;
        [_bannerView loadAd];
    }
}

#pragma mark --- CELL_NAME

- (NSMutableDictionary *) cellDict {
    if (!_cellDict) {
        NSDictionary * cellName = @{[self i_Ps:0 index:0] : NSLocalizedString(@"0 - 0", nil),
                                    [self i_Ps:0 index:1] : NSLocalizedString(@"0 - 1", nil),
                                    [self i_Ps:0 index:2] : NSLocalizedString(@"0 - 2", nil),
                                    [self i_Ps:1 index:0] : NSLocalizedString(@"Banner",nil),
                                    [self i_Ps:2 index:0] : NSLocalizedString(@"2 - 0", nil),
                                    [self i_Ps:2 index:0] : NSLocalizedString(@"2 - 1", nil)};
        
        _cellDict = [[NSMutableDictionary alloc] initWithDictionary:cellName];
    }
    return _cellDict;
}

- (NSIndexPath *) i_Ps:(NSUInteger)section index:(NSInteger)index{
    return [NSIndexPath indexPathForRow:index inSection:section];
}

#pragma mark --- COLLECTION_VIEW_DELEGATE

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return section == 0 ? 3 : section == 1 ? 1 : 2;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger itemCount = indexPath.section == 0 ? 3 : indexPath.section == 1 ? 1 : 2;
    CGSize size = [self frameWithItemCount:itemCount andIndexPath:indexPath].size;
    
    return size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(1.,2.,1.,2.);
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellName = NSStringFromClass([self class]);
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellName forIndexPath:indexPath];
    
    switch (indexPath.section) {
        case 0:
        {
            cell.backgroundColor = UIColor.grayColor;
        } break;
            
        case 1:
        {
            cell.backgroundColor = UIColor.grayColor;
            
            if (_bannerView) {
                [cell.contentView addSubview:_bannerView];
                _bannerView.frame = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
            }
        } break;
            
        case 2:
        {
            cell.backgroundColor = UIColor.grayColor;
        } break;
    }
    
    return cell;
}

- (CGRect) frameWithItemCount:(NSUInteger)itemCount andIndexPath:(NSIndexPath *)indexPath{
    CGFloat extension = 1.;
    CGFloat cellheight = indexPath.section != 1 ? 130. : IS_IPAD ? 110 : 70; // 70  - native height
    
    CGFloat cellPaddingY = 7.f;
    CGFloat cellPaddingX = 7.f;
    CGFloat totalPaddingX = cellPaddingX * ((itemCount-1)+2);
    
    CGFloat _screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat width = (_screenWidth / (CGFloat)itemCount);
    CGFloat widthAndPadding = width - (totalPaddingX/itemCount);
    
    CGFloat height = cellheight * extension - cellPaddingY;
    CGFloat offsetX = (width)*(indexPath.row) + cellPaddingX ;
    CGFloat offsetY = cellheight * indexPath.section * extension + cellPaddingY;
    
    return  CGRectMake(offsetX,  offsetY, widthAndPadding, height);
}

#pragma mark --- APPODEAL_BANNER_VEIW_DELEGATE

- (void)bannerViewDidLoadAd:(APDBannerView *)bannerView{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.view withMessage:@"bannerViewDidLoadAd"];
    }
    [_collectionBannerView.collectionView reloadData];
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
}

- (void)bannerViewDidReceiveTapAction:(APDBannerView *)bannerView{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.view withMessage:@"bannerViewDidReceiveTapAction"];
    }
}

@end
