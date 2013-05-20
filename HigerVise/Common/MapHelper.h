//
//  MapHelper.h
//  Locoso
//
//  Created by yongchang hu on 12-3-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapHelper : NSObject
+ (CLLocationCoordinate2D)getPostion:(NSString *)address;
@end
