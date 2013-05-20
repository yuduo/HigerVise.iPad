//
//  NSStringTool.h
//  Locoso
//
//  Created by yongchang hu on 12-2-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSStringTool : NSObject
+(NSString *)flattenHTML:(NSString *)html;
+(NSString *)flattenHttp:(NSString *)html;
+(NSString*)getFileNameFromUrl:(NSString*)url;
@end
