//
//  CheckAndShowMessage.h
//  Locoso
//
//  Created by yongchang hu on 12-2-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckAndShowMessage : NSObject
+(BOOL)checkNullAndShowMsg:(NSString*)content msg:(NSString*)msg;
@end
