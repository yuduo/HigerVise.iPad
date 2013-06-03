//
//  book_list_model.m
//  HigerManage
//
//  Created by jijesoft on 13-5-20.
//  Copyright (c) 2013年 WuHanNvl. All rights reserved.
//

#import "book_list_model.h"
#import "FMDatabase.h"
#import "BaseInfo.h"
#import "client_book.h"
@implementation book_list_model
+(NSArray*)getBookList:(NSInteger)index
{
    NSString *dbPath = [BaseInfo getManageDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM vise_klsz_resource_master where resource_class_id = %d",index] ;
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_book *rtn = [[client_book alloc] init];
        rtn.resource_size = [result stringForColumn:@"resource_size"];
        rtn.resource_title = [result stringForColumn:@"resource_title"];
        rtn.resource_type = [NSNumber numberWithInt:[result intForColumn:@"resource_type"]];
        rtn.resource_url = [result stringForColumn:@"resource_url"];
        rtn.resource_master_id = [NSNumber numberWithInt:[result intForColumn:@"resource_master_id"]];
        rtn.resource_thum_url = [result stringForColumn:@"resource_thum_url"];
        rtn.is_marked = [result boolForColumn:@"is_marked"];
        rtn.create_time = [result stringForColumn:@"create_time"];
        rtn.resource_image_count = [result stringForColumn:@"resource_image_count"];
        rtn.resource_video_duration = [result stringForColumn:@"resource_video_duration"];
        [array addObject:rtn];
    }
    [db close];
    return array;
}
+(NSArray*)getBookListAll
{
    NSString *dbPath = [BaseInfo getManageDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSString *strSql = @"SELECT * FROM vise_klsz_resource_master";
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_book *rtn = [[client_book alloc] init];
        rtn.resource_size = [result stringForColumn:@"resource_size"];
        rtn.resource_title = [result stringForColumn:@"resource_title"];
        rtn.resource_type = [NSNumber numberWithInt:[result intForColumn:@"resource_type"]];
        rtn.resource_url = [result stringForColumn:@"resource_url"];
        rtn.resource_master_id = [NSNumber numberWithInt:[result intForColumn:@"resource_master_id"]];
        rtn.resource_thum_url = [result stringForColumn:@"resource_thum_url"];
        rtn.is_marked = [result boolForColumn:@"is_marked"];
        rtn.create_time = [result stringForColumn:@"create_time"];
        rtn.resource_image_count = [result stringForColumn:@"resource_image_count"];
        rtn.resource_video_duration = [result stringForColumn:@"resource_video_duration"];
        [array addObject:rtn];
    }
    [db close];
    return array;
}
+(void)updateBookListMarked:(NSString*)sql
{
    NSString *dbPath = [BaseInfo getManageDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    
    NSString *strSql = [NSString stringWithFormat:@"update vise_klsz_resource_master SET is_marked= 1 where resource_master_id in %@",sql] ;
    BOOL rtn;
    rtn = [db executeUpdate:strSql];
    
    [db close];
}

+(void)updateBookListUnMark:(NSString*)sql
{
    NSString *dbPath = [BaseInfo getManageDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    
    NSString *strSql = [NSString stringWithFormat:@"update vise_klsz_resource_master SET is_marked= 0 where resource_master_id = %@",sql] ;
    BOOL rtn;
    rtn = [db executeUpdate:strSql];
    
    [db close];
}

+(NSArray*)getMarkedBookList
{
    NSString *dbPath = [BaseInfo getManageDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM vise_klsz_resource_master where is_marked = 1"] ;
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_book *rtn = [[client_book alloc] init];
        rtn.resource_size = [result stringForColumn:@"resource_size"];
        rtn.resource_title = [result stringForColumn:@"resource_title"];
        rtn.resource_type = [NSNumber numberWithInt:[result intForColumn:@"resource_type"]];
        rtn.resource_url = [result stringForColumn:@"resource_url"];
        rtn.resource_master_id = [NSNumber numberWithInt:[result intForColumn:@"resource_master_id"]];
        rtn.resource_thum_url = [result stringForColumn:@"resource_thum_url"];
        rtn.is_marked = [result boolForColumn:@"is_marked"];
        [array addObject:rtn];
    }
    [db close];
    return array;
}
@end
