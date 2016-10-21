//
//  RSSModel.h
//  RamblerDemo
//
//  Created by ilya lozhkin on 18/03/16.
//  Copyright © 2016 dtlbox. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSSModel : NSObject

//item.title (NSString)
//item.link (NSString)
//item.author (NSString)
//item.date (NSDate)
//item.updated (NSDate)
//item.summary (NSString)
//item.content (NSString)
//item.enclosures (NSArray of NSDictionary with keys url, type and length)
//item.identifier (NSString)

@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * link;
@property (nonatomic, strong) NSString * author;
@property (nonatomic, strong) NSString * date;
@property (nonatomic, strong) NSString * updated;
@property (nonatomic, strong) NSString * summary;
@property (nonatomic, strong) NSString * content;
@property (nonatomic, strong) id enclosures;
@property (nonatomic, strong) NSString * identifier;
@property (nonatomic, strong) NSString * imageUrl;

-(instancetype) initWithItem:(MWFeedItem *)item;

@end
