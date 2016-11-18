//
//  APDViewModel.h
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 8/10/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define AppLog(fmt, ...) [APDViewModel logWithString:[NSString stringWithFormat:@"[Call]-%s WithUserDesription:" fmt,__PRETTY_FUNCTION__,##__VA_ARGS__]];

typedef NS_ENUM(NSUInteger, APD_STATUS){
    kAPD_STATUS_LOAD = 0,
    kAPD_STATUS_FAIL_TO_LOAD,
    kAPD_STATUS_FAIL_TO_PRESENT,
    kAPD_STATUS_LOADED,
    kAPD_STATUS_PRESENTED,
    kAPD_STATUS_NILL
};

UIButton * k_apd_mainButtonWithTitle (NSString * title);
NSAttributedString * k_apd_mainAttributedFromMainButton(NSString * string);

@interface APDViewModel : NSObject

+ (void) logWithString:(NSString *)string;

@end

@interface DescriptionCell : UITableViewCell

@end
