//
//  APDNativeShowStyleViewController.m
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 6/14/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDNativeShowStyleViewController.h"
#import "APDNativeShowStyleView.h"
#import "APDCustomContentViewController.h"

#import "RSSStream.h"

@interface APDNativeShowStyleViewController ()<RSSStreamDelegate>
{
    APDNativeShowStyleView * _nativeShowStyle;
    RSSStream * _rssStream;
    NSArray * _contentArray;
}
@end

@implementation APDNativeShowStyleViewController

- (void) viewDidLoad {
    
    {
        self.navigationItem.title = [NSLocalizedString(@"native show context", nil) uppercaseString];
    }
    
    [super viewDidLoad];
    
    {
        _nativeShowStyle = [[APDNativeShowStyleView alloc] initWithFrame:self.view.frame];
        self.view = _nativeShowStyle;
    }
    
    {
        // without helper unused version
        [_nativeShowStyle.contentFeed addTarget:self action:@selector(contentFeedClick:) forControlEvents:UIControlEventTouchUpInside];
        [_nativeShowStyle.contentStream addTarget:self action:@selector(contentStreamClick:) forControlEvents:UIControlEventTouchUpInside];
        [_nativeShowStyle.collectionContent addTarget:self action:@selector(collectionContentClick:) forControlEvents:UIControlEventTouchUpInside];
        [_nativeShowStyle.bannerConent addTarget:self action:@selector(bannerContentClick:) forControlEvents:UIControlEventTouchUpInside];
        
        // without helper
        
        [_nativeShowStyle.customContent addTarget:self action:@selector(customContentClick:) forControlEvents:UIControlEventTouchUpInside];
        
        // with helper
//        [_nativeShowStyle.collectionHelperContent addTarget:self action:@selector(collectionHelperClick:) forControlEvents:UIControlEventTouchUpInside];
//        [_nativeShowStyle.tableHelperContent addTarget:self action:@selector(tableHelperClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark --- ACTIONS WITHOUT HELPER UNUSED VERSION

- (IBAction)contentFeedClick:(id)sender{
    APDContentFeedViewController * nextController = [APDContentFeedViewController new];
    nextController.toastMode = self.toastMode;
    nextController.nativeType = _nativeShowStyle.segmentControl.selectedSegmentIndex;
    [self.navigationController pushViewController:nextController animated:YES];
}

- (IBAction)contentStreamClick:(id)sender{
    APDContentStreamViewController * nextController = [APDContentStreamViewController new];
    nextController.toastMode = self.toastMode;
    nextController.nativeType = _nativeShowStyle.segmentControl.selectedSegmentIndex;
    [self.navigationController pushViewController:nextController animated:YES];
}

- (IBAction)collectionContentClick:(id)sender{
    APDCollectionContentViewController * nextController = [APDCollectionContentViewController new];
    nextController.toastMode = self.toastMode;
    nextController.nativeType = _nativeShowStyle.segmentControl.selectedSegmentIndex;
    [self.navigationController pushViewController:nextController animated:YES];
}

- (IBAction)bannerContentClick:(id)sender{
    APDBannerContentViewController * nextController = [APDBannerContentViewController new];
    nextController.toastMode = self.toastMode;
    nextController.nativeType = _nativeShowStyle.segmentControl.selectedSegmentIndex;
    [self.navigationController pushViewController:nextController animated:YES];
}

#pragma mark --- ACTIONS WITHOUT HELPER

- (IBAction)customContentClick:(id)sender{
    APDCustomContentViewController * nextController = [APDCustomContentViewController new];
    nextController.capacityCount = roundl(_nativeShowStyle.capacitySlider.value);
    nextController.toastMode = self.toastMode;
    nextController.nativeType = _nativeShowStyle.segmentControl.selectedSegmentIndex;
    [self.navigationController pushViewController:nextController animated:YES];
}

@end
