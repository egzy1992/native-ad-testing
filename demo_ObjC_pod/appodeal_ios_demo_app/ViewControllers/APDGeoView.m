//
//  APDGeoView.m
//  AppodealApp
//
//  Created by Lozhkin Ilya on 5/23/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "APDGeoView.h"

@interface APDGeoView ()<CLLocationManagerDelegate, MKMapViewDelegate>
{
    CLLocationManager * _locationManager;
    CLLocationCoordinate2D _pointA;
    CLLocationCoordinate2D _pointB;
}

@property (nonatomic, strong) UIButton * routeButton;

@end

@implementation APDGeoView

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        [_locationManager requestLocation];
        
        if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
            [_locationManager requestAlwaysAuthorization];
        }

        {
            [self addSubview:self.mapView];
            [self addSubview:self.routeButton];
        }
    }
    return self;
}

- (void) updateConstraints {
    
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.routeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@100);
        make.height.equalTo(@50);
        make.top.equalTo(@75);
        make.right.equalTo(@(-10));
    }];
    
    [super updateConstraints];
}

#pragma mark --- PROPERTY

- (MKMapView *)mapView{
    if (!_mapView) {
        _mapView = [[MKMapView alloc] initWithFrame:self.bounds];
        _mapView.showsUserLocation = YES;
        _mapView.delegate = self;
        
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mapOnClick:)];
        [_mapView addGestureRecognizer:tapGesture];
    }
    return _mapView;
}

- (UIButton *) routeButton {
    if (!_routeButton) {
        _routeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _routeButton.layer.cornerRadius = 5.0;
        _routeButton.clipsToBounds = YES;
        [_routeButton setTitle:[NSLocalizedString(@"route", nil) uppercaseString] forState:UIControlStateNormal];
        _routeButton.backgroundColor = UIColor.redColor;
        
        [_routeButton addTarget:self action:@selector(routeClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _routeButton;
}

#pragma mark --- PUBLIC

- (void) scrollToCenter {
    [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(self.mapView.userLocation.location.coordinate, 500, 500) animated:YES];
}

#pragma mark --- PRIVATE

- (void) makeMapDirections{
    
    if ([self.mapView.overlays count] > 0) {
        [self.mapView removeOverlays:self.mapView.overlays];
    }
    
    MKDirectionsRequest * directionsRequest = [MKDirectionsRequest new];
    
    MKPlacemark *startPlacemark = [[MKPlacemark alloc] initWithCoordinate:_pointA addressDictionary:nil];
    MKMapItem *start = [[MKMapItem alloc] initWithPlacemark:startPlacemark];
    
    MKPlacemark *destinationPlacemark = [[MKPlacemark alloc] initWithCoordinate:_pointB addressDictionary:nil];
    MKMapItem *destination = [[MKMapItem alloc] initWithPlacemark:destinationPlacemark];
    
    // Set the source and destination on the request
    [directionsRequest setSource:start];
    [directionsRequest setDestination:destination];
    
    MKDirections * directions = [[MKDirections alloc] initWithRequest:directionsRequest];
    
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        if (error) {
            NSLog(@"There was an error getting your directions");
            return;
        }
        
        MKRoute * currentRoute = [response.routes firstObject];
        [self plotRouteOnMap:currentRoute];
    }];
}

- (void)plotRouteOnMap:(MKRoute *)route
{
    MKPolyline * routeOverlay = route.polyline;
    
    [self.mapView addOverlay:routeOverlay];
}

#pragma mark --- ACTIONS

- (IBAction)mapOnClick:(UIGestureRecognizer *)sender{
    CGPoint touchPoint = [sender locationInView:self.mapView];
    CLLocationCoordinate2D touchMapCoordinate = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
    
    if ([self.mapView.annotations count] > 1) {
        for (id annotation in self.mapView.annotations) {
            if ([annotation isKindOfClass:[MKPointAnnotation class]]) {
                [self.mapView removeAnnotation:annotation];
            }
        }
    }
    
    MKPointAnnotation * anotation = [MKPointAnnotation new];
    anotation.coordinate = touchMapCoordinate;
    [self.mapView addAnnotation:anotation];
    
    _pointB = touchMapCoordinate;
}

-(IBAction)routeClick:(id)sender{
    [self makeMapDirections];
}

#pragma mark --- MAP_VIEW_DELEGATE

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    self.mapView.centerCoordinate = userLocation.location.coordinate;
    _pointA = userLocation.location.coordinate;
}

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithPolyline:(MKPolyline *)overlay];
    renderer.strokeColor = UIColor.redColor;
    renderer.lineWidth = 4.0;
    return  renderer;
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    return nil;
}

#pragma mark --- CL_LOCATION_MANAGER_DELEGATE

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorizedAlways) {
        [_locationManager startUpdatingLocation];
        [self scrollToCenter];
    } else if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [_locationManager startUpdatingLocation];
        [self scrollToCenter];
    } else if (status == kCLAuthorizationStatusDenied) {
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    
}

@end
