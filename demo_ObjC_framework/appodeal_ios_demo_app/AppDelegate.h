//
//  AppDelegate.h
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 6/10/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Appodeal/Appodeal.h>
#import "APDDemoModel.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) NSArray * disabledAdNetwork;

@property (nonatomic, strong) NSString * appodealBaseURL;

@property (nonatomic, assign) BOOL appodealChildApp;

- (void) initializeSdkWithParams:(APDDemoModel *)params andApiVersion:(BOOL)api;

@end

