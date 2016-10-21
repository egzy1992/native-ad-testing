//
//  APDBannerViewInCollectionView.m
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 6/13/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDBannerViewInCollectionView.h"

@implementation APDBannerViewInCollectionView

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if (self) {
        [self addSubview:self.collectionView];
    }
    [self updateConstraints];
    return self;
}

#pragma mark --- CONSTRAIN

- (void)updateConstraints{
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [super updateConstraints];
}

#pragma mark --- PROPERTY

- (UICollectionView *) collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout * layOut = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:layOut];
        _collectionView.backgroundColor = UIColor.whiteColor;
    }
    return _collectionView;
}

@end
