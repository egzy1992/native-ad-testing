//
//  MasterRSSStreamCell.m
//  RamblerDemo
//
//  Created by ilya lozhkin on 19/03/16.
//  Copyright © 2016 dtlbox. All rights reserved.
//

#import "APDRSSStreamCell.h"
#import "Masonry.h"
#import "Haneke.h"

@interface APDRSSStreamCell ()

@end

@implementation APDRSSStreamCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.iconFeed];
        [self.contentView addSubview:self.nameFeed];
        [self.contentView addSubview:self.contentFeed];
        [self.contentView addSubview:self.dateFeed];
        [self.contentView addSubview:self.imageFeed];
        
        self.contentView.layer.cornerRadius = 5.;
        self.contentView.layer.borderColor = [UIColor colorWithRed:101/255.f green:157/255.f blue:220/255.f alpha:1.f].CGColor;
        self.contentView.layer.borderWidth = 1.;
    }
    return self;
}

-(void) contentWithRssModel:(RSSModel *)model {
    self.contentFeed.text = model.summary;
    self.dateFeed.text = [model.date substringWithRange:NSMakeRange(0, [model.date length] - 6)];
    self.nameFeed.text = model.title;
    [self.iconFeed hnk_setImageFromURL:[NSURL URLWithString:model.imageUrl] placeholder:[UIImage imageNamed:@"default-placeholder"]];
    [self.imageFeed hnk_setImageFromURL:[NSURL URLWithString:model.imageUrl] placeholder:[UIImage imageNamed:@"default-placeholder"]];
    
    [self makeFrame];
}

- (void) makeFrame {
    self.nameFeed.frame = CGRectMake(110., 10., CGRectGetWidth(self.contentView.frame) - 120., 40.);
    self.contentFeed.frame = CGRectMake(110., 55., CGRectGetWidth(self.contentView.frame) - 120., 45.);
    self.iconFeed.frame = CGRectMake(10., 10., 90, 90);
    self.imageFeed.frame = CGRectMake(10, 105., CGRectGetWidth(self.contentView.frame)-20, CGRectGetWidth(self.contentView.frame) * 0.4);
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
        _nameFeed.numberOfLines = 2;
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
