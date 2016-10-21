//
//  APDAudioRecordingViewController.m
//  AppodealApp
//
//  Created by Lozhkin Ilya on 5/24/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDAudioRecordingViewController.h"
#import "APDAudioRecordingView.h"

@interface APDAudioRecordingViewController ()
{
    APDAudioRecordingView *  _audioRecording;
}
@end

@implementation APDAudioRecordingViewController


- (void) viewDidLoad {
    [super viewDidLoad];
    {
        _audioRecording = [[APDAudioRecordingView alloc] initWithFrame:self.view.frame];
        self.view = _audioRecording;
    }
    
    [self apdBannerViewOnBottom];
}

- (void) viewWillDisappear:(BOOL)animated{
    [_audioRecording deadLock];
    [super viewWillDisappear:animated];
}

@end
