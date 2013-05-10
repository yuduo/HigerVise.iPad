#import "client_search_dal.h"

@implementation client_search_dal

+ (NSNumber *)getMaxId
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    NSNumber *rtn;
    FMResultSet *result = [db executeQuery:@"SELECT MAX(search_id) FROM client_search"];
    if ([result next]) {
        int maxId = [result intForColumnIndex:0] + 1;
        rtn = [NSNumber numberWithInt:maxId];
    }
    [db close];
    return rtn;
}

+ (BOOL)exists:(NSNumber *)search_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    FMResultSet *result = [db executeQuery:@"SELECT COUNT(search_id) FROM client_search WHERE search_id = ?", search_id];
    if ([result next]) {
        int count = [result intForColumnIndex:0];
        if (count == 0) {
            rtn = NO;
        }
        else {
            rtn = YES;
        }
    }
    [db close];
    return rtn;
}

+ (BOOL)add:(client_search *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"INSERT INTO client_search (search_id, display_name, field_name, field_type, search_type, search_index, data_version) VALUES (?, ?, ?, ?, ?, ?, ?)", model.search_id, model.display_name, model.field_name, model.field_type, model.search_type, model.search_index, model.data_version];
    [db close];
    return rtn;
}

+ (BOOL)update:(client_search *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"UPDATE client_search SET display_name = ?, field_name = ?, field_type = ?, search_type = ?, search_index = ?, data_version = ? WHERE search_id = ?", model.display_name, model.field_name, model.field_type, model.search_type, model.search_index, model.data_version, model.search_id];
    [db close];
    return rtn;
}

+ (BOOL)delete:(NSNumber *)search_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"DELETE FROM client_search WHERE search_id = ?", search_id];
    [db close];
    return rtn;
}

+ (BOOL)deleteList:(NSString *)where
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    NSString *strSql = [NSString stringWithFormat:@"DELETE FROM client_search WHERE %@", where];
    rtn = [db executeUpdate:strSql];
    [db close];
    return rtn;
}

+ (client_search *)get:(NSNumber *)search_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    client_search *rtn;
    FMResultSet *result = [db executeQuery:@"SELECT * FROM client_search WHERE search_id = ?", search_id];
    while ([result next]) {
        rtn = [[client_search alloc] init];
        rtn.search_id = [NSNumber numberWithInt:[result intForColumn:@"search_id"]];
        rtn.display_name = [result stringForColumn:@"display_name"];
        rtn.field_name = [result stringForColumn:@"field_name"];
        rtn.field_type = [NSNumber numberWithInt:[result intForColumn:@"field_type"]];
        rtn.search_type = [NSNumber numberWithInt:[result intForColumn:@"search_type"]];
        rtn.search_index = [NSNumber numberWithInt:[result intForColumn:@"search_index"]];
        rtn.data_version = [NSNumber numberWithInt:[result intForColumn:@"data_version"]];
        break;
    }
    [db close];
    return rtn;
}

+ (NSArray *)getList:(NSString *)where
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_search WHERE %@", where];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_search *rtn = [[client_search alloc] init];
        rtn.search_id = [NSNumber numberWithInt:[result intForColumn:@"search_id"]];
        rtn.display_name = [result stringForColumn:@"display_name"];
        rtn.field_name = [result stringForColumn:@"field_name"];
        rtn.field_type = [NSNumber numberWithInt:[result intForColumn:@"field_type"]];
        rtn.search_type = [NSNumber numberWithInt:[result intForColumn:@"search_type"]];
        rtn.search_index = [NSNumber numberWithInt:[result intForColumn:@"search_index"]];
        rtn.data_version = [NSNumber numberWithInt:[result intForColumn:@"data_version"]];
        [array addObject:rtn];
    }
    [db close];
    return array;
}

+ (NSArray *)getList:(NSString *)where order:(NSString *)order
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_search WHERE %@ ORDER BY %@", where, order];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_search *rtn = [[client_search alloc] init];
        rtn.search_id = [NSNumber numberWithInt:[result intForColumn:@"search_id"]];
        rtn.display_name = [result stringForColumn:@"display_name"];
        rtn.field_name = [result stringForColumn:@"field_name"];
        rtn.field_type = [NSNumber numberWithInt:[result intForColumn:@"field_type"]];
        rtn.search_type = [NSNumber numberWithInt:[result intForColumn:@"search_type"]];
        rtn.search_index = [NSNumber numberWithInt:[result intForColumn:@"search_index"]];
        rtn.data_version = [NSNumber numberWithInt:[result intForColumn:@"data_version"]];
        [array addObject:rtn];
    }
    [db close];
    return array;
}

