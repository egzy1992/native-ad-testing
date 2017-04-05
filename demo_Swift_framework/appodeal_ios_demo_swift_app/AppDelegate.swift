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
    var disabledNetworks : NSMutableArray = []
    var configuration : APDDemoModel! = APDDemoModel()
    var userData : APDUserDataModel! = APDUserDataModel()
    
    private var mainTabBarController : UITabBarController = UITabBarController()
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.setAppearance()
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        
        self.initialTabBarController()
        
        return true
    }
    
    func initialTabBarController(){
        mainTabBarController.tabBar.tintColor = UIColor.blue
        
        let disabledNetworkController = APDDisableNetwork()
        let disableNetworkBarItem = UITabBarItem(title: "network", image: nil, tag: 0)
        disabledNetworkController.tabBarItem = disableNetworkBarItem;
        
        let configurationController = APDAppodealConfiguration()
        let configurationBarItem = UITabBarItem(title: "config", image: nil, tag: 1)
        configurationController.tabBarItem = configurationBarItem;
        
        let userDataController = APDUserDataConfiguration()
        let userDataBarItem = UITabBarItem(title: "userData", image: nil, tag: 2)
        userDataController.tabBarItem = userDataBarItem;

        let initializeController = APDStartScreen()
        let initializeBarItem = UITabBarItem(title: "init", image: nil, tag: 3)
        initializeController.tabBarItem = initializeBarItem;
        
        mainTabBarController.setViewControllers([disabledNetworkController, configurationController, userDataController, initializeController], animated: true)
        self.window?.rootViewController = UINavigationController.init(rootViewController: mainTabBarController)
    }
    
    func setAppearance (){
        UINavigationBar.appearance().tintColor = UIColor.init(red: 0.9, green: 0.0, blue: 0.0, alpha: 0.95)
        UINavigationBar.appearance().isTranslucent = true
    }
    
    func initializeSdk (){
        let apiKey = Bundle.main.object(forInfoDictionaryKey: "AppodealAppKey") as! String
        Appodeal.setTestingEnabled(configuration.testMode)
        Appodeal.setLocationTracking(configuration.locationTracking)
        Appodeal.setBannerAnimationEnabled(configuration.bannerAnimation)
        Appodeal.setBannerBackgroundVisible(configuration.bannerBackground)
        Appodeal.setSmartBannersEnabled(configuration.bannerSmartSize)
        disableNetworkForArray(disabledNetwork: disabledNetworks)
        
        if userData.userSettings {
            Appodeal.setUserId(userData.userId)
            Appodeal.setUserEmail(userData.userEmail)
            Appodeal.setUserBirthday(userData.userBirthday as Date!)
            Appodeal.setUserAge(userData.userAge)
            Appodeal.setUserGender(userData.userGender)
            Appodeal.setUserOccupation(userData.userOccupation)
            Appodeal.setUserRelationship(userData.userRelationship)
            Appodeal.setUserSmokingAttitude(userData.userSmokingAttitude)
            Appodeal.setUserAlcoholAttitude(userData.userAlcoholAttitude)
            Appodeal.setUserInterests(userData.userInterests)
        }
        
        Appodeal.setLogLevel(APDLogLevel.info)
        Appodeal.setAutocache(configuration.autoCache, types: configuration.adType)
        Appodeal.initialize(withApiKey: apiKey, types: configuration.adType)
        
        let rootViewVontroller : APDAppodealHUB = APDAppodealHUB()
        rootViewVontroller.isAutoCache = configuration.autoCache
        self.window?.rootViewController = UINavigationController.init(rootViewController: rootViewVontroller)
    }
    
    func disableNetworkForArray(disabledNetwork : NSArray){
        if  disabledNetwork.count == 0{
            return
        }
    
        for networkName in disabledNetwork {
            Appodeal.disableNetwork(for: AppodealAdType.interstitial, name: networkName as! String)
            Appodeal.disableNetwork(for: AppodealAdType.banner, name: networkName as! String)
            Appodeal.disableNetwork(for: AppodealAdType.rewardedVideo, name: networkName as! String)
            Appodeal.disableNetwork(for: AppodealAdType.MREC, name: networkName as! String)
            Appodeal.disableNetwork(for: AppodealAdType.nativeAd, name: networkName as! String)
        }
        
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

