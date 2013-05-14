//
//  DownloadFileManage.h
//  HigerManage
//
//  Created by jijesoft on 13-5-13.
//  Copyright (c) 2013年 WuHanNvl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownloadFileManage : NSObject
+(void)addToDownloadedList:(NSString*)strID path:(NSString*)path;
+(void)deleteFromDownloadedList:(NSString*)strID;
+(NSArray*)getDownloadFileArray;
@end
