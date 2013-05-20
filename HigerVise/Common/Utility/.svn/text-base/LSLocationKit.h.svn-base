//
//  LSLocationKit.h
//  Locoso
//
//  Created by zhiwei ma on 12-3-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@class LSLocationKit;

//
//RJLocationKitDelegate
//
@protocol LSLocationKitDelegate
@optional
- (void)didLocationUpdateSuccess:(LSLocationKit*)aLocationKit;
- (void)didLocationUpdateFailed:(LSLocationKit*)aLocationKit;
- (void)didReverseGeocoderSuccess:(LSLocationKit*)aLocationKit;
- (void)didReverseGeocoderFailed:(LSLocationKit*)aLocationKit;
@end

//
//RJLocationKit
//
typedef enum 
{
    LSLocationKitStatePending,
    LSLocationKitStateUpdateing,
    LSLocationKitStateUpdateSuccess,
    LSLocationKitStateUpdateFailed
}LSLocationKitState;

typedef enum
{
    LSLocationUpdateOneStop,// location更新成功时不进行代理回调，等placemark更新结束才进行回调
    LSLocationUpdateSingleStep//location和placemark分两步更新，更新后分别进行代理回调
}LSLocationUpdatePolicy;

@interface LSLocationKit : CLLocationManager
<CLLocationManagerDelegate,MKReverseGeocoderDelegate>
{
    id<LSLocationKitDelegate> _kitDelegate;
    MKReverseGeocoder* _reverseGeocoder;
    
    LSLocationUpdatePolicy _updatePolicy;
//    NSTimeInterval _autoUpdatePeriod;
    
    LSLocationKitState _state;
    CLLocation* _lastLocation;
    MKPlacemark* _lastPlacemark;
}
@property (nonatomic, assign) id<LSLocationKitDelegate> kitDelegate;
//@property (nonatomic) NSTimeInterval autoUpdatePeriod;//默认为0,设置为0表示不自动更新位置.未实现此功能
@property (nonatomic) LSLocationUpdatePolicy updatePolicy;//默认为LSLocationUpdateOneStop

@property (nonatomic) LSLocationKitState state;
@property (nonatomic, retain) CLLocation* lastLocation;
@property (nonatomic, retain) MKPlacemark* lastPlacemark;

+ (LSLocationKit*)sharedInstance;
- (void)startReverseGeocoderLocation:(CLLocationCoordinate2D)coordinate;
- (void)stopReverseGeocoderLocation;
@end
