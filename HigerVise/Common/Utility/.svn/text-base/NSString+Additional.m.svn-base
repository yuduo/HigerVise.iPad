//
//  NSString+Additional.m
//  Locoso
//
//  Created by zhiwei ma on 12-3-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NSString+Additional.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Additional)

- (NSString*)md5 
{
	const char* string = [self UTF8String];
	unsigned char result[16];
	CC_MD5(string, strlen(string), result);
	NSString* hash = [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
					  result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7], 
					  result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]];
	
	return [hash lowercaseString];
}

- (NSString*)sha1 {
	const char* string = [self UTF8String];
	unsigned char result[CC_SHA1_DIGEST_LENGTH];   // 20
	CC_SHA1(string, strlen(string), result);
	NSString* hash = [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
					  result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7], 
					  result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15],
					  result[16], result[17], result[18], result[19]];
	
	return [hash lowercaseString];
}

- (NSData*)sha1_data {
	const char* string = [self UTF8String];
	unsigned char result[CC_SHA1_DIGEST_LENGTH];   // 20
	CC_SHA1(string, strlen(string), result);
	NSData *data = [NSData dataWithBytes:result length:20];
	return data;
}
@end

@implementation NSString (NSDateCategory)
- (NSDate*)convertToDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:self];
    [dateFormatter release];
    return date;
}
@end
