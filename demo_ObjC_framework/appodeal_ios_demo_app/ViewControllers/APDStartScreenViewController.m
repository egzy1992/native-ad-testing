//
//  APDStartScreenViewController.m
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 6/10/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDStartScreenViewController.h"
#import "APDDisableNetworkViewController.h"
#import "AppDelegate.h"
#import "Masonry.h"

@interface APDStartScreenViewController ()

@property (nonatomic, strong) UIButton * legacyBtn;
@property (nonatomic, strong) UIButton * favoriteBtn;

@property (nonatomic, strong) UISwitch * childSwitch;
@property (nonatomic, strong) UITextField * appodealBaseURLLabel;

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
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_centerY).with.offset(-20);
        make.width.equalTo(@150);
    }];
    
    [self.favoriteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_centerY).with.offset(20);
        make.width.equalTo(@150);
    }];
    
    [self.appodealBaseURLLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(64);
        make.left.equalTo(self.view).with.offset(10);
        make.right.equalTo(self.view).with.offset(-10);
    }];
    
    [self.childSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.appodealBaseURLLabel);
        make.top.equalTo(self.appodealBaseURLLabel.mas_bottom).with.offset(20);
        make.width.equalTo(@50);
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

- (UITextField *)appodealBaseURLLabel{
    if (!_appodealBaseURLLabel) {
        _appodealBaseURLLabel = [[UITextField alloc] init];
        _appodealBaseURLLabel.placeholder = @"BASE_URL";
        _appodealBaseURLLabel.keyboardType = UIKeyboardTypeURL;
        _appodealBaseURLLabel.enablesReturnKeyAutomatically = YES;
        
        _appodealBaseURLLabel.borderStyle = UITextBorderStyleRoundedRect;
        _appodealBaseURLLabel.layer.borderColor = UIColor.redColor.CGColor;
        _appodealBaseURLLabel.textAlignment = NSTextAlignmentCenter;
        _appodealBaseURLLabel.textColor = UIColor.redColor;
        
        [self.view addSubview:_appodealBaseURLLabel];
    }
    return _appodealBaseURLLabel;
}

- (UISwitch *)childSwitch{
    if (!_childSwitch) {
        _childSwitch = [[UISwitch alloc] init];
        [_childSwitch addTarget:self action:@selector(childAction:) forControlEvents:UIControlEventValueChanged];
        _childSwitch.on = NO;
        
        [self.view addSubview:_childSwitch];
    }
    return _childSwitch;
}

#pragma mark --- DEF ACTION

- (void)defAction{
    UITapGestureRecognizer * hideKeyboardTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    [self.view addGestureRecognizer:hideKeyboardTap];
    [self.legacyBtn addTarget:self action:@selector(legacyClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.favoriteBtn addTarget:self action:@selector(favoriteClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)childAction:(id)object{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] setAppodealChildApp:self.childSwitch.isOn];
}

#pragma mark ---- CLICK SEGUE 

-(IBAction)legacyClick:(id)sender{
    
    [self saveAppodealBaseURL];
    
    APDDisableNetworkViewController * nextController = [APDDisableNetworkViewController new];
    nextController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    nextController.newApi = NO;
    [self.navigationController pushViewController:nextController animated:YES];
}

-(IBAction)favoriteClick:(id)sender{
    
    [self saveAppodealBaseURL];
    
    APDDisableNetworkViewController * nextController = [APDDisableNetworkViewController new];
    nextController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    nextController.newApi = YES;
    [self.navigationController pushViewController:nextController animated:YES];
}

- (IBAction)hideKeyboard:(id)sender{
    [self.appodealBaseURLLabel resignFirstResponder];
}

- (void)saveAppodealBaseURL{
    if ([self.appodealBaseURLLabel.text length]) {
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] setAppodealBaseURL:self.appodealBaseURLLabel.text];
    }
}

@end
