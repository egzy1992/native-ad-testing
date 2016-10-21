//
//  APDNativeShowStyleView.h
//  appodeal_ios_demo_app
//
//  Created by Lozhkin Ilya on 6/14/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDRootView.h"

@interface APDNativeShowStyleView : APDRootView

@property (nonatomic, strong) UISegmentedControl * segmentControl;
@property (nonatomic, strong) UISegmentedControl * helperSegmentedControl;
@property (nonatomic, strong) UISegmentedControl * apdTypeSegmentedControl;

@property (nonatomic, strong) UIButton * contentFeed;
@property (nonatomic, strong) UIButton * contentStream;
@property (nonatomic, strong) UIButton * collectionContent;
@property (nonatomic, strong) UIButton * bannerConent;

@property (nonatomic, strong) UIButton * customContent;
@property (nonatomic, strong) UISlider * capacitySlider;

@property (nonatomic, strong) UIButton * collectionHelperContent;
@property (nonatomic, strong) UIButton * tableHelperContent;

@end
