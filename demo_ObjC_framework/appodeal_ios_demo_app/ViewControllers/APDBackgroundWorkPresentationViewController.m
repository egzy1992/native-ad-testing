//
//  APDBackgroundWorkPresentationViewController.m
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 8/9/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDBackgroundWorkPresentationViewController.h"
#import "APDBackgoundWorkPresentationView.h"

#import "APDGeoViewController.h"
#import "APDVideoViewController.h"
#import "APDTimerViewController.h"
#import "APDAudioRecordingViewController.h"
#import "APDBluetoothViewController.h"
#import "APDPhoneCallViewController.h"

@interface APDBackgroundWorkPresentationViewController ()
{
    APDBackgoundWorkPresentationView * _apdBackgroundWorkView;
}
@end

@implementation APDBackgroundWorkPresentationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    {
        _apdBackgroundWorkView = [[APDBackgoundWorkPresentationView alloc] initWithFrame:self.view.frame];
        self.view = _apdBackgroundWorkView;
    }
    
    {
        [_apdBackgroundWorkView.geoButton addTarget:self action:@selector(geoClick:) forControlEvents:UIControlEventTouchUpInside];
        [_apdBackgroundWorkView.videoButton addTarget:self action:@selector(videoClick:) forControlEvents:UIControlEventTouchUpInside];
        [_apdBackgroundWorkView.timerButton addTarget:self action:@selector(timerClick:) forControlEvents:UIControlEventTouchUpInside];
        [_apdBackgroundWorkView.audioRecordButton addTarget:self action:@selector(audioClick:) forControlEvents:UIControlEventTouchUpInside];
        [_apdBackgroundWorkView.bluetoothButton addTarget:self action:@selector(bluetoothClick:) forControlEvents:UIControlEventTouchUpInside];
        [_apdBackgroundWorkView.phoneCallButton addTarget:self action:@selector(phoneCallClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark --- ACTIONS

-(IBAction)geoClick:(id)sender{
    APDGeoViewController * nextController = [APDGeoViewController new];
    [self.navigationController pushViewController:nextController animated:YES];
}

-(IBAction)videoClick:(id)sender{
    APDVideoViewController * nextController = [APDVideoViewController new];
    [self.navigationController pushViewController:nextController animated:YES];
}

-(IBAction)timerClick:(id)sender{
    APDTimerViewController * nextController = [APDTimerViewController new];
    [self.navigationController pushViewController:nextController animated:YES];
}

-(IBAction)audioClick:(id)sender{
    APDAudioRecordingViewController * nextController = [APDAudioRecordingViewController new];
    [self.navigationController pushViewController:nextController animated:YES];
}

-(IBAction)bluetoothClick:(id)sender{
    APDBluetoothViewController * nextController = [APDBluetoothViewController new];
    [self.navigationController pushViewController:nextController animated:YES];
}

-(IBAction)phoneCallClick:(id)sender{
    APDPhoneCallViewController * nextController = [APDPhoneCallViewController new];
    [self.navigationController pushViewController:nextController animated:YES];
}

@end
