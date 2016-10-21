//
//  APDRSSCollectionStreamCell.h
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 8/9/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSSModel.h"

@interface APDRSSCollectionStreamCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView * iconFeed;
@property (nonatomic, strong) UILabel * nameFeed;
@property (nonatomic, strong) UILabel * contentFeed;
@property (nonatomic, strong) UILabel * dateFeed;
@property (nonatomic, strong) UIImageView * imageFeed;

- (void) contentWithRssModel:(RSSModel *)model;

@end