+ (NSArray *)getList:(NSString *)where order:(NSString *)order top:(NSInteger)top
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_search WHERE %@ ORDER BY %@ LIMIT 0,%d", where, order, top];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_search *rtn = [[client_search alloc] init];
        rtn.search_id = [NSNumber numberWithInt:[result intForColumn:@"search_id"]];
        rtn.display_name = [result stringForColumn:@"display_name"];
        rtn.field_name = [result stringForColumn:@"field_name"];
        rtn.field_type = [NSNumber numberWithInt:[result intForColumn:@"field_type"]];
        rtn.search_type = [NSNumber numberWithInt:[result intForColumn:@"search_type"]];
        rtn.search_index = [NSNumber numberWithInt:[result intForColumn:@"search_index"]];
        rtn.data_version = [NSNumber numberWithInt:[result intForColumn:@"data_version"]];
        [array addObject:rtn];
    }
    [db close];
    return array;
}

+ (NSArray *)getList:(NSString *)where order:(NSString *)order beginIndex:(NSInteger)beginIndex length:(NSInteger)length
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_search WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_search *rtn = [[client_search alloc] init];
        rtn.search_id = [NSNumber numberWithInt:[result intForColumn:@"search_id"]];
        rtn.display_name = [result stringForColumn:@"display_name"];
        rtn.field_name = [result stringForColumn:@"field_name"];
        rtn.field_type = [NSNumber numberWithInt:[result intForColumn:@"field_type"]];
        rtn.search_type = [NSNumber numberWithInt:[result intForColumn:@"search_type"]];
        rtn.search_index = [NSNumber numberWithInt:[result intForColumn:@"search_index"]];
        rtn.data_version = [NSNumber numberWithInt:[result intForColumn:@"data_version"]];
        [array addObject:rtn];
    }
    [db close];
    return array;
}

+ (NSArray *)getList:(NSString *)where order:(NSString *)order page:(NSInteger)page pageSize:(NSInteger)pageSize
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSInteger beginIndex = (page - 1) * pageSize;
    NSInteger length = pageSize;
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_search WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_search *rtn = [[client_search alloc] init];
        rtn.search_id = [NSNumber numberWithInt:[result intForColumn:@"search_id"]];
        rtn.display_name = [result stringForColumn:@"display_name"];
        rtn.field_name = [result stringForColumn:@"field_name"];
        rtn.field_type = [NSNumber numberWithInt:[result intForColumn:@"field_type"]];
        rtn.search_type = [NSNumber numberWithInt:[result intForColumn:@"search_type"]];
        rtn.search_index = [NSNumber numberWithInt:[result intForColumn:@"search_index"]];
        rtn.data_version = [NSNumber numberWithInt:[result intForColumn:@"data_version"]];
        [array addObject:rtn];
    }
    [db close];
    return array;
}

+ (client_search *)convertJsonToModel:(NSDictionary *)json
{
    client_search *model = [[client_search alloc] init];
    model.search_id = [json objectForKey:@"search_id"];
    model.display_name = [json objectForKey:@"display_name"];
    model.field_name = [json objectForKey:@"field_name"];
    model.field_type = [json objectForKey:@"field_type"];
    model.search_type = [json objectForKey:@"search_type"];
    model.search_index = [json objectForKey:@"search_index"];
    model.data_version = [json objectForKey:@"data_version"];
    return model;
}

+ (NSArray *)convertJsonToList:(NSArray *)jsons
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSDictionary *json in jsons) {
        client_search *model = [[client_search alloc] init];
        model.search_id = [json objectForKey:@"search_id"];
        model.display_name = [json objectForKey:@"display_name"];
        model.field_name = [json objectForKey:@"field_name"];
        model.field_type = [json objectForKey:@"field_type"];
        model.search_type = [json objectForKey:@"search_type"];
        model.search_index = [json objectForKey:@"search_index"];
        model.data_version = [json objectForKey:@"data_version"];
        [array addObject:model];
    }
    return array;
}

+ (NSArray *)getListForSearch
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSString *strSql = [NSString stringWithFormat:@"SELECT search_id,display_name,field_name,search_type FROM client_search ORDER BY search_index ASC"];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_search *rtn = [[client_search alloc] init];
        rtn.search_id = [NSNumber numberWithInt:[result intForColumn:@"search_id"]];
        rtn.display_name = [result stringForColumn:@"display_name"];
        rtn.field_name = [result stringForColumn:@"field_name"];
        rtn.search_type = [NSNumber numberWithInt:[result intForColumn:@"search_type"]];
        [array addObject:rtn];
    }
    [db close];
    return array;
}

@end