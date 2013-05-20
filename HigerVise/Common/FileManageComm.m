//
//  FileManageComm.m
//  Locoso
//
//  Created by yongchang hu on 12-3-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FileManageComm.h"

@implementation FileManageComm
+ (BOOL)removeFileAtPath:(NSString *)path error:(NSError **)err
{
	NSFileManager *fileManager = [[[NSFileManager alloc] init] autorelease];
    
	if ([fileManager fileExistsAtPath:path]) {
		NSError *removeError = nil;
		[fileManager removeItemAtPath:path error:&removeError];
		if (removeError) {
			if (err) {
//				*err = [NSError errorWithDomain:NetworkRequestErrorDomain code:ASIFileManagementError userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"Failed to delete file at path '%@'",path],NSLocalizedDescriptionKey,removeError,NSUnderlyingErrorKey,nil]];
			}
			return NO;
		}
	}
	return YES;
}

+(NSString *)get_filename:(NSString *)name
{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
            stringByAppendingPathComponent:name];
}
+(BOOL)checkWhetherExit:(NSString *)name
{
    NSFileManager *file_manager = [NSFileManager defaultManager];
    return [file_manager fileExistsAtPath:[self get_filename:name]];
} 
@end
