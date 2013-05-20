//
//  MapHelper.m
//  Locoso
//
//  Created by yongchang hu on 12-3-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MapHelper.h"
#import "NSObject+SBJson.h"


@implementation MapHelper

+ (CLLocationCoordinate2D)getPostion:(NSString *)address
{
    NSString *googleURL = [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?address=%@&sensor=true",
                           [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    CLLocationCoordinate2D position;
    position.latitude = 0.0;
    position.longitude = 0.0;
    
    NSError *error;
    NSString *retstr = [NSString stringWithContentsOfURL:[NSURL URLWithString:googleURL] encoding:NSUTF8StringEncoding error:&error];
    if (retstr)
    {
        //        NSLog(@"retstr: %@", retstr);
        NSDictionary *dict = [retstr JSONValue];
        if (dict)
        {
            NSArray *results = [dict objectForKey:@"results"];
            if (results && results.count > 0)
            {
                NSDictionary *geometry = [[results objectAtIndex:0] objectForKey:@"geometry"];
                NSDictionary *location = [geometry objectForKey:@"location"];
                position.latitude = [[location objectForKey:@"lat"] doubleValue];
                position.longitude = [[location objectForKey:@"lng"] doubleValue];                
            }
        }
    }
    else
    {
        NSLog(@"error: %@", error);
    }
    
    return position;
}

@end

