#import "client_user_module_dal.h"

@implementation client_user_module_dal

+ (NSNumber *)getMaxId
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    NSNumber *rtn;
    FMResultSet *result = [db executeQuery:@"SELECT MAX(user_module_id) FROM client_user_module"];
    if ([result next]) {
        int maxId = [result intForColumnIndex:0] + 1;
        rtn = [NSNumber numberWithInt:maxId];
    }
    [db close];
    return rtn;
}

+ (BOOL)exists:(NSNumber *)user_module_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    FMResultSet *result = [db executeQuery:@"SELECT COUNT(user_module_id) FROM client_user_module WHERE user_module_id = ?", user_module_id];
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

+ (BOOL)add:(client_user_module *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"INSERT INTO client_user_module (user_module_id, module_code, module_name, module_desc, data_version) VALUES (?, ?, ?, ?, ?)", model.user_module_id, model.module_code, model.module_name, model.module_desc, model.data_version];
    [db close];
    return rtn;
}

+ (BOOL)update:(client_user_module *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"UPDATE client_user_module SET module_code = ?, module_name = ?, module_desc = ?, data_version = ? WHERE user_module_id = ?", model.module_code, model.module_name, model.module_desc, model.data_version, model.user_module_id];
    [db close];
    return rtn;
}

+ (BOOL)delete:(NSNumber *)user_module_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"DELETE FROM client_user_module WHERE user_module_id = ?", user_module_id];
    [db close];
    return rtn;
}

+ (BOOL)deleteList:(NSString *)where
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    NSString *strSql = [NSString stringWithFormat:@"DELETE FROM client_user_module WHERE %@", where];
    rtn = [db executeUpdate:strSql];
    [db close];
    return rtn;
}

+ (client_user_module *)get:(NSNumber *)user_module_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    client_user_module *rtn;
    FMResultSet *result = [db executeQuery:@"SELECT * FROM client_user_module WHERE user_module_id = ?", user_module_id];
    while ([result next]) {
        rtn = [[client_user_module alloc] init];
        rtn.user_module_id = [NSNumber numberWithInt:[result intForColumn:@"user_module_id"]];
        rtn.module_code = [result stringForColumn:@"module_code"];
        rtn.module_name = [result stringForColumn:@"module_name"];
        rtn.module_desc = [result stringForColumn:@"module_desc"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_user_module WHERE %@", where];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_user_module *rtn = [[client_user_module alloc] init];
        rtn.user_module_id = [NSNumber numberWithInt:[result intForColumn:@"user_module_id"]];
        rtn.module_code = [result stringForColumn:@"module_code"];
        rtn.module_name = [result stringForColumn:@"module_name"];
        rtn.module_desc = [result stringForColumn:@"module_desc"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_user_module WHERE %@ ORDER BY %@", where, order];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_user_module *rtn = [[client_user_module alloc] init];
        rtn.user_module_id = [NSNumber numberWithInt:[result intForColumn:@"user_module_id"]];
        rtn.module_code = [result stringForColumn:@"module_code"];
        rtn.module_name = [result stringForColumn:@"module_name"];
        rtn.module_desc = [result stringForColumn:@"module_desc"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_user_module WHERE %@ ORDER BY %@ LIMIT 0,%d", where, order, top];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_user_module *rtn = [[client_user_module alloc] init];
        rtn.user_module_id = [NSNumber numberWithInt:[result intForColumn:@"user_module_id"]];
        rtn.module_code = [result stringForColumn:@"module_code"];
        rtn.module_name = [result stringForColumn:@"module_name"];
        rtn.module_desc = [result stringForColumn:@"module_desc"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_user_module WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_user_module *rtn = [[client_user_module alloc] init];
        rtn.user_module_id = [NSNumber numberWithInt:[result intForColumn:@"user_module_id"]];
        rtn.module_code = [result stringForColumn:@"module_code"];
        rtn.module_name = [result stringForColumn:@"module_name"];
        rtn.module_desc = [result stringForColumn:@"module_desc"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_user_module WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_user_module *rtn = [[client_user_module alloc] init];
        rtn.user_module_id = [NSNumber numberWithInt:[result intForColumn:@"user_module_id"]];
        rtn.module_code = [result stringForColumn:@"module_code"];
        rtn.module_name = [result stringForColumn:@"module_name"];
        rtn.module_desc = [result stringForColumn:@"module_desc"];
        rtn.data_version = [NSNumber numberWithInt:[result intForColumn:@"data_version"]];
        [array addObject:rtn];
    }
    [db close];
    return array;
}

+ (client_user_module *)convertJsonToModel:(NSDictionary *)json
{
    client_user_module *model = [[client_user_module alloc] init];
    model.user_module_id = [json objectForKey:@"user_module_id"];
    model.module_code = [json objectForKey:@"module_code"];
    model.module_name = [json objectForKey:@"module_name"];
    model.module_desc = [json objectForKey:@"module_desc"];
    model.data_version = [json objectForKey:@"data_version"];
    return model;
}

+ (NSArray *)convertJsonToList:(NSArray *)jsons
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSDictionary *json in jsons) {
        client_user_module *model = [[client_user_module alloc] init];
        model.user_module_id = [json objectForKey:@"user_module_id"];
        model.module_code = [json objectForKey:@"module_code"];
        model.module_name = [json objectForKey:@"module_name"];
        model.module_desc = [json objectForKey:@"module_desc"];
        model.data_version = [json objectForKey:@"data_version"];
        [array addObject:model];
    }
    return array;
}

@end