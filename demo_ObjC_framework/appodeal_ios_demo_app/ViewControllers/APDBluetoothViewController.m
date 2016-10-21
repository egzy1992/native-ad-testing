//
//  APDBluetoothViewController.m
//  AppodealApp
//
//  Created by Lozhkin Ilya on 5/24/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDBluetoothViewController.h"
#import "APDBluetoothView.h"

@interface APDBluetoothViewController ()
{
    APDBluetoothView * _bluetoothView;
}
@end

@implementation APDBluetoothViewController

-(void) viewDidLoad{
    [super viewDidLoad];
    
    {
        _bluetoothView = [[APDBluetoothView alloc] initWithFrame:self.view.frame];
        self.view = _bluetoothView;
    }
    
    [self apdBannerViewOnBottom];
}

- (void) viewWillDisappear:(BOOL)animated{
    [_bluetoothView deadLock];
    [super viewWillDisappear:animated];
}

@end
