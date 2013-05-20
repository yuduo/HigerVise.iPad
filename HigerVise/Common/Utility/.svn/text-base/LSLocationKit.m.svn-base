//
//  LSLocationKit.m
//  Locoso
//
//  Created by zhiwei ma on 12-3-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LSLocationKit.h"

static LSLocationKit* sLocationKitInstance = nil;

@implementation LSLocationKit
@synthesize kitDelegate = _kitDelegate;
//@synthesize autoUpdatePeriod = _autoUpdatePeriod;
@synthesize state = _state;
@synthesize updatePolicy = _updatePolicy;
@synthesize lastLocation = _lastLocation;
@synthesize lastPlacemark = _lastPlacemark;

+ (LSLocationKit*)sharedInstance
{
    if (!sLocationKitInstance) 
    {
		@synchronized(self) 
        {
			if (!sLocationKitInstance) 
            {
                sLocationKitInstance = [[self alloc] init];
			}
		}
	}
	return sLocationKitInstance;
}

- (void)dealloc
{
    [self stopUpdatingLocation];
    [_reverseGeocoder cancel];
    [_reverseGeocoder release];
    self.lastLocation = nil;
    self.lastPlacemark = nil;
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self.delegate = self;
        self.distanceFilter = 1000;
        self.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        _updatePolicy = LSLocationUpdateOneStop;
    }
    return self;
}

- (void)startUpdatingLocation
{
    NSLog(@"%s",__FUNCTION__);
    if (LSLocationKitStateUpdateing == _state)
    {
        NSLog(@"LSLocationKitStateUpdateing == _state %@",@"");
        return;
    }
    
    _state = LSLocationKitStateUpdateing;
    self.lastLocation = nil;
    self.lastPlacemark = nil;
    [super startUpdatingLocation];
}

- (void)stopUpdatingLocation
{
//    if (LSLocationKitStateUpdateing != _state)
//    {
//        return;
//    }
    
    if (LSLocationUpdateOneStop == _updatePolicy)
    {
        [_reverseGeocoder cancel];
    }
    _state = LSLocationKitStatePending;
    [super stopUpdatingLocation];
}

- (void)startReverseGeocoderLocation:(CLLocationCoordinate2D)coordinate
{
    NSLog(@"%s",__FUNCTION__);
    if (_reverseGeocoder)
    {
        if ([_reverseGeocoder isQuerying])
        {
            [_reverseGeocoder cancel];
        }
        [_reverseGeocoder release];
        _reverseGeocoder = nil;
    }
    
    _state = LSLocationKitStateUpdateing;
    _reverseGeocoder = [[MKReverseGeocoder alloc] initWithCoordinate:coordinate];
    _reverseGeocoder.delegate = self;
    [_reverseGeocoder start];
}

- (void)stopReverseGeocoderLocation
{
    _state = LSLocationKitStatePending;
    [_reverseGeocoder cancel];
}

#pragma mark CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"update location success. %@", [newLocation description]);
    self.lastLocation = newLocation;
    if (LSLocationUpdateSingleStep == _updatePolicy)
    {
        _state = LSLocationKitStateUpdateSuccess;
        if ([(NSObject*)_kitDelegate respondsToSelector:@selector(didLocationUpdateSuccess:)]) 
        {
            [_kitDelegate didLocationUpdateSuccess:self];
        }
    }
    else //LSLocationUpdateOneStop
    {
        [self startReverseGeocoderLocation:newLocation.coordinate];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"update location failed,%@",error);
    _state = LSLocationKitStateUpdateFailed;
    self.lastLocation = nil;
    self.lastPlacemark = nil;
    
    if (LSLocationUpdateSingleStep == _updatePolicy)
    {
        if ([(NSObject*)_kitDelegate respondsToSelector:@selector(didLocationUpdateFailed:)])
        {
            [_kitDelegate didLocationUpdateFailed:self];
        }
    }
    else //LSLocationUpdateOneStop
    {
        if ([(NSObject*)_kitDelegate respondsToSelector:@selector(didReverseGeocoderFailed:)])
        {
            [_kitDelegate didReverseGeocoderFailed:self];
        }
    }
}

#pragma mark MKReverseGeocoderDelegate
- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark
{
    NSLog(@"reverseGeocoder success %@",placemark.locality);
    self.lastPlacemark = placemark;
    _state = LSLocationKitStateUpdateSuccess;
    if ([(NSObject*)_kitDelegate respondsToSelector:@selector(didReverseGeocoderSuccess:)])
    {
        [_kitDelegate didReverseGeocoderSuccess:self];
    }
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error
{
    NSLog(@"reverseGeocoder faild.%@",error);
    _state = LSLocationKitStateUpdateFailed;
    self.lastPlacemark = nil;
    if ([(NSObject*)_kitDelegate respondsToSelector:@selector(didReverseGeocoderFailed:)])
    {
        [_kitDelegate didReverseGeocoderFailed:self];
    }
}
@end
