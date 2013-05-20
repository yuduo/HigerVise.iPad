//
//  RJFileUtils.m
//  RuijiMOA
//
//  Created by  on 12-2-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RJFileUtils.h"

@implementation RJFileUtils
+ (NSString*)pathWithinDocumentDir:(NSString*)aPath 
{	
	NSString *fullPath = nil;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	
	if ([paths count] > 0) {
		fullPath = (NSString*)[paths objectAtIndex:0];
		if([aPath length] > 0) 
        {
			fullPath = [fullPath stringByAppendingPathComponent:aPath];
		}
	}
	return fullPath;
}

+ (BOOL)createDirectory:(NSString*)dirPath lastComponentIsDirectory:(BOOL)isDir 
{
	NSString* path = nil;
	if(isDir) 
    {
        path = dirPath;
    }
	else 
    {
        path = [dirPath stringByDeletingLastPathComponent];
    }
	
	if(dirPath && ([[NSFileManager defaultManager] fileExistsAtPath:path] == NO))
    {
		NSError* error = nil;		
		BOOL ret;
		
		ret = [[NSFileManager defaultManager] createDirectoryAtPath:path
										withIntermediateDirectories:YES
														 attributes:nil
															  error:&error];				
		if(!ret && error) 
        {
			NSLog(@"create directory failed at path '%@',error:%@,%@",dirPath,[error localizedDescription],[error localizedFailureReason]);
			return NO;
		}
	}
	return YES;
}

+ (BOOL)ensureDirectoryIsExist:(NSString*)dirPath lastComponentIsDirectory:(BOOL)isDir
{
    BOOL isDirectory = NO;
    if (YES == [[NSFileManager defaultManager] fileExistsAtPath:dirPath isDirectory:&isDirectory])
    {
        if (isDir == isDirectory)
        {
            return YES;
        }
    }
    return [RJFileUtils createDirectory:dirPath lastComponentIsDirectory:isDir];
}

+ (BOOL)removeItemAtPathWithinDocumentDir:(NSString*)aPath
{
    NSString* fullPath = [RJFileUtils pathWithinDocumentDir:aPath];
    NSError* error = nil;
    BOOL ret = [[NSFileManager defaultManager] removeItemAtPath:fullPath error:&error];
    if (error)
    {
        NSLog(@"removeItemAtPathWithinDocumentDir failed,%@",[error description]);
    }
    return ret;
}
@end

