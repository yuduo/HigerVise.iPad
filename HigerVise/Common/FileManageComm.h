//
//  FileManageComm.h
//  Locoso
//
//  Created by yongchang hu on 12-3-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FileManageComm : NSObject
+ (BOOL)removeFileAtPath:(NSString *)path error:(NSError **)err;
+(BOOL)checkWhetherExit:(NSString *)name;
+(NSString *)get_filename:(NSString *)name;
@end
