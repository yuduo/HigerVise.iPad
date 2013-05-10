#import "client_search_option_dal.h"

@implementation client_search_option_dal

+ (NSNumber *)getMaxId
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    NSNumber *rtn;
    FMResultSet *result = [db executeQuery:@"SELECT MAX(search_option_id) FROM client_search_option"];
    if ([result next]) {
        int maxId = [result intForColumnIndex:0] + 1;
        rtn = [NSNumber numberWithInt:maxId];
    }
    [db close];
    return rtn;
}

+ (BOOL)exists:(NSNumber *)search_option_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    FMResultSet *result = [db executeQuery:@"SELECT COUNT(search_option_id) FROM client_search_option WHERE search_option_id = ?", search_option_id];
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

+ (BOOL)add:(client_search_option *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"INSERT INTO client_search_option (search_option_id, search_id, vehicle_class_id, display_name, field_value, data_version) VALUES (?, ?, ?, ?, ?, ?)", model.search_option_id, model.search_id, model.vehicle_class_id, model.display_name, model.field_value, model.data_version];
    [db close];
    return rtn;
}

+ (BOOL)update:(client_search_option *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"UPDATE client_search_option SET search_id = ?, vehicle_class_id = ?, display_name = ?, field_value = ?, data_version = ? WHERE search_option_id = ?", model.search_id, model.vehicle_class_id, model.display_name, model.field_value, model.data_version, model.search_option_id];
    [db close];
    return rtn;
}

+ (BOOL)delete:(NSNumber *)search_option_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"DELETE FROM client_search_option WHERE search_option_id = ?", search_option_id];
    [db close];
    return rtn;
}

+ (BOOL)deleteList:(NSString *)where
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    NSString *strSql = [NSString stringWithFormat:@"DELETE FROM client_search_option WHERE %@", where];
    rtn = [db executeUpdate:strSql];
    [db close];
    return rtn;
}

