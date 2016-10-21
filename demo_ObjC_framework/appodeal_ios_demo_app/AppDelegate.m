//
//  AppDelegate.m
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 6/10/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "AppDelegate.h"
#import "APDRootNavigationController.h"
#import "APDStartScreenViewController.h"
#import "APDAdTypePresentationViewController.h"
#import "APDFavoriteAdTypePresentationViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
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

- (void) initializeSdk:(AppodealAdType)adType testMode:(BOOL)testMode debugMode:(BOOL)debug locationTracking:(BOOL)locationTracking autoCache:(BOOL)autoCache userData:(BOOL)userData toast:(BOOL)toastMode{
    NSString * apiKey = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"AppodealAppKey"];
    
//    [Appodeal disableNetworkForAdType:AppodealAdTypeBanner name:@"admob"];
    
    [Appodeal setTestingEnabled:testMode];
    [Appodeal setDebugEnabled:debug];
    [Appodeal setLocationTracking:!locationTracking];
    
    if (userData) {
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
    [Appodeal setAutocache:autoCache types:adType];
    [Appodeal initializeWithApiKey:apiKey types:adType];
    
    {
        APDAdTypePresentationViewController * rootController = [APDAdTypePresentationViewController new];
        [rootController wasInitializedLikeDeprecated];
        rootController.toastMode = toastMode;
        rootController.isAutoCache = autoCache;
        APDRootNavigationController * navigationController = [[APDRootNavigationController alloc] initWithRootViewController:rootController];
        self.window.rootViewController = navigationController;
    }
}

- (void) initializeSdk:(APDAdType)adType testMode:(BOOL)testMode locationTracking:(BOOL)locationTracking toast:(BOOL)toastMode{
    NSString * apiKey = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"AppodealAppKey"];
    
    [APDSdk sharedSdkWithApiKey:apiKey];
    [[APDSdk sharedSdk] setTesingMode:testMode];
    [[APDSdk sharedSdk] setLocationTracking:locationTracking];
    [[APDSdk sharedSdk] initializeForAdTypes:adType];
//    [[APDSdk sharedSdk] setLogLevel:APDLogLevelDebug];
    
    {
        APDFavoriteAdTypePresentationViewController * rootController = [APDFavoriteAdTypePresentationViewController new];
        rootController.toastMode = toastMode;
        APDRootNavigationController * navigationController = [[APDRootNavigationController alloc] initWithRootViewController:rootController];
        self.window.rootViewController = navigationController;
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

@end
