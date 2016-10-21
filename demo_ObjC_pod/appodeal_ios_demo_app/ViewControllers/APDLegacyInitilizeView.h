//
//  APDLegacyInitilizeView.h
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 6/10/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDRootView.h"

@interface APDLegacyInitilizeView : APDRootView

@property (nonatomic, strong) UITableView * tableView;

-(UIView *) headerView:(NSString *)title tintColor:(UIColor *)tintColor fontSize:(CGFloat)fontSize backgroundColor:(UIColor *)backgroundColor;

@end
