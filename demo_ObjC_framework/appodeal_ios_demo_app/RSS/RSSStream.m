//
//  RSSStream.m
//  RamblerDemo
//
//  Created by ilya lozhkin on 18/03/16.
//  Copyright © 2016 dtlbox. All rights reserved.
//

#define max                 30

#import "RSSStream.h"

@interface RSSStream () <MWFeedParserDelegate>
{
    NSURL * rssURL;
    MWFeedParser * feedParser;
    NSMutableArray * modelsArray;
    
    NSInteger count;
}
@end

@implementation RSSStream

-(instancetype) initWithURL:(NSString *)url andController:(UIViewController *)controller{
    self = [super init];
    if (self) {
        self->rssURL = [NSURL URLWithString:url];
        feedParser = [[MWFeedParser alloc] initWithFeedURL:rssURL];
        feedParser.delegate = self;
        feedParser.feedParseType = ParseTypeItemsOnly;
        
        modelsArray = [NSMutableArray array];
        self.delegateRSS = (id<RSSStreamDelegate>)controller;
        
        count = 0;
        
        [feedParser parse];
    }
    return self;
}

#pragma mark --- DELEGATE

- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item{
    if (count < max) {
        RSSModel * model = [[RSSModel alloc] initWithItem:item];
        [modelsArray addObject:model];
        count++;
    } else {
        [feedParser stopParsing];
    }
}
- (void)feedParserDidFinish:(MWFeedParser *)parser{
    DLog(@"Parse %@ complete success -- feed count = %li",NSStringFromClass([self class]),[modelsArray count]);
    [self.delegateRSS rssStreamWithArray:modelsArray];
}
- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error{
    DLog(@"Parse %@ complete with error %@",NSStringFromClass([self class]),error);
}

@end