+ (client_search_option *)get:(NSNumber *)search_option_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    client_search_option *rtn;
    FMResultSet *result = [db executeQuery:@"SELECT * FROM client_search_option WHERE search_option_id = ?", search_option_id];
    while ([result next]) {
        rtn = [[client_search_option alloc] init];
        rtn.search_option_id = [NSNumber numberWithInt:[result intForColumn:@"search_option_id"]];
        rtn.search_id = [NSNumber numberWithInt:[result intForColumn:@"search_id"]];
        rtn.vehicle_class_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_class_id"]];
        rtn.display_name = [result stringForColumn:@"display_name"];
        rtn.field_value = [result stringForColumn:@"field_value"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_search_option WHERE %@", where];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_search_option *rtn = [[client_search_option alloc] init];
        rtn.search_option_id = [NSNumber numberWithInt:[result intForColumn:@"search_option_id"]];
        rtn.search_id = [NSNumber numberWithInt:[result intForColumn:@"search_id"]];
        rtn.vehicle_class_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_class_id"]];
        rtn.display_name = [result stringForColumn:@"display_name"];
        rtn.field_value = [result stringForColumn:@"field_value"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_search_option WHERE %@ ORDER BY %@", where, order];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_search_option *rtn = [[client_search_option alloc] init];
        rtn.search_option_id = [NSNumber numberWithInt:[result intForColumn:@"search_option_id"]];
        rtn.search_id = [NSNumber numberWithInt:[result intForColumn:@"search_id"]];
        rtn.vehicle_class_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_class_id"]];
        rtn.display_name = [result stringForColumn:@"display_name"];
        rtn.field_value = [result stringForColumn:@"field_value"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_search_option WHERE %@ ORDER BY %@ LIMIT 0,%d", where, order, top];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_search_option *rtn = [[client_search_option alloc] init];
        rtn.search_option_id = [NSNumber numberWithInt:[result intForColumn:@"search_option_id"]];
        rtn.search_id = [NSNumber numberWithInt:[result intForColumn:@"search_id"]];
        rtn.vehicle_class_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_class_id"]];
        rtn.display_name = [result stringForColumn:@"display_name"];
        rtn.field_value = [result stringForColumn:@"field_value"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_search_option WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_search_option *rtn = [[client_search_option alloc] init];
        rtn.search_option_id = [NSNumber numberWithInt:[result intForColumn:@"search_option_id"]];
        rtn.search_id = [NSNumber numberWithInt:[result intForColumn:@"search_id"]];
        rtn.vehicle_class_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_class_id"]];
        rtn.display_name = [result stringForColumn:@"display_name"];
        rtn.field_value = [result stringForColumn:@"field_value"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_search_option WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_search_option *rtn = [[client_search_option alloc] init];
        rtn.search_option_id = [NSNumber numberWithInt:[result intForColumn:@"search_option_id"]];
        rtn.search_id = [NSNumber numberWithInt:[result intForColumn:@"search_id"]];
        rtn.vehicle_class_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_class_id"]];
        rtn.display_name = [result stringForColumn:@"display_name"];
        rtn.field_value = [result stringForColumn:@"field_value"];
        rtn.data_version = [NSNumber numberWithInt:[result intForColumn:@"data_version"]];
        [array addObject:rtn];
    }
    [db close];
    return array;
}

+ (client_search_option *)convertJsonToModel:(NSDictionary *)json
{
    client_search_option *model = [[client_search_option alloc] init];
    model.search_option_id = [json objectForKey:@"search_option_id"];
    model.search_id = [json objectForKey:@"search_id"];
    model.vehicle_class_id = [json objectForKey:@"vehicle_class_id"];
    model.display_name = [json objectForKey:@"display_name"];
    model.field_value = [json objectForKey:@"field_value"];
    model.data_version = [json objectForKey:@"data_version"];
    return model;
}

+ (NSArray *)convertJsonToList:(NSArray *)jsons
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSDictionary *json in jsons) {
        client_search_option *model = [[client_search_option alloc] init];
        model.search_option_id = [json objectForKey:@"search_option_id"];
        model.search_id = [json objectForKey:@"search_id"];
        model.vehicle_class_id = [json objectForKey:@"vehicle_class_id"];
        model.display_name = [json objectForKey:@"display_name"];
        model.field_value = [json objectForKey:@"field_value"];
        model.data_version = [json objectForKey:@"data_version"];
        [array addObject:model];
    }
    return array;
}

+ (NSArray *)getListByVehcileClass:(NSInteger)vehicle_class_id field_name:(NSString *)field_name slave_search_id:(NSInteger)slave_search_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSString *strSql = [NSString stringWithFormat:@"SELECT search_option_id,search_id,display_name,field_value FROM client_search_option WHERE search_option_id IN (SELECT slave_search_option_id FROM client_search_option_relation WHERE slave_search_id = %d AND master_search_option_id IN (SELECT search_option_id FROM client_search_option WHERE vehicle_class_id = %d AND search_id IN (SELECT search_id FROM client_search WHERE field_name = '%@'))) ORDER BY field_value ASC", slave_search_id, vehicle_class_id, field_name];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_search_option *rtn = [[client_search_option alloc] init];
        rtn.search_option_id = [NSNumber numberWithInt:[result intForColumn:@"search_option_id"]];
        rtn.search_id = [NSNumber numberWithInt:[result intForColumn:@"search_id"]];
        rtn.display_name = [result stringForColumn:@"display_name"];
        rtn.field_value = [result stringForColumn:@"field_value"];
        [array addObject:rtn];
    }

    [db close];
    return array;
}

+ (NSArray *)getListByMasterSearchOption:(NSInteger)master_search_option_id slave_search_id:(NSInteger)slave_search_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSString *strSql = [NSString stringWithFormat:@"SELECT search_option_id,search_id,display_name,field_value FROM client_search_option WHERE search_option_id IN (SELECT slave_search_option_id FROM client_search_option_relation WHERE master_search_option_id = %d AND slave_search_id = %d) ORDER BY field_value ASC", master_search_option_id, slave_search_id];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_search_option *rtn = [[client_search_option alloc] init];
        rtn.search_option_id = [NSNumber numberWithInt:[result intForColumn:@"search_option_id"]];
        rtn.search_id = [NSNumber numberWithInt:[result intForColumn:@"search_id"]];
        rtn.display_name = [result stringForColumn:@"display_name"];
        rtn.field_value = [result stringForColumn:@"field_value"];
        [array addObject:rtn];
    }
    
    [db close];
    return array;
}

+ (NSArray *)getListForSearch:(NSString *)where
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSString *strSql = [NSString stringWithFormat:@"SELECT search_option_id,search_id,display_name,field_value FROM client_search_option WHERE %@", where];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_search_option *rtn = [[client_search_option alloc] init];
        rtn.search_option_id = [NSNumber numberWithInt:[result intForColumn:@"search_option_id"]];
        rtn.search_id = [NSNumber numberWithInt:[result intForColumn:@"search_id"]];
        rtn.display_name = [result stringForColumn:@"display_name"];
        rtn.field_value = [result stringForColumn:@"field_value"];
        [array addObject:rtn];
    }
    [db close];
    return array;
}

@end