//
//  APDCollectionContentViewController.m
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 6/14/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDCollectionContentViewController.h"
#import "APDCollectionContentView.h"
#import "APDContentCollectionCell.h"

@interface APDCollectionContentViewController () <UICollectionViewDataSource, UICollectionViewDelegate, APDNativeAdLoaderDelegate>
{
    APDCollectionContentView * _collectionContentView;
    APDNativeAdLoader * _nativeAdLoader;
    NSMutableArray * _nativeAdArray;
    
    NSMutableDictionary * _cellDict;
}
@end

@implementation APDCollectionContentViewController

- (void) viewDidLoad {
    
    {
        self.navigationItem.title = [NSLocalizedString(@"Content Collection", nil) uppercaseString];
    }
    
    [super viewDidLoad];
    
    {
        _collectionContentView = [[APDCollectionContentView alloc] initWithFrame:self.view.frame];
        self.view = _collectionContentView;
    }
    
    {
        _collectionContentView.collectionView.delegate = self;
        _collectionContentView.collectionView.dataSource = self;
        [_collectionContentView.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([self class])];
        [_collectionContentView.collectionView registerClass:[APDContentCollectionCell class] forCellWithReuseIdentifier:[NSStringFromClass([self class]) stringByAppendingString:@"native"]];
    }
    
    {
        _cellDict = [self cellDict];
    }
    
    {
        _nativeAdLoader = [APDNativeAdLoader new];
        _nativeAdLoader.delegate = self;
        [_nativeAdLoader loadAdWithType:self.nativeType];
    }
}

#pragma mark --- CELL_NAME

- (NSMutableDictionary *) cellDict {
    if (!_cellDict) {
        NSDictionary * cellName = @{[self i_Ps:0 index:0] : NSLocalizedString(@"0 - 0", nil),
                                    [self i_Ps:0 index:1] : NSLocalizedString(@"0 - 1", nil),
                                    [self i_Ps:0 index:2] : NSLocalizedString(@"0 - 2", nil),
                                    [self i_Ps:1 index:0] : NSLocalizedString(@"Native",nil),
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
    return UIEdgeInsetsMake(2.,2.,2.,2.);
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellName = NSStringFromClass([self class]);
    
    id cell = nil;
    if (indexPath.section == 1) {
        cellName = [cellName stringByAppendingString:@"native"];
    }
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellName forIndexPath:indexPath];

    switch (indexPath.section) {
        case 0:
        {
            [(UITableViewCell *)cell setBackgroundColor:UIColor.greenColor];
            switch (indexPath.item) {
                case 0:
//                    [[(UITableViewCell *)cell layer] insertSublayer:[self gradientWithFrame:[(UITableViewCell *)cell bounds]] atIndex:0];
                    break;
                case 1:
//                    [[(UITableViewCell *)cell layer] insertSublayer:[self gradientWithFrame:[(UITableViewCell *)cell bounds]] atIndex:0];
                    break;
                case 2:
//                    [[(UITableViewCell *)cell layer] insertSublayer:[self gradientWithFrame:[(UITableViewCell *)cell bounds]] atIndex:0];
                    break;
            }
        } break;
            
        case 1: // NATIVE_CELL
        {
            if ([_nativeAdArray count]) {
                [(APDContentCollectionCell *)cell setNativeAd: [_nativeAdArray firstObject] fromViewController:self];
                break;
            }
//            [[(UITableViewCell *)cell layer] insertSublayer:[self gradientWithFrame:[(UITableViewCell *)cell bounds]] atIndex:0];
        } break;
            
        case 2:
        {
            [(UITableViewCell *)cell setBackgroundColor:UIColor.lightGrayColor];
            switch (indexPath.item) {
                case 0:
//                    [[(UITableViewCell *)cell layer] insertSublayer:[self gradientWithFrame:[(UITableViewCell *)cell bounds]] atIndex:0];
                    break;
                case 1:
//                    [[(UITableViewCell *)cell layer] insertSublayer:[self gradientWithFrame:[(UITableViewCell *)cell bounds]] atIndex:0];
                    break;
            }
        } break;
    }
    
    return cell;
}

- (CGRect) frameWithItemCount:(NSUInteger)itemCount andIndexPath:(NSIndexPath *)indexPath{
    CGFloat extension = 1.;
    CGFloat cellheight = indexPath.section != 1 ? 130. : 70; // 70  - native height
    
    CGFloat cellPaddingY = 7.f;
    CGFloat cellPaddingX = 5.f;
    CGFloat totalPaddingX = cellPaddingX * ((itemCount-1)+2);
    
    CGFloat _screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat width = (_screenWidth / (CGFloat)itemCount);
    CGFloat widthAndPadding = width - (totalPaddingX/itemCount);
    
    CGFloat height = cellheight * extension - cellPaddingY;
    CGFloat offsetX = (width)*(indexPath.row) + cellPaddingX ;
    CGFloat offsetY = cellheight * indexPath.section * extension + cellPaddingY;
    
    return  CGRectMake(offsetX,  offsetY, widthAndPadding, height);
}

#pragma mark --- NATIVE_AD_LOADER_DELEGATE

- (void)nativeAdLoader:(APDNativeAdLoader *)loader didLoadNativeAd:(APDNativeAd *)nativeAd{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.view withMessage:@"nativeAdLoader didLoadNativeAd"];
    }
    
    _nativeAdArray = [NSMutableArray array];
    [_nativeAdArray addObject:nativeAd];
    
    [_collectionContentView.collectionView reloadData];
}

- (void)nativeAdLoader:(APDNativeAdLoader *)loader didFailToLoadWithError:(NSError *)error{
    if (self.toastMode) {
        [AppodealToast showToastInView:self.view withMessage:@"nativeAdLoader didFailToLoadWithError"];
    }
}


@end
