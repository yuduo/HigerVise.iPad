//
//  CheckAndShowMessage.m
//  Locoso
//
//  Created by yongchang hu on 12-2-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CheckAndShowMessage.h"

@implementation CheckAndShowMessage
+(BOOL)checkNullAndShowMsg:(NSString*)content msg:(NSString*)msg
{
    if ([content isEqualToString:@""] || content == nil) {
        
        return true;
    }
    return  false;
}
@end
