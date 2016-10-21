//
//  AppDelegate.swift
//  appodeal_ios_demo_swift_app
//
//  Created by Lozhkin Ilya on 9/8/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

import UIKit
import Appodeal

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.setAppearance()
        
        let rootController : APDStartScreen = APDStartScreen()
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController = UINavigationController.init(rootViewController: rootController)
        
        return true
    }
    
    func setAppearance (){
        UINavigationBar.appearance().tintColor = UIColor.init(red: 0.9, green: 0.0, blue: 0.0, alpha: 0.95)
        UINavigationBar.appearance().isTranslucent = true
    }
    
    func initializeSdk(withAdType adType:AppodealAdType, testMode:Bool, locationTracking:Bool, autoCache:Bool, userData:Bool, toastMode toast:Bool){
        let apiKey = Bundle.main.object(forInfoDictionaryKey: "AppodealAppKey") as! String
        Appodeal.setTestingEnabled(testMode)
        Appodeal.setLocationTracking(!locationTracking)
        
        if userData {
            Appodeal.setUserId("user_id")
            Appodeal.setUserEmail("dt@email.net")
            Appodeal.setUserBirthday(Date() as Date!)
            Appodeal.setUserAge(25)
            Appodeal.setUserGender(AppodealUserGender.male)
            Appodeal.setUserOccupation(AppodealUserOccupation.work)
            Appodeal.setUserRelationship(AppodealUserRelationship.other)
            Appodeal.setUserSmokingAttitude(AppodealUserSmokingAttitude.neutral)
            Appodeal.setUserAlcoholAttitude(AppodealUserAlcoholAttitude.neutral)
            Appodeal.setUserInterests("other")
        }
        
        Appodeal.setAutocache(autoCache, types: adType)
//        let adTypes: AppodealAdType = [.banner, .interstitial] //
        Appodeal.initialize(withApiKey: apiKey, types: adType)

        let rootViewVontroller : APDAppodealHUB = APDAppodealHUB()
        rootViewVontroller.isAutoCache = autoCache
        self.window?.rootViewController = UINavigationController.init(rootViewController: rootViewVontroller)
        
        //
        //    {
        //    APDAdTypePresentationViewController * rootController = [APDAdTypePresentationViewController new];
        //    [rootController wasInitializedLikeDeprecated];
        //    rootController.toastMode = toastMode;
        //    rootController.isAutoCache = autoCache;
        //    APDRootNavigationController * navigationController = [[APDRootNavigationController alloc] initWithRootViewController:rootController];
        //    self.window.rootViewController = navigationController;
        //    }
    }
    
//    
//    - (void) initializeSdk:(APDAdType)adType testMode:(BOOL)testMode locationTracking:(BOOL)locationTracking toast:(BOOL)toastMode{
//    NSString * apiKey = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"AppodealAppKey"];
//    
//    [APDSdk sharedSdkWithApiKey:apiKey];
//    [[APDSdk sharedSdk] setTesingMode:testMode];
//    [[APDSdk sharedSdk] setLocationTracking:locationTracking];
//    [[APDSdk sharedSdk] initializeForAdTypes:adType];
//    //    [[APDSdk sharedSdk] setLogLevel:APDLogLevelDebug];
//    
//    {
//    APDFavoriteAdTypePresentationViewController * rootController = [APDFavoriteAdTypePresentationViewController new];
//    rootController.toastMode = toastMode;
//    APDRootNavigationController * navigationController = [[APDRootNavigationController alloc] initWithRootViewController:rootController];
//    self.window.rootViewController = navigationController;
//    }
//    }

    //----------------------------------------------------------------------------------------------------

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

