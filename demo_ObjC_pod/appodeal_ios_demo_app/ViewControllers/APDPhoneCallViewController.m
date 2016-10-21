//
//  APDPhoneCallViewController.m
//  AppodealApp
//
//  Created by Lozhkin Ilya on 5/25/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDPhoneCallViewController.h"
#import "APDPhoneCallView.h"

@interface APDPhoneCallViewController ()
{
    APDPhoneCallView * _phoneCallView;
}
@end

@implementation APDPhoneCallViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    
    {
        _phoneCallView = [[APDPhoneCallView alloc] initWithFrame:self.view.frame];
        self.view = _phoneCallView;
        
        [self apdBannerViewOnBottom];
    }
}

@end
