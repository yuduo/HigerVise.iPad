#import "client_enum_info_dal.h"

@implementation client_enum_info_dal

+ (NSNumber *)getMaxId
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    NSNumber *rtn;
    FMResultSet *result = [db executeQuery:@"SELECT MAX(enum_info_id) FROM client_enum_info"];
    if ([result next]) {
        int maxId = [result intForColumnIndex:0] + 1;
        rtn = [NSNumber numberWithInt:maxId];
    }
    [db close];
    return rtn;
}

+ (BOOL)exists:(NSNumber *)enum_info_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    FMResultSet *result = [db executeQuery:@"SELECT COUNT(enum_info_id) FROM client_enum_info WHERE enum_info_id = ?", enum_info_id];
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

+ (BOOL)add:(client_enum_info *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"INSERT INTO client_enum_info (enum_info_id, enum_key, enum_value, enum_desc, enum_parent_id, enum_table_name, enum_field_name, data_version) VALUES (?, ?, ?, ?, ?, ?, ?, ?)", model.enum_info_id, model.enum_key, model.enum_value, model.enum_desc, model.enum_parent_id, model.enum_table_name, model.enum_field_name, model.data_version];
    [db close];
    return rtn;
}

+ (BOOL)update:(client_enum_info *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"UPDATE client_enum_info SET enum_key = ?, enum_value = ?, enum_desc = ?, enum_parent_id = ?, enum_table_name = ?, enum_field_name = ?, data_version = ? WHERE enum_info_id = ?", model.enum_key, model.enum_value, model.enum_desc, model.enum_parent_id, model.enum_table_name, model.enum_field_name, model.data_version, model.enum_info_id];
    [db close];
    return rtn;
}

+ (BOOL)delete:(NSNumber *)enum_info_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"DELETE FROM client_enum_info WHERE enum_info_id = ?", enum_info_id];
    [db close];
    return rtn;
}

+ (BOOL)deleteList:(NSString *)where
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    NSString *strSql = [NSString stringWithFormat:@"DELETE FROM client_enum_info WHERE %@", where];
    rtn = [db executeUpdate:strSql];
    [db close];
    return rtn;
}

