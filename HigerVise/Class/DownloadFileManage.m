//
//  DownloadFileManage.m
//  HigerManage
//
//  Created by jijesoft on 13-5-13.
//  Copyright (c) 2013年 WuHanNvl. All rights reserved.
//

#import "DownloadFileManage.h"
#import "BaseInfo.h"
@implementation DownloadFileManage
+(void)addToDownloadedList:(NSString*)strID path:(NSString*)path
{
    NSString *filePath = [BaseInfo getDownloadManageFile];
    NSMutableArray *array = nil;
     if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
     {
         array = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
         
     }else
     {
         [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
         array = [[NSMutableArray alloc] init];
     }
    [array addObject:[NSDictionary dictionaryWithObjectsAndKeys:strID,@"source_id",path,@"source_path", nil]];
    [array writeToFile:filePath atomically:YES];
}
+(void)deleteFromDownloadedList:(NSString*)strID
{
    //remove from list
    NSString *filePath = [BaseInfo getDownloadManageFile];
    NSString *deletePath = nil;
    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    for (int i = 0; i < [array count]; i ++) {
        NSDictionary *dic = [array objectAtIndex:i];
        if ([strID isEqualToString:[dic objectForKey:@"source_id"]]) {
            deletePath = [dic objectForKey:@"source_path"];
            [array removeObjectAtIndex:i];
            break;
        }
    }
    [array writeToFile:filePath atomically:YES];
    
    //remove file
    if (deletePath != nil) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:deletePath error:nil];
    }
    
}
+(NSArray*)getDownloadFileArray
{
    NSString *filePath = [BaseInfo getDownloadManageFile];
    NSMutableArray *array = nil;
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        array = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
        
    }
    return array;
}
@end
