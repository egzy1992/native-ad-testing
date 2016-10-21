//
//  AppodealToast.m
//  AppodealSandbox
//
//  Created by Stas Kochkin on 30/11/15.
//  Copyright © 2015 Appodeal, Inc. All rights reserved.
//

#import "AppodealToast.h"

@implementation AppodealToast

+ (void) showToastInView:(UIView *)view withMessage:(NSString *)toastMessage{
    CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
    style.messageColor = [UIColor redColor];
    CGPoint point = CGPointMake(CGRectGetMidX(view.frame), CGRectGetHeight(view.frame) - 100) ;
    [view makeToast: toastMessage
           duration:3.0
           position:[NSValue valueWithCGPoint:point]
              style:style];
    [CSToastManager setSharedStyle:style];
    [CSToastManager setTapToDismissEnabled:YES];
    [CSToastManager setQueueEnabled:YES];
}

@end
