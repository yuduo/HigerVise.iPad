//
//  NSDictionaryTool.m
//  Locoso
//
//  Created by yongchang hu on 12-2-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NSDictionaryTool.h"

@implementation NSDictionary (Helpers)

+ (NSDictionary *)dictionaryWithContentsOfData:(NSData *)data {
    CFPropertyListRef plist =  CFPropertyListCreateFromXMLData(kCFAllocatorDefault, (CFDataRef)data,
                                                               kCFPropertyListImmutable,
                                                               NULL);
    if(plist == nil) return nil;
    if ([(id)plist isKindOfClass:[NSDictionary class]]) {
        return [(NSDictionary *)plist autorelease];
    }
    else {
        CFRelease(plist);
        return nil;
    }
}

@end
