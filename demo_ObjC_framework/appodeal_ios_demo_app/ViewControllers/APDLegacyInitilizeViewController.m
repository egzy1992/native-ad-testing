//
//  APDLegacyInitilizeViewController.m
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 6/10/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDLegacyInitilizeViewController.h"
#import "APDLegacyInitilizeView.h"
#import "AppDelegate.h"
#import <Appodeal/Appodeal.h>

@interface APDLegacyInitilizeViewController() <UITableViewDelegate, UITableViewDataSource>
{
    APDLegacyInitilizeView * _legacyInitializeView;
    NSMutableDictionary * _cellDictName;
    NSMutableDictionary * _cellDescriptionName;
    NSMutableDictionary * _cellHeaderName;
    NSArray * _adModules;
    
    NSMutableDictionary * _enableModules;
    BOOL _locationPermition;
    BOOL _autoCache;
    BOOL _userData;
    BOOL _testMode;
    BOOL _debugMode;
    BOOL _toastMode;
}
@end

@implementation APDLegacyInitilizeViewController

-(void) viewDidLoad {
    
    {
        self.navigationItem.title = [NSLocalizedString(@"api 0.10.x", nil) uppercaseString];
    }
    
    [super viewDidLoad];
    
    {
        _legacyInitializeView = [[APDLegacyInitilizeView alloc] initWithFrame:self.view.frame];
        self.view = _legacyInitializeView;
    }
    
    {
        _legacyInitializeView.tableView.delegate = self;
        _legacyInitializeView.tableView.dataSource = self;
    }
    
    {
        _cellDictName = [self cellDictName];
        _cellDescriptionName = [self cellDescriptionName];
        _cellHeaderName = [self cellHeaderName];
        _enableModules = [self enabledModules];
    }
    
    {
        _locationPermition = NO;
        _autoCache = YES;
        _userData = YES;
        _testMode = NO;
        _debugMode = NO;
        _toastMode = YES;
    }
}

#pragma mark --- CELL_NAME

- (NSMutableDictionary *) cellDictName { // _adModules!
    if (!_cellDictName) {
        NSDictionary * cellName = @{[self i_Ps:0 index:0] : NSLocalizedString(@"banner", nil),
                                    [self i_Ps:0 index:1] : NSLocalizedString(@"interstitial ad", nil),
                                    [self i_Ps:0 index:2] : NSLocalizedString(@"skippable video", nil),
                                    [self i_Ps:0 index:3] : NSLocalizedString(@"rewarded video", nil),
                                    [self i_Ps:0 index:4] : NSLocalizedString(@"native ads", nil),
                                    [self i_Ps:0 index:5] : NSLocalizedString(@"MREC", nil),
                                    [self i_Ps:1 index:0] : NSLocalizedString(@"disable location permition check", nil),
                                    [self i_Ps:1 index:1] : NSLocalizedString(@"set auto cache", nil),
                                    [self i_Ps:1 index:2] : NSLocalizedString(@"user data", nil),
                                    [self i_Ps:2 index:0] : NSLocalizedString(@"test mode", nil),
                                    [self i_Ps:2 index:1] : NSLocalizedString(@"debug mode", nil),
                                    [self i_Ps:2 index:2] : NSLocalizedString(@"toast mode", nil),
                                    [self i_Ps:3 index:0] : NSLocalizedString(@"Initialize", nil)};
        _adModules = @[@(AppodealAdTypeBanner),
                       @(AppodealAdTypeInterstitial),
                       @(AppodealAdTypeSkippableVideo),
                       @(AppodealAdTypeRewardedVideo),
                       @(AppodealAdTypeNativeAd),
                       @(AppodealAdTypeMREC)];
        
        _cellDictName = [[NSMutableDictionary alloc] initWithDictionary:cellName];
    }
    return _cellDictName;
}

- (NSMutableDictionary *) cellDescriptionName{
    if (!_cellDescriptionName) {
        NSDictionary * cellName = @{[self i_Ps:0 index:0] : NSLocalizedString(@"/* [Appodeal disableNetworkForAdType:AppodealAdTypeBanner name:@\"networkName\"] */", nil),
                                    [self i_Ps:0 index:1] : NSLocalizedString(@"/* [Appodeal disableNetworkForAdType:AppodealAdTypeInterstitial name:@\"networkName\"] */", nil),
                                    [self i_Ps:0 index:2] : NSLocalizedString(@"/* [Appodeal disableNetworkForAdType:AppodealAdTypeSkippableVideo name:@\"networkName\"] */", nil),
                                    [self i_Ps:0 index:3] : NSLocalizedString(@"/* [Appodeal disableNetworkForAdType:AppodealAdTypeRewardedVideo name:@\"networkName\"] */", nil),
                                    [self i_Ps:0 index:4] : NSLocalizedString(@"/* [Appodeal disableNetworkForAdType:AppodealAdTypeNativeAd name:@\"networkName\"] */", nil),
                                    [self i_Ps:0 index:5] : NSLocalizedString(@"/* [Appodeal disableNetworkForAdType:AppodealAdTypeMREC name:@\"networkName\"] */", nil)};
        
        _cellDescriptionName = [[NSMutableDictionary alloc] initWithDictionary:cellName];
    }
    return nil;
}

- (NSMutableDictionary *) cellHeaderName{
    if (!_cellHeaderName) {
        NSDictionary * cellName = @{@0 : NSLocalizedString(@"ad modules", nil),
                                    @1 : NSLocalizedString(@"advanced", nil),
                                    @2 : NSLocalizedString(@"debug", nil)};
        
        _cellHeaderName = [[NSMutableDictionary alloc] initWithDictionary:cellName];
    }
    return _cellHeaderName;
}

