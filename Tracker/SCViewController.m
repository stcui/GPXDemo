//
//  SCViewController.m
//  Tracker
//
//  Created by cui on 13-4-18.
//  Copyright (c) 2013年 cui. All rights reserved.
//

#import "SCViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface SCViewController () <CLLocationManagerDelegate>
{
    CLLocationManager *_locationManager;
}
@end

@implementation SCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    [_locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation
{
    MKPlacemark *annotation = [[self.mapView annotations] lastObject];
    if (annotation) {
        [self.mapView removeAnnotation:annotation];
    } else {
        [self.mapView setRegion:MKCoordinateRegionMake(newLocation.coordinate, MKCoordinateSpanMake(0.1, 0.1))];
    }
    annotation = [[MKPlacemark alloc] initWithCoordinate:newLocation.coordinate addressDictionary:nil];
    [self.mapView addAnnotation:annotation];
    [self.mapView setCenterCoordinate:annotation.coordinate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
