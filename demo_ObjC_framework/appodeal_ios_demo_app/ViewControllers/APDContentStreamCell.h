//
//  APDContentStreamCell.h
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 6/20/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Appodeal/Appodeal.h>
#import <Appodeal/APDMediaView.h>

@interface APDContentStreamCell : UITableViewCell

- (void) setNativeAd:(APDNativeAd *)nativeAd fromViewController:(UIViewController *)controller;

@end
