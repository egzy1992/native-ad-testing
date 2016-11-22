//
//  APDInitilizeViewController.m
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 6/10/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDInitilizeViewController.h"
#import "AppDelegate.h"
#import "Masonry.h"

@interface APDInitilizeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) APDDemoModel * demoModel;
@property (nonatomic, strong) UITableView * tableView;

@end

@implementation APDInitilizeViewController

- (void) viewDidLoad {
    
    {
        self.navigationItem.title = [NSLocalizedString(self.newApi ? @"api 1.0.x" : @"api 0.10.x", nil) uppercaseString];
    }
    
    [super viewDidLoad];
    [self updateViewConstraints];
    
    {
        self.view.backgroundColor = UIColor.whiteColor;
    }
    
    self.demoModel = [APDDemoModel new];
}


- (void) updateViewConstraints{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [super updateViewConstraints];
}

#pragma mark --- Property

-(UITableView *) tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.scrollEnabled = YES;
        _tableView.estimatedRowHeight = 44.0f;
        _tableView.estimatedSectionHeaderHeight = 44.0f;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"continue"];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

-(UIView *) headerView:(NSString *)title tintColor:(UIColor *)tintColor fontSize:(CGFloat)fontSize backgroundColor:(UIColor *)backgroundColor{
    UILabel * newLabel = [UILabel new];
    UIView * view = [UIView new];
    view.backgroundColor = backgroundColor;
    
    {
        [view addSubview:newLabel];
    }
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName: tintColor,
                                 NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Light" size:fontSize],
                                 NSKernAttributeName: @2};
    newLabel.attributedText = [[NSAttributedString alloc] initWithString:title attributes:attributes];
    
    [newLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view).with.offset(25);
        make.left.equalTo(view).with.offset(15);
        make.right.equalTo(view).with.offset(5);
        make.bottom.equalTo(view).with.offset(-2);
    }];
    
    return view;
}

#pragma mark --- SWITCH_CONTROLL

- (UISwitch *) switchWithIndexPath:(NSIndexPath *)indexPath andCheck:(BOOL)check{
    UISwitch * swith = [UISwitch new];
    swith.on = check;
    [swith addTarget:self action:@selector(swithChanged:) forControlEvents:UIControlEventValueChanged];
    swith.tag = [self tagWithIndexPath:indexPath];
    return swith;
}

-(NSInteger)tagWithIndexPath:(NSIndexPath *)indexPath{
    NSInteger tag = indexPath.section * 10 + indexPath.row;
    return tag;
}

-(NSIndexPath *)indexPathFromTag:(NSInteger)tag{
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:(tag % 10) inSection:(tag / 10)];
    return indexPath;
}

#pragma mark --- SWITCH_SELECTED

- (IBAction)swithChanged:(id)sender{
    NSIndexPath * indexPath = [self indexPathFromTag:[(UISwitch *)sender tag]];
    BOOL flag = [(UISwitch *)sender isOn];
    
    if (indexPath.section == 0) {
        AppodealAdType adType = indexPath.row == 0 ? AppodealAdTypeInterstitial : indexPath.row == 1 ? AppodealAdTypeRewardedVideo : indexPath.row == 2 ? AppodealAdTypeBanner : indexPath.row == 3 ? AppodealAdTypeMREC : AppodealAdTypeNativeAd;
        if (flag) {
            self.demoModel.adType |= adType;
        } else {
            self.demoModel.adType ^= adType;
        }
    }
    
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0: self.demoModel.interstitial = flag ;            break;
                case 1: self.demoModel.rewardedVideo = flag ;           break;
                case 2: self.demoModel.banner = flag ;                  break;
                case 3: self.demoModel.MREC = flag ;                    break;
                case 4: self.demoModel.nativeAds = flag ;               break;
            } break;
        case 1:
            switch (indexPath.row) {
                case 0: if (self.newApi) self.demoModel.locationTracking = flag; else self.demoModel.autoCache = flag; break;
                case 1: if (self.newApi) self.demoModel.userSettings = flag; else self.demoModel.locationTracking = flag; break;
                case 2: if (!self.newApi)self.demoModel.userSettings = flag; break;
            } break;
        case 2:
            switch (indexPath.row) {
                case 0: self.demoModel.testMode = flag;                 break;
                case 1: self.demoModel.toastMode = flag;                break;
            } break;
            
        case 3:
            switch (indexPath.row) {
                case 0: self.demoModel.bannerSmartSize = flag;          break;
                case 1: self.demoModel.bannerAnimation = flag;          break;
                case 2: self.demoModel.bannerBackground = flag;         break;
            } break;
    }
}

#pragma mark ---TableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0: return 5; break;
        case 1: if (self.newApi) return 2; else return 3; break;
        case 2: return 2; break;
        case 3: return 3; break;
        case 4: return 1; break;
        default: break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * cellName = @"cell";
    NSString * continueName = @"continue";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName forIndexPath:indexPath];
    if (indexPath.section == 4) {
        cell = [tableView dequeueReusableCellWithIdentifier:continueName forIndexPath:indexPath];
    }
    
    BOOL flag = NO;
    NSString * text = @"";
    
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0: flag = self.demoModel.interstitial; text = @"interstitial";             break;
                case 1: flag = self.demoModel.rewardedVideo; text = @"rewarded video";          break;
                case 2: flag = self.demoModel.banner; text = @"banner";                         break;
                case 3: flag = self.demoModel.MREC; text = @"mrec";                             break;
                case 4: flag = self.demoModel.nativeAds; text = @"native ads";                  break;
            } break;
        case 1:
            switch (indexPath.row) {
                case 0: if (self.newApi) {flag = self.demoModel.locationTracking; text = @"location tracking";} else {flag = self.demoModel.autoCache; text = @"auto cache";} break;
                case 1: if (self.newApi) {flag = self.demoModel.userSettings; text = @"user settings";} else {flag = self.demoModel.locationTracking; text = @"location tracking";} break;
                case 2: if (!self.newApi) {flag = self.demoModel.userSettings; text = @"user settings";} break;
            } break;
            
        case 2:
            switch (indexPath.row) {
                case 0: flag = self.demoModel.testMode; text = @"test mode";                    break;
                case 1: flag = self.demoModel.toastMode; text = @"toast mode";                  break;
            } break;
            
        case 3:
            switch (indexPath.row) {
                case 0: flag = self.demoModel.bannerSmartSize; text = @"banner smart size";     break;
                case 1: flag = self.demoModel.bannerAnimation; text = @"banner animation";      break;
                case 2: flag = self.demoModel.bannerBackground; text = @"banner background";    break;
            } break;
        case 4: text = @"initialize"; break;
            
    }
    
    NSDictionary *attributesMainText = @{NSForegroundColorAttributeName: UIColor.blackColor,
                                         NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:16],
                                         NSKernAttributeName: @(1.2)};
    
    cell.textLabel.attributedText = [[NSAttributedString alloc] initWithString:text attributes:attributesMainText];
    
    if (indexPath.section != 4) {
        cell.accessoryView = [self switchWithIndexPath:indexPath andCheck:flag];
    } else {
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 4) {
        [((AppDelegate *)[[UIApplication sharedApplication] delegate]) initializeSdkWithParams:self.demoModel andApiVersion:self.newApi];
    }
}
@end