+ (client_enum_info *)get:(NSNumber *)enum_info_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    client_enum_info *rtn;
    FMResultSet *result = [db executeQuery:@"SELECT * FROM client_enum_info WHERE enum_info_id = ?", enum_info_id];
    while ([result next]) {
        rtn = [[client_enum_info alloc] init];
        rtn.enum_info_id = [NSNumber numberWithInt:[result intForColumn:@"enum_info_id"]];
        rtn.enum_key = [result stringForColumn:@"enum_key"];
        rtn.enum_value = [result stringForColumn:@"enum_value"];
        rtn.enum_desc = [result stringForColumn:@"enum_desc"];
        rtn.enum_parent_id = [NSNumber numberWithInt:[result intForColumn:@"enum_parent_id"]];
        rtn.enum_table_name = [result stringForColumn:@"enum_table_name"];
        rtn.enum_field_name = [result stringForColumn:@"enum_field_name"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_enum_info WHERE %@", where];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_enum_info *rtn = [[client_enum_info alloc] init];
        rtn.enum_info_id = [NSNumber numberWithInt:[result intForColumn:@"enum_info_id"]];
        rtn.enum_key = [result stringForColumn:@"enum_key"];
        rtn.enum_value = [result stringForColumn:@"enum_value"];
        rtn.enum_desc = [result stringForColumn:@"enum_desc"];
        rtn.enum_parent_id = [NSNumber numberWithInt:[result intForColumn:@"enum_parent_id"]];
        rtn.enum_table_name = [result stringForColumn:@"enum_table_name"];
        rtn.enum_field_name = [result stringForColumn:@"enum_field_name"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_enum_info WHERE %@ ORDER BY %@", where, order];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_enum_info *rtn = [[client_enum_info alloc] init];
        rtn.enum_info_id = [NSNumber numberWithInt:[result intForColumn:@"enum_info_id"]];
        rtn.enum_key = [result stringForColumn:@"enum_key"];
        rtn.enum_value = [result stringForColumn:@"enum_value"];
        rtn.enum_desc = [result stringForColumn:@"enum_desc"];
        rtn.enum_parent_id = [NSNumber numberWithInt:[result intForColumn:@"enum_parent_id"]];
        rtn.enum_table_name = [result stringForColumn:@"enum_table_name"];
        rtn.enum_field_name = [result stringForColumn:@"enum_field_name"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_enum_info WHERE %@ ORDER BY %@ LIMIT 0,%d", where, order, top];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_enum_info *rtn = [[client_enum_info alloc] init];
        rtn.enum_info_id = [NSNumber numberWithInt:[result intForColumn:@"enum_info_id"]];
        rtn.enum_key = [result stringForColumn:@"enum_key"];
        rtn.enum_value = [result stringForColumn:@"enum_value"];
        rtn.enum_desc = [result stringForColumn:@"enum_desc"];
        rtn.enum_parent_id = [NSNumber numberWithInt:[result intForColumn:@"enum_parent_id"]];
        rtn.enum_table_name = [result stringForColumn:@"enum_table_name"];
        rtn.enum_field_name = [result stringForColumn:@"enum_field_name"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_enum_info WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_enum_info *rtn = [[client_enum_info alloc] init];
        rtn.enum_info_id = [NSNumber numberWithInt:[result intForColumn:@"enum_info_id"]];
        rtn.enum_key = [result stringForColumn:@"enum_key"];
        rtn.enum_value = [result stringForColumn:@"enum_value"];
        rtn.enum_desc = [result stringForColumn:@"enum_desc"];
        rtn.enum_parent_id = [NSNumber numberWithInt:[result intForColumn:@"enum_parent_id"]];
        rtn.enum_table_name = [result stringForColumn:@"enum_table_name"];
        rtn.enum_field_name = [result stringForColumn:@"enum_field_name"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_enum_info WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_enum_info *rtn = [[client_enum_info alloc] init];
        rtn.enum_info_id = [NSNumber numberWithInt:[result intForColumn:@"enum_info_id"]];
        rtn.enum_key = [result stringForColumn:@"enum_key"];
        rtn.enum_value = [result stringForColumn:@"enum_value"];
        rtn.enum_desc = [result stringForColumn:@"enum_desc"];
        rtn.enum_parent_id = [NSNumber numberWithInt:[result intForColumn:@"enum_parent_id"]];
        rtn.enum_table_name = [result stringForColumn:@"enum_table_name"];
        rtn.enum_field_name = [result stringForColumn:@"enum_field_name"];
        rtn.data_version = [NSNumber numberWithInt:[result intForColumn:@"data_version"]];
        [array addObject:rtn];
    }
    [db close];
    return array;
}

+ (client_enum_info *)convertJsonToModel:(NSDictionary *)json
{
    client_enum_info *model = [[client_enum_info alloc] init];
    model.enum_info_id = [json objectForKey:@"enum_info_id"];
    model.enum_key = [json objectForKey:@"enum_key"];
    model.enum_value = [json objectForKey:@"enum_value"];
    model.enum_desc = [json objectForKey:@"enum_desc"];
    model.enum_parent_id = [json objectForKey:@"enum_parent_id"];
    model.enum_table_name = [json objectForKey:@"enum_table_name"];
    model.enum_field_name = [json objectForKey:@"enum_field_name"];
    model.data_version = [json objectForKey:@"data_version"];
    return model;
}

+ (NSArray *)convertJsonToList:(NSArray *)jsons
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSDictionary *json in jsons) {
        client_enum_info *model = [[client_enum_info alloc] init];
        model.enum_info_id = [json objectForKey:@"enum_info_id"];
        model.enum_key = [json objectForKey:@"enum_key"];
        model.enum_value = [json objectForKey:@"enum_value"];
        model.enum_desc = [json objectForKey:@"enum_desc"];
        model.enum_parent_id = [json objectForKey:@"enum_parent_id"];
        model.enum_table_name = [json objectForKey:@"enum_table_name"];
        model.enum_field_name = [json objectForKey:@"enum_field_name"];
        model.data_version = [json objectForKey:@"data_version"];
        [array addObject:model];
    }
    return array;
}

@end