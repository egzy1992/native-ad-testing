//
//  APDNativeView.h
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 8/8/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Appodeal/Appodeal.h>
#import "APDNativeAdRenderView.h"

@interface APDNativeView : UIView <APDNativeAdRenderView>

- (void) makeConstrain;

@end
