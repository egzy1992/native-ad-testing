//
//  AppDelegate.m
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 6/10/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "AppDelegate.h"
#import "APDStartScreenViewController.h"
#import "APDDisableNetworkViewController.h"
#import "APDHUBViewController.h"
#import "MotionWindow.h"
#import <AudioToolbox/AudioServices.h>


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    application.applicationSupportsShakeToEdit = YES;
    self.window = [[MotionWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(synthesizeMemoryWarning) name:@"DemoAppShaked" object:nil];
    
    [self.window makeKeyAndVisible];
    self.window.rootViewController = [UIViewController new];
    
    {
        APDStartScreenViewController * rootController = [APDStartScreenViewController new];
        UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:rootController];
        self.window.rootViewController = navigationController;
    }
    
    {
        [self setAppearance];
    }
    
    return YES;
}


- (void)setAppearance {
    [[UINavigationBar appearance] setTranslucent:YES];
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:0.9 green:0.0 blue:0.0 alpha:0.95]];
}

- (void) initializeSdkWithParams:(APDDemoModel *)params andApiVersion:(BOOL)api {
    if (api) {
        [self initAPDWithParams:params];
    } else {
        [self initAppodealWithParams:params];
    }
}

- (void) initAPDWithParams:(APDDemoModel *)params {
    NSString * apiKey = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"AppodealAppKey"];
    
    [APDSdk sharedSdkWithApiKey:apiKey];
    [self disableNetworkForArray:self.disabledAdNetwork];
    
    [[APDSdk sharedSdk] setTesingMode:params.testMode];
    [[APDSdk sharedSdk] setLocationTracking:params.locationTracking];
    [[APDSdk sharedSdk] initializeForAdTypes:(APDType)params.adType];
    
    {
        APDHUBViewController * rootController = [APDHUBViewController new];
        rootController.toastMode = params.toastMode;
        UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:rootController];
        self.window.rootViewController = navigationController;
    }
}

- (void) initAppodealWithParams:(APDDemoModel *)params {
    NSString * apiKey = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"AppodealAppKey"];
    
    
    [self disableNetworkForArray:self.disabledAdNetwork];
    [Appodeal setTestingEnabled:params.testMode];
    [Appodeal setLocationTracking:params.locationTracking];
    [Appodeal setSmartBannersEnabled:params.bannerSmartSize];
    [Appodeal setBannerBackgroundVisible:params.bannerBackground];
    [Appodeal setBannerAnimationEnabled:params.bannerAnimation];
    
    if (params.userSettings) {
        [Appodeal setUserId:@"user_id"];
        [Appodeal setUserEmail:@"dt@email.net"];
        [Appodeal setUserBirthday:[NSDate date]];
        [Appodeal setUserAge:25];
        [Appodeal setUserGender:AppodealUserGenderMale];
        [Appodeal setUserOccupation:AppodealUserOccupationWork];
        [Appodeal setUserRelationship:AppodealUserRelationshipOther];
        [Appodeal setUserSmokingAttitude:AppodealUserSmokingAttitudeNeutral];
        [Appodeal setUserAlcoholAttitude:AppodealUserAlcoholAttitudeNeutral];
        [Appodeal setUserInterests:@"other"];
    }
    [Appodeal setAutocache:params.autoCache types:params.adType];
    [Appodeal initializeWithApiKey:apiKey types:params.adType];
    
    {
        APDHUBViewController * rootController = [APDHUBViewController new];
        [rootController wasInitializedLikeDeprecated];
        rootController.toastMode = params.toastMode;
        rootController.isAutoCache = params.autoCache;
        UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:rootController];
        self.window.rootViewController = navigationController;
    }
}

- (void)disableNetworkForArray:(NSArray *)disabledNetwork{
    if (!disabledNetwork) {
        return;
    }
    
    for (NetworkProperty * property in disabledNetwork) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [Appodeal disableNetworkForAdType:AppodealAdTypeNativeAd name:property.networkName];
        [Appodeal disableNetworkForAdType:AppodealAdTypeRewardedVideo name:property.networkName];
        [Appodeal disableNetworkForAdType:AppodealAdTypeMREC name:property.networkName];
        [Appodeal disableNetworkForAdType:AppodealAdTypeInterstitial name:property.networkName];
        [Appodeal disableNetworkForAdType:AppodealAdTypeBanner name:property.networkName];
#pragma clang diagnostic pop
    }
}

/*----------------------------------------------------------------------------------------------------------------------*/

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Private

//- (void)addMemoryWarningButton {
//    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button addTarget:self action:@selector(synthesizeMemoryWarning) forControlEvents:UIControlEventTouchUpInside];
//    [button setTitle:@"Synthesize Memory Warning" forState:UIControlStateNormal];
//    
//    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    [button.titleLabel setFont:[UIFont systemFontOfSize:12]];
//    
//    button.layer.borderWidth = 1.5;
//    button.layer.borderColor = [UIColor grayColor].CGColor;
//    button.backgroundColor = [UIColor whiteColor];
//    
//    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
//    CGFloat width = screenSize.width / 2;
//    CGFloat height = 33.0;
//    CGFloat x = width / 2;
//    CGFloat y = screenSize.height / 2 - (height + 10.0);
//    
//    [button setFrame:CGRectMake(x, y, width, height)];
//    [self.topPresentedContoller.view addSubview:button];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [button removeFromSuperview];
//    });
//}

- (UIViewController *)topPresentedContoller {
    UIViewController * controller = [[UIApplication sharedApplication] keyWindow].rootViewController;
    
    while (controller.presentedViewController) {
        controller = controller.presentedViewController;
    }
    
    return controller;
}

- (void)synthesizeMemoryWarning {
    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
    NSLog(@"[Demo] Synthesize memory warning");
    UIAlertController * controller = [UIAlertController alertControllerWithTitle:@"App synthesize memory warning" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [self.topPresentedContoller presentViewController:controller animated:NO completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [controller dismissViewControllerAnimated:NO completion:nil];
    });
    [[NSNotificationCenter defaultCenter] postNotificationName:UIApplicationDidReceiveMemoryWarningNotification object:nil];
}

@end
