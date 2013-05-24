//
//  catogory_list_model.m
//  HigerManage
//
//  Created by jijesoft on 13-5-20.
//  Copyright (c) 2013年 WuHanNvl. All rights reserved.
//

#import "catogory_list_model.h"
#import "FMDatabase.h"
#import "BaseInfo.h"
#import "client_catgory.h"
@implementation catogory_list_model
+(NSArray*)getBookList
{
    NSString *dbPath = [BaseInfo getManageDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSString *strSql = @"SELECT * FROM vise_klsz_resource_class";
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_catgory *rtn = [[client_catgory alloc] init];
        rtn.catgory_name = [result stringForColumn:@"resource_class_name"];
        rtn.resource_class_id = [NSNumber numberWithInt:[result intForColumn:@"resource_class_id"]];
        [array addObject:rtn];
    }
    [db close];
    return array;
}
@end
