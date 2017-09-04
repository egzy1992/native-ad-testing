//
//  APDOnLoad.m
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 6/30/17.
//  Copyright © 2017 Lozhkin Ilya. All rights reserved.
//

#import "APDOnLoad.h"
#import "AppDelegate.h"
#import <objc/runtime.h>

@implementation APDOnLoad

@end

@implementation NSBundle (swizz)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = self;
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        
        SEL originalSelector = @selector(objectForInfoDictionaryKey:);
        
#pragma clang diagnostic pop
        
        SEL swizzledSelector = @selector(apd_objectForInfoDictionaryKey:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

-(id)apd_objectForInfoDictionaryKey:(NSString *)key{
    if ([key isEqualToString:@"AppodealBaseURL"]) {
        return [(AppDelegate *)[[UIApplication sharedApplication] delegate] appodealBaseURL];
    } else {
        return [self apd_objectForInfoDictionaryKey:key];
    }
}

@end
