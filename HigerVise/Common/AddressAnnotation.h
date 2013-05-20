//
//  AddressAnnotation.h
//  FamilyGPSLink
//
//  Created by hu yongchang on 6/11/10.
//  Copyright 2010 usa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface AddressAnnotation : NSObject<MKAnnotation> {
	CLLocationCoordinate2D coordinate;
}

@end
