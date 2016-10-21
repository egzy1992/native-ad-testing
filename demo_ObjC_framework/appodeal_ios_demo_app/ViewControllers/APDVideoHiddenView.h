//
//  APDVideoHiddenView.h
//  AppodealApp
//
//  Created by Lozhkin Ilya on 5/24/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDRootView.h"

@interface APDVideoHiddenView : APDRootView

@property (nonatomic, strong) UIButton * showVideo;

- (void) showTopLvlWindow;
- (void) hideTopLvlWindow;
- (void) setTextDescription:(NSString *)text;

@end
