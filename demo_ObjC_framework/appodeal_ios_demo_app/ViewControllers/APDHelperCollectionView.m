//
//  APDHelperCollectionView.m
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 8/8/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDHelperCollectionView.h"

@implementation APDHelperCollectionView

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.collectionView];
    }
    return self;
}

#pragma mark --- CONSTRAIN

- (void) updateConstraints {
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [super updateConstraints];
}

#pragma mark --- PROPERTY

- (UICollectionView *) collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout * layOut = [[UICollectionViewFlowLayout alloc] init];
        layOut.minimumLineSpacing = 5.0;
        layOut.minimumInteritemSpacing = 7.0;
        layOut.estimatedItemSize = CGSizeMake(100, 100);
        layOut.itemSize = CGSizeMake(UITableViewAutomaticDimension, UITableViewAutomaticDimension);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:layOut];
        _collectionView.backgroundColor = UIColor.whiteColor;
    }
    return _collectionView;
}

@end
