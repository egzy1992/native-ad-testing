//
//  APDGeoView.h
//  AppodealApp
//
//  Created by Lozhkin Ilya on 5/23/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDRootView.h"
#import <MapKit/MapKit.h>

@interface APDGeoView : APDRootView

@property (nonatomic, strong) MKMapView * mapView;

- (void) scrollToCenter;

@end
