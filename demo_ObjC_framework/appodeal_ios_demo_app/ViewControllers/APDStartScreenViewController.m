//
//  APDStartScreenViewController.m
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 6/10/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDStartScreenViewController.h"
#import "APDDisableNetworkViewController.h"
#import "Masonry.h"

@interface APDStartScreenViewController ()

@property (nonatomic, strong) UIButton * legacyBtn;
@property (nonatomic, strong) UIButton * favoriteBtn;

@end

@implementation APDStartScreenViewController

- (void) viewDidLoad{
    [super viewDidLoad];
    [self updateViewConstraints];
    
    {
        self.view.backgroundColor = UIColor.whiteColor;
        [self defAction];
    }
}

#pragma mark --- CONSTRAIN

- (void) updateViewConstraints {
    
    [self.legacyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.view.mas_centerY).with.offset(-20);
        make.width.equalTo(@150);
    }];
    
    [self.favoriteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.view.mas_centerY).with.offset(20);
        make.width.equalTo(@150);
    }];
    
    [super updateViewConstraints];
}

#pragma mark --- PROPERY

- (UIButton *) legacyBtn {
    if (!_legacyBtn) {
        _legacyBtn = k_apd_mainButtonWithTitle([NSLocalizedString(@"api 0.10.x", nil) uppercaseString]);
        [self.view addSubview:_legacyBtn];
    }
    return _legacyBtn;
}

- (UIButton *) favoriteBtn{
    if (!_favoriteBtn) {
        _favoriteBtn = k_apd_mainButtonWithTitle([NSLocalizedString(@"api 1.0.x", nil) uppercaseString]);
        [self.view addSubview:_favoriteBtn];
    }
    return _favoriteBtn;
}


#pragma mark --- DEF ACTION

- (void) defAction{
    [self.legacyBtn addTarget:self action:@selector(legacyClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.favoriteBtn addTarget:self action:@selector(favoriteClick:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark ---- CLICK SEGUE 

-(IBAction)legacyClick:(id)sender{
    
    APDDisableNetworkViewController * nextController = [APDDisableNetworkViewController new];
    nextController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    nextController.newApi = NO;
    [self.navigationController pushViewController:nextController animated:YES];
}

-(IBAction)favoriteClick:(id)sender{
    
    APDDisableNetworkViewController * nextController = [APDDisableNetworkViewController new];
    nextController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    nextController.newApi = YES;
    [self.navigationController pushViewController:nextController animated:YES];
}

@end
