//
//  APDDisableNetworkViewController.m
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 11/18/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDDisableNetworkViewController.h"
#import "APDInitilizeViewController.h"
#import "AppDelegate.h"
#import "Masonry.h"

@interface APDDisableNetworkViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSArray <NetworkProperty *> * networks;
@property (nonatomic, strong) NSMapTable <NSNumber *, NetworkProperty *> * mapOfNetworkValue;
@property (nonatomic, assign) BOOL disabledAll;

@end

@implementation APDDisableNetworkViewController

- (void)viewDidLoad {
    {
        self.navigationItem.title = [NSLocalizedString(@"disable ad network", nil) uppercaseString];
        self.view.backgroundColor = UIColor.whiteColor;
    }
    
    {
        self.mapOfNetworkValue = [[NSMapTable alloc] init];
        self.networks = [self networPropConfig];
        self.disabledAll = NO;
    }
    
    [super viewDidLoad];
    
    [self updateViewConstraints];
}

#pragma mark --- CONSTRAIN

- (void) updateViewConstraints{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [super updateViewConstraints];
}

#pragma mark --- PROPERY

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

- (NSArray *)networPropConfig {
    NSArray * propArray =      @[@{@"None" : @""},
                                 @{@"AdColony" : @"adcolony"},
                                 @{@"Google" : @"admob"},
                                 @{@"Amazon" : @"amazon_ads"},
                                 @{@"Applovin" : @"applovin"},
                                 @{@"Avocarrot" : @"avocarrot"},
                                 @{@"Chartboost" : @"chartboost"},
                                 @{@"Facebook" : @"facebook"},
                                 @{@"Flurry" : @"flurry"},
                                 @{@"Inmobi" : @"inmobi"},
                                 @{@"InnerActive" : @"inner-active"},
                                 @{@"InnerActiveSDK" : @"inneractive_sdk"},
                                 @{@"Twitter" : @"mopub"},
                                 @{@"OpenX" : @"openx"},
                                 @{@"OpenXSDK" : @"openx_sdk"},
                                 @{@"Pubnative" : @"pubnative"},
                                 @{@"Smaato" : @"smaato"},
                                 @{@"SmaatoSDK" : @"smaato_sdk"},
                                 @{@"SpotX" : @"spotx"},
                                 @{@"StartApp" : @"startapp"},
                                 @{@"Mail.ru" : @"mailru"},
                                 @{@"Tapjoy" : @"tapjoy"},
                                 @{@"Tapsense" : @"tapsense"},
                                 @{@"Unity" : @"unity_ads"},
                                 @{@"Vungle" : @"vungle"},
                                 @{@"Yandex" : @"yandex"},
                                 @{@"Zplay" : @"zplay"},
                                 @{@"Appodeal" : @"appodeal"},
                                 @{@"Mraid" : @"mraid"},
                                 @{@"MraidDFP" : @"mraid_dfp"},
                                 @{@"Vast" : @"vast"}];
    
    NSMutableArray * array = [NSMutableArray array];
    for (NSDictionary * oneProp in propArray) {
        NSString * prettyName = [[oneProp allKeys] firstObject];
        NetworkProperty * property = [[NetworkProperty alloc] initWithName:prettyName name:oneProp[prettyName]];
        [array addObject:property];
        
        [self.mapOfNetworkValue setObject:property forKey:@([array indexOfObject:property])];
    }
    
    return array;
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
    NSInteger tag = indexPath.section * 1000 + indexPath.row;
    return tag;
}

-(NSIndexPath *)indexPathFromTag:(NSInteger)tag{
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:(tag % 1000) inSection:(tag / 1000)];
    return indexPath;
}

#pragma mark --- SWITCH_SELECTED

- (IBAction)swithChanged:(id)sender{
    NSIndexPath * indexPath = [self indexPathFromTag:[(UISwitch *)sender tag]];
    BOOL flag = [(UISwitch *)sender isOn];
    
    switch (indexPath.section) {
        case 0: [self selectedSwich:flag]; break;
        case 1: {
            NetworkProperty * property = [self.mapOfNetworkValue objectForKey:@(indexPath.row)];
            [property setChecked:flag];
            [self.mapOfNetworkValue setObject:property forKey:@(indexPath.row)];
        }break;
        case 2: break;
    }
}

#pragma mark --- TableView - Data - Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? 1 : section == 1 ? [self.networks count] : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * cellName = @"cell";
    NSString * continueName = @"continue";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName forIndexPath:indexPath];
    if (indexPath.section == 2) {
        cell = [tableView dequeueReusableCellWithIdentifier:continueName forIndexPath:indexPath];
    }
    
    BOOL flag = indexPath.section == 0 ? self.disabledAll : indexPath.section == 1 ? [self.mapOfNetworkValue objectForKey:@(indexPath.row)].isChecked : NO;
    NSString * text =  indexPath.section == 0 ? @"disable all" : indexPath.section == 1 ? [self.networks[indexPath.row] networkPrettyName] : @"continue";
    
    NSDictionary *attributesMainText = @{NSForegroundColorAttributeName: UIColor.blackColor,
                                         NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:16],
                                         NSKernAttributeName: @(1.2)};
    
    cell.textLabel.attributedText = [[NSAttributedString alloc] initWithString:text attributes:attributesMainText];
    if (indexPath.section != 2) {
        cell.accessoryView = [self switchWithIndexPath:indexPath andCheck:flag];
    } else {
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        [self segueToNextController];
    }
}

#pragma mark -- Support

- (void) selectedSwich:(BOOL)flag{
    self.disabledAll = flag;
    
    NSMapTable * tempMap = [self.mapOfNetworkValue mutableCopy];
    for (NSNumber * index in tempMap) {
        NetworkProperty * property = [tempMap objectForKey:index];
        [property setChecked:flag];
        [self.mapOfNetworkValue setObject:property forKey:index];
    }
    
    [self.tableView reloadData];
}

- (NSArray *) disabledNetwork:(NSMapTable *)mapOfNetworks {
    NSMutableArray * array = [NSMutableArray new];
    for (NSNumber * index in mapOfNetworks) {
        NetworkProperty * property = [mapOfNetworks objectForKey:index];
        if (property.isChecked) {
            [array addObject:property];
        }
    }
    return [array count] ? array : nil;
}

- (void)segueToNextController {
    
    NSArray * disabledNetwork =  [self disabledNetwork:self.mapOfNetworkValue];
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] setDisabledAdNetwork: disabledNetwork];
    
    APDInitilizeViewController * nextController = [APDInitilizeViewController new];
    nextController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    nextController.newApi = self.newApi;
    [self.navigationController pushViewController:nextController animated:YES];

}

@end

