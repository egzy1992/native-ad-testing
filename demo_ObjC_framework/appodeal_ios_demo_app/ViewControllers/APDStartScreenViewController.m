//
//  APDStartScreenViewController.m
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 6/10/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDStartScreenViewController.h"
#import "APDStartScreenView.h"
#import "APDLegacyInitilizeViewController.h"
#import "APDInitilizeViewController.h"

@interface APDStartScreenViewController ()
{
    APDStartScreenView * _startScreenView;
}
@end

@implementation APDStartScreenViewController

- (void) viewDidLoad{
    [super viewDidLoad];
    
    {
        _startScreenView = [[APDStartScreenView alloc] initWithFrame:self.view.frame];
        self.view = _startScreenView;
    }
    
    {
        [self defAction];
    }
}

#pragma mark --- DEF ACTION

- (void) defAction{
    [_startScreenView.legacyBtn addTarget:self action:@selector(legacyClick:) forControlEvents:UIControlEventTouchUpInside];
    [_startScreenView.favoriteBtn addTarget:self action:@selector(favoriteClick:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark ---- CLICK SEGUE 

-(IBAction)legacyClick:(id)sender{
    APDLegacyInitilizeViewController * nextController = [APDLegacyInitilizeViewController new];
    nextController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.navigationController pushViewController:nextController animated:YES];
}

-(IBAction)favoriteClick:(id)sender{
    APDInitilizeViewController * nextController = [APDInitilizeViewController new];
    nextController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.navigationController pushViewController:nextController animated:YES];
}

@end
