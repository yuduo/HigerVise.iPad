//
//  JsonResturnCheck.m
//  Locoso
//
//  Created by yongchang hu on 12-2-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "JsonResturnCheck.h"

@implementation JsonResturnCheck
+(BOOL)JsonResturnCheck:(NSDictionary*)data
{
    if ([data count] == 3) {
        if ([data isKindOfClass:[NSDictionary class]]) {
            NSString *re = [data objectForKey:@"success"];
            if ( [re isEqualToString:@"false"]) {
                return true;
            }
        }
        
    }
    return false;
}
@end
