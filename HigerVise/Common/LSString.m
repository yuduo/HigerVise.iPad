//
//  LSString.m
//  Locoso
//
//  Created by yongchang hu on 12-3-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LSString.h"

@implementation NSString (LSURLString)
- (NSString*)stringByHandleImageURL
{
    return [self stringByHandleImageURL:LSImageURLFilter_Cell];
}

- (NSString*)stringByHandleImageURLOriginal
{
    return [self stringByHandleImageURL:LSImageURLFilter_Original];
}

- (NSString*)stringByHandleImageURL:(NSString*)aFilter
{
    return [self stringByReplacingOccurrencesOfString:@"{0}" withString:aFilter];
}
@end
