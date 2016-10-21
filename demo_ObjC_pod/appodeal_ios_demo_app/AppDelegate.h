//
//  AppDelegate.h
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 6/10/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Appodeal/Appodeal.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void) initializeSdk:(AppodealAdType)adType testMode:(BOOL)testMode debugMode:(BOOL)debug locationTracking:(BOOL)locationTracking autoCache:(BOOL)autoCache userData:(BOOL)userData toast:(BOOL)toastMode;
- (void) initializeSdk:(APDAdType)adType testMode:(BOOL)testMode locationTracking:(BOOL)locationTracking toast:(BOOL)toastMode;

@end

