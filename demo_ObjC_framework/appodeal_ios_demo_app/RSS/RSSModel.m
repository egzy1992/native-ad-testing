//
//  RSSModel.m
//  RamblerDemo
//
//  Created by ilya lozhkin on 18/03/16.
//  Copyright © 2016 dtlbox. All rights reserved.
//

#import "RSSModel.h"

@implementation RSSModel

//item.title (NSString)
//item.link (NSString)
//item.author (NSString)
//item.date (NSDate)
//item.updated (NSDate)
//item.summary (NSString)
//item.content (NSString)
//item.enclosures (NSArray of NSDictionary with keys url, type and length)
//item.identifier (NSString)

-(instancetype) initWithItem:(MWFeedItem *)item{
    self = [super init];
    if (self) {
        self.title = NIL_TO_STRING(item.title)
        self.link = NIL_TO_STRING(item.link)
        self.author = NIL_TO_STRING(item.author)
        self.date = [NSString stringWithFormat:@"%@",item.date];
        self.updated = [NSString stringWithFormat:@"%@",item.updated];
        self.summary = NIL_TO_STRING(item.summary)
        self.content = NIL_TO_STRING(item.content)
        self.enclosures = item.enclosures;
        self.identifier = NIL_TO_STRING(item.identifier)
        
        if ([self.enclosures isKindOfClass:[NSArray class]]) {
            if ([(NSArray *)self.enclosures count] > 0) {
                self.imageUrl = [(NSDictionary *)[(NSArray *)self.enclosures firstObject] objectForKey:@"url"];
            } else {
                self.imageUrl = nil;
            }
        } else {
            self.imageUrl = nil;
        }
    }
    return self;
}

@end
