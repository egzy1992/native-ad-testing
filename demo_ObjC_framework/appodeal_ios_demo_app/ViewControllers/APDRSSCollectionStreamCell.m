//
//  APDRSSCollectionStreamCell.m
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 8/9/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDRSSCollectionStreamCell.h"
#import "Masonry.h"
#import "Haneke.h"

@implementation APDRSSCollectionStreamCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.contentView addSubview:self.iconFeed];
        [self.contentView addSubview:self.nameFeed];
        [self.contentView addSubview:self.contentFeed];
        [self.contentView addSubview:self.dateFeed];
        [self.contentView addSubview:self.imageFeed];
        
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.lessThanOrEqualTo(@300);
            make.width.equalTo(@([UIScreen mainScreen].bounds.size.width));
        }];
    }
    return self;
}

-(void) contentWithRssModel:(RSSModel *)model {
    self.contentFeed.text = model.summary;
    self.dateFeed.text = [model.date substringWithRange:NSMakeRange(0, [model.date length] - 6)];
    self.nameFeed.text = model.title;
    [self.iconFeed hnk_setImageFromURL:[NSURL URLWithString:model.imageUrl] placeholder:[UIImage imageNamed:@"default-placeholder"]];
    [self.imageFeed hnk_setImageFromURL:[NSURL URLWithString:model.imageUrl] placeholder:[UIImage imageNamed:@"default-placeholder"]];
}

-(void) updateConstraints {
    
    [self.iconFeed mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(10);
        make.left.equalTo(self.contentView).with.offset(10);
        make.height.equalTo(@30);
        //make.width.equalTo(@);
    }];
    
    [self.nameFeed mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(10);
        make.left.equalTo(self.iconFeed.mas_right).with.offset(10);
        make.right.equalTo(self.contentView).with.offset(-10);
    }];
    
    [self.contentFeed mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameFeed.mas_bottom).with.offset(5);
        make.left.equalTo(self.iconFeed.mas_right).with.offset(10);
        make.right.equalTo(self.contentView).with.offset(-10);
    }];
    
    [self.dateFeed mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentFeed.mas_bottom).with.offset(5);
        make.width.lessThanOrEqualTo(self.contentView).with.offset(-50);
        make.right.equalTo(self.contentView).with.offset(-10);
        //make.bottom.equalTo(self.contentView).with.offset(-10);
    }];
    
    [self.imageFeed mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(0);
        make.right.equalTo(self.contentView).with.offset(0);
        make.height.equalTo(@200);
        make.top.equalTo(self.contentFeed.mas_bottom);
        make.bottom.equalTo(self.contentView).with.offset(-10);
    }];
    
    [super updateConstraints];
    
}

#pragma mark --- PROPERTY

-(UIImageView *) iconFeed {
    if (!_iconFeed) {
        _iconFeed = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 90, 90)];
        _iconFeed.contentMode = UIViewContentModeScaleAspectFill;
        _iconFeed.layer.masksToBounds = YES;
    }
    return _iconFeed;
}

-(UIImageView *) imageFeed {
    if (!_imageFeed) {
        _imageFeed = [[UIImageView alloc] init];
        _imageFeed.contentMode = UIViewContentModeScaleAspectFill;
        _imageFeed.layer.masksToBounds = YES;
    }
    return _imageFeed;
}

-(UILabel *) nameFeed {
    if (!_nameFeed) {
        _nameFeed = [UILabel new];
        _nameFeed.numberOfLines = 3;
        _nameFeed.font = [UIFont systemFontOfSize:18.0f weight:UIFontWeightRegular];
        _nameFeed.textColor = [UIColor colorWithRed:101/255.f green:157/255.f blue:220/255.f alpha:1.f];
        _nameFeed.textAlignment = NSTextAlignmentLeft;
    }
    return _nameFeed;
}

-(UILabel *) contentFeed {
    if (!_contentFeed) {
        _contentFeed = [UILabel new];
        _contentFeed.numberOfLines = 3;
        _contentFeed.font = [UIFont systemFontOfSize:14.0f weight:UIFontWeightLight];
        _contentFeed.textColor = [UIColor colorWithRed:108/255.f green:108/255.f blue:108/255.f alpha:1.f];
        _contentFeed.textAlignment = NSTextAlignmentLeft;;
    }
    return _contentFeed;
}

-(UILabel *) dateFeed {
    if (!_dateFeed) {
        _dateFeed = [UILabel new];
        _dateFeed.font = [UIFont systemFontOfSize:10.0f weight:UIFontWeightLight];
        _dateFeed.textColor = UIColor.grayColor;
        _dateFeed.textAlignment = NSTextAlignmentRight;
    }
    return _dateFeed;
}

@end
