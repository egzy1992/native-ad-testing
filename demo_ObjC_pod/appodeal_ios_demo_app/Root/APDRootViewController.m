//
//  APDRootViewController.m
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 6/10/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDRootViewController.h"
#import "Masonry.h"
//#import "APDCollectionViewPlacer.h"
//#import "APDTableViewAdPlacer.h"

static BOOL deprecated = NO;

@interface APDRootViewController () <APDBannerViewDelegate>

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
    //UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    [self.view updateConstraints];
/*    for (id subview in self.view.subviews) {
        if ([subview isKindOfClass:[UICollectionView class]]) {
            [(UICollectionView *)subview apd_reloadData];
        }
        if ([subview isKindOfClass:[UITableView class]]) {
            [(UITableView *)subview apd_reloadData];
        }
    } */
}

- (BOOL) prefersStatusBarHidden{
    return YES;
}

- (CAGradientLayer *) gradientWithFrame:(CGRect)frame{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = GRADIENT ? [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:0.5] : UIColor.whiteColor;
    
    gradient.frame = frame;
    gradient.colors = [NSArray arrayWithObjects:
                       (id)[color CGColor],
                       (id)[[UIColor whiteColor] CGColor],
                       nil];
    return gradient;
}

-(void) apdBannerViewOnBottom {
    if (self.isDeprecateApi) {
        [Appodeal showAd:AppodealShowStyleBannerBottom rootViewController:self];
        return;
    }
    self.bannerView = [[APDBannerView alloc] initWithSize:IS_IPAD? kAPDAdSize728x90:kAPDAdSize320x50];
    self.bannerView.delegate = self;
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
