//
//  NSDate+Additional.h
//  Locoso
//
//  Created by yongchang hu on 12-3-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Additional)

/*
 * yyyy-MM-dd HH:mm:ss
 */
- (NSString*)stringWithSecondAccuracy;
- (NSString*)stringWithMinuteAccuracy;
@end
