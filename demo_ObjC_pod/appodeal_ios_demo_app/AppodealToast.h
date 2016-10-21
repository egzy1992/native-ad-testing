//
//  AppodealToast.h
//  AppodealSandbox
//
//  Created by Stas Kochkin on 30/11/15.
//  Copyright © 2015 Appodeal, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIView+Toast.h"

@interface AppodealToast : NSObject

+ (void) showToastInView: (UIView*) view withMessage: (NSString*) toastMessage;

@end
