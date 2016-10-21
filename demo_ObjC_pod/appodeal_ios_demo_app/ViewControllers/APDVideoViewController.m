//
//  APDVideoViewController.m
//  AppodealApp
//
//  Created by Lozhkin Ilya on 5/23/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDVideoViewController.h"
#import "APDVideoView.h"

@interface APDVideoViewController ()
{
    APDVideoView * _videoView;
}
@end

@implementation APDVideoViewController

-(void) viewDidLoad{
    [super viewDidLoad];
    {
        _videoView = [[APDVideoView alloc] initWithFrame:self.view.bounds];
        self.view = _videoView;
    }
    [self apdBannerViewOnBottom];
}

@end
