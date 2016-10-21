//
//  RSSStream.h
//  RamblerDemo
//
//  Created by ilya lozhkin on 18/03/16.
//  Copyright © 2016 dtlbox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol RSSStreamDelegate <NSObject>
@required

-(void) rssStreamWithArray:(NSArray *) array;

@end

@interface RSSStream : NSObject

@property (nonatomic, weak) id<RSSStreamDelegate> delegateRSS;

-(instancetype) initWithURL:(NSString *)url andController:(UIViewController *) controller;

@end
