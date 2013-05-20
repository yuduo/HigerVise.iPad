//
//  LSString.h
//  Locoso
//
//  Created by yongchang hu on 12-3-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LSImageURLFilter_Cell           @"2"
#define LSImageURLFilter_image          @"4"
#define LSImageURLFilter_Original        @"1"

@interface NSString (LSURLString)
- (NSString*)stringByHandleImageURL;//LSImageURLFilter_Cell
- (NSString*)stringByHandleImageURLOriginal;//LSImageURLFilter_Original
- (NSString*)stringByHandleImageURL:(NSString*)aFilter;
@end
