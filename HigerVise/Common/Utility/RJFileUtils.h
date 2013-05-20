//
//  RJFileUtils.h
//  RuijiMOA
//
//  Created by  on 12-2-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RJFileUtils : NSObject
+ (NSString*)pathWithinDocumentDir:(NSString*)aPath;
+ (BOOL)createDirectory:(NSString*)dirPath lastComponentIsDirectory:(BOOL)isDir;
+ (BOOL)ensureDirectoryIsExist:(NSString*)dirPath lastComponentIsDirectory:(BOOL)isDir;
+ (BOOL)removeItemAtPathWithinDocumentDir:(NSString*)aPath;
@end