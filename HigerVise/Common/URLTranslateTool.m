//
//  URLTranslateTool.m
//  Locoso
//
//  Created by yongchang hu on 12-1-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "URLTranslateTool.h"

@implementation URLTranslateTool
+(NSString*)OldUrlTranslateTo:(NSString*)oldUrl idd:(NSString*)idd{
    return [oldUrl stringByReplacingOccurrencesOfString:@"{0}" withString:idd];
}
@end
