//
//  MasterRSSStreamCell.h
//  RamblerDemo
//
//  Created by ilya lozhkin on 19/03/16.
//  Copyright © 2016 dtlbox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSSModel.h"

@interface APDRSSStreamCell : UITableViewCell

@property (nonatomic, strong) UIImageView * iconFeed;
@property (nonatomic, strong) UILabel * nameFeed;
@property (nonatomic, strong) UILabel * contentFeed;
@property (nonatomic, strong) UILabel * dateFeed;
@property (nonatomic, strong) UIImageView * imageFeed;

- (void) contentWithRssModel:(RSSModel *)model;

@end
