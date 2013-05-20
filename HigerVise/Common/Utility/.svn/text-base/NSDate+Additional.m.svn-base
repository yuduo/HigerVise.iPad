//
//  NSDate+Additional.m
//  Locoso
//
//  Created by zhiwei ma on 12-3-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NSDate+Additional.h"

@implementation NSDate (Additional)

- (NSString*)stringWithSecondAccuracy
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:self];
    [dateFormatter release];
    return strDate;
}

- (NSString*)stringWithMinuteAccuracy
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *strDate = [dateFormatter stringFromDate:self];
    [dateFormatter release];
    return strDate;
}
@end
