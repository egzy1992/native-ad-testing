//
//  APDRootViewController.m
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 6/10/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDRootViewController.h"
#import "Masonry.h"

static BOOL deprecated = NO;

@interface APDRootViewController ()

@property (nonatomic, strong) APDBannerView * bannerView;

@end

@implementation APDRootViewController

-(void) viewDidLoad {
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    
    UILabel *titleLabel = [UILabel new];
    NSDictionary *attributes = @{NSForegroundColorAttributeName: [UINavigationBar appearance].tintColor,
                                 NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0],
                                 NSKernAttributeName: @2};
    
    if (self.navigationItem.title) {
        titleLabel.attributedText = [[NSAttributedString alloc] initWithString:self.navigationItem.title attributes:attributes];
        [titleLabel sizeToFit];
        
        self.navigationItem.titleView = titleLabel;
    }
    {
        [[NSNotificationCenter defaultCenter] addObserver:self // put here the view controller which has to be notified
                                                 selector:@selector(orientationChanged:)
                                                     name:@"UIDeviceOrientationDidChangeNotification"
                                                   object:nil];
    }
}

- (BOOL)isDeprecateApi {
    return deprecated;
}

- (void)wasInitializedLikeDeprecated {
    deprecated = YES;
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (self.isDeprecateApi) {
        [Appodeal hideBanner];
    }
    [super viewWillDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.view updateConstraints];
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)orientationChanged:(NSNotification *)notification{
    [self.view updateConstraints];
}

- (BOOL) prefersStatusBarHidden{
    return YES;
}

-(void) apdBannerViewOnBottom {
    if (self.isDeprecateApi) {
        [Appodeal showAd:AppodealShowStyleBannerBottom rootViewController:self];
        return;
    }
    self.bannerView = [[APDBannerView alloc] initWithSize:IS_IPAD? kAPDAdSize728x90:kAPDAdSize320x50];
//    self.bannerView.delegate = self;
    self.bannerView.rootViewController = self;
    [self.bannerView loadAd];
    [self.view addSubview:self.bannerView];
    
    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).with.offset(-40);
        make.size.mas_equalTo(self.bannerView.frame.size);
    }];
}

@end