- (NSIndexPath *) i_Ps:(NSUInteger)section index:(NSInteger)index{
    return [NSIndexPath indexPathForRow:index inSection:section];
}

- (NSMutableDictionary *)enabledModules{
    if (!_enableModules) {
        _enableModules = [NSMutableDictionary dictionary];
        NSUInteger index = 0;
        for (id obj in _adModules) {
            _enableModules[[self i_Ps:0 index:index]] = obj;
            index++;
        }
    }
    return _enableModules;
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
    if (![sender isKindOfClass:[UISwitch class]]) {
        return;
    }
    
    NSIndexPath * indexPath = [self indexPathFromTag:[(UISwitch *)sender tag]];
    
    switch (indexPath.section) {
        case 0:
        {
            if ([_adModules count] > indexPath.row) {
                _enableModules[indexPath] = [(UISwitch *)sender isOn] ? _adModules[indexPath.row] : nil;
            }
        } break;
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    _locationPermition = [(UISwitch *) sender isOn];
                } break;
                case 1:
                {
                    _autoCache = [(UISwitch *) sender isOn];
                } break;
                case 2:
                {
                    _userData = [(UISwitch *) sender isOn];
                } break;
            }
        } break;
        case 2:
        {
            switch (indexPath.row) {
                case 0:
                {
                    _testMode = [(UISwitch *) sender isOn];
                } break;
                case 1:
                {
                    _debugMode = [(UISwitch *) sender isOn];
                } break;
                case 2:
                {
                    _toastMode = [(UISwitch *) sender isOn];
                } break;
            }
        } break;
    }
}

#pragma mark --- TABLE_VIEW_DELEGATE

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? [_enableModules count] : section == 1 ? 3 : section == 2 ? 3 : 1;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (!_cellHeaderName[@(section)]) {
        return nil;
    }
    
    return [_legacyInitializeView headerView:[_cellHeaderName[@(section)] uppercaseString]
                                   tintColor:UIColor.blackColor
                                    fontSize:12
                             backgroundColor:[UIColor colorWithWhite:0.95 alpha:1]];

}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * cellName = NSStringFromClass([self class]);
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellName];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (_cellDictName[indexPath]) {
        NSDictionary *attributes = @{NSForegroundColorAttributeName: UIColor.blackColor,
                                     NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:16],
                                     NSKernAttributeName: @(1.2)};
        cell.textLabel.attributedText = [[NSAttributedString alloc] initWithString:_cellDictName[indexPath] attributes:attributes];
    }
    
    if (_cellDescriptionName[indexPath]) {
        NSDictionary *attributes = @{NSForegroundColorAttributeName: UIColor.lightGrayColor,
                                     NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Light" size:12],
                                     NSKernAttributeName: @(1.0)};
        cell.detailTextLabel.attributedText = [[NSAttributedString alloc] initWithString:_cellDescriptionName[indexPath] attributes:attributes];
    }
    
    switch (indexPath.section) {
        case 0:
        {
            cell.accessoryView = [self switchWithIndexPath:indexPath andCheck:_enableModules[indexPath] ? YES : NO];
        } break;
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    cell.accessoryView = [self switchWithIndexPath:indexPath andCheck:_locationPermition];
                }break;
                case 1:
                {
                    cell.accessoryView = [self switchWithIndexPath:indexPath andCheck:_autoCache];
                }break;
                case 2:
                {
                    cell.accessoryView = [self switchWithIndexPath:indexPath andCheck:_userData];
                }break;
            }
        } break;
        case 2:
        {
            switch (indexPath.row) {
                case 0:
                {
                    cell.accessoryView = [self switchWithIndexPath:indexPath andCheck:_testMode];
                }break;
                case 1:
                {
                    cell.accessoryView = [self switchWithIndexPath:indexPath andCheck:_debugMode];
                }break;
                case 2:
                {
                    cell.accessoryView = [self switchWithIndexPath:indexPath andCheck:_toastMode];
                }break;
            }

        } break;
        case 3:
        {
            switch (indexPath.row) {
                case 0:
                {
                    NSDictionary *attributes = @{NSForegroundColorAttributeName: UIColor.redColor,
                                                 NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Bold" size:16],
                                                 NSKernAttributeName: @(2)};
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    cell.textLabel.attributedText = [[NSAttributedString alloc] initWithString:_cellDictName[indexPath] attributes:attributes];
                    cell.textLabel.textAlignment = NSTextAlignmentCenter;
                    
                    [cell.textLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(cell.contentView).with.offset(10);
                        make.bottom.equalTo(cell.contentView).with.offset(-10);
                        make.center.equalTo(cell.contentView);
                    }];
                }break;
            }
            
        } break;
    }
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 3) {
        if (![_enableModules count]) {
            return;
        }
        NSInteger bitMask = 0;
        for (NSNumber * module in [_enableModules allValues]) {
            bitMask = bitMask + [module integerValue];
        }
        [((AppDelegate *)[[UIApplication sharedApplication] delegate]) initializeSdk:bitMask
                                                                            testMode:_testMode
                                                                           debugMode:_debugMode
                                                                    locationTracking:_locationPermition
                                                                           autoCache:_autoCache
                                                                            userData:_userData
                                                                               toast:_toastMode];
    }
}

@end
