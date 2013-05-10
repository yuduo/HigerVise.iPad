#import "client_system_log_dal.h"

@implementation client_system_log_dal

+ (NSNumber *)getMaxId
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    NSNumber *rtn;
    FMResultSet *result = [db executeQuery:@"SELECT MAX(system_log_id) FROM client_system_log"];
    if ([result next]) {
        int maxId = [result intForColumnIndex:0] + 1;
        rtn = [NSNumber numberWithInt:maxId];
    }
    [db close];
    return rtn;
}

+ (BOOL)exists:(NSNumber *)system_log_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    FMResultSet *result = [db executeQuery:@"SELECT COUNT(system_log_id) FROM client_system_log WHERE system_log_id = ?", system_log_id];
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

+ (BOOL)add:(client_system_log *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"INSERT INTO client_system_log (system_log_id, log_level, log_user_name, log_module, log_operation, log_time, log_message, log_error, log_upload) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)", model.system_log_id, model.log_level, model.log_user_name, model.log_module, model.log_operation, model.log_time, model.log_message, model.log_error, model.log_upload];
    [db close];
    return rtn;
}

+ (BOOL)update:(client_system_log *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"UPDATE client_system_log SET log_level = ?, log_user_name = ?, log_module = ?, log_operation = ?, log_time = ?, log_message = ?, log_error = ?, log_upload = ? WHERE system_log_id = ?", model.log_level, model.log_user_name, model.log_module, model.log_operation, model.log_time, model.log_message, model.log_error, model.log_upload, model.system_log_id];
    [db close];
    return rtn;
}

+ (BOOL)delete:(NSNumber *)system_log_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"DELETE FROM client_system_log WHERE system_log_id = ?", system_log_id];
    [db close];
    return rtn;
}

+ (BOOL)deleteList:(NSString *)where
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    NSString *strSql = [NSString stringWithFormat:@"DELETE FROM client_system_log WHERE %@", where];
    rtn = [db executeUpdate:strSql];
    [db close];
    return rtn;
}

+ (client_system_log *)get:(NSNumber *)system_log_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    client_system_log *rtn;
    FMResultSet *result = [db executeQuery:@"SELECT * FROM client_system_log WHERE system_log_id = ?", system_log_id];
    while ([result next]) {
        rtn = [[client_system_log alloc] init];
        rtn.system_log_id = [NSNumber numberWithInt:[result intForColumn:@"system_log_id"]];
        rtn.log_level = [result stringForColumn:@"log_level"];
        rtn.log_user_name = [result stringForColumn:@"log_user_name"];
        rtn.log_module = [result stringForColumn:@"log_module"];
        rtn.log_operation = [result stringForColumn:@"log_operation"];
        rtn.log_time = [result dateForColumn:@"log_time"];
        rtn.log_message = [result stringForColumn:@"log_message"];
        rtn.log_error = [result stringForColumn:@"log_error"];
        rtn.log_upload = [NSNumber numberWithInt:[result intForColumn:@"log_upload"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_system_log WHERE %@", where];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_system_log *rtn = [[client_system_log alloc] init];
        rtn.system_log_id = [NSNumber numberWithInt:[result intForColumn:@"system_log_id"]];
        rtn.log_level = [result stringForColumn:@"log_level"];
        rtn.log_user_name = [result stringForColumn:@"log_user_name"];
        rtn.log_module = [result stringForColumn:@"log_module"];
        rtn.log_operation = [result stringForColumn:@"log_operation"];
        rtn.log_time = [result dateForColumn:@"log_time"];
        rtn.log_message = [result stringForColumn:@"log_message"];
        rtn.log_error = [result stringForColumn:@"log_error"];
        rtn.log_upload = [NSNumber numberWithInt:[result intForColumn:@"log_upload"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_system_log WHERE %@ ORDER BY %@", where, order];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_system_log *rtn = [[client_system_log alloc] init];
        rtn.system_log_id = [NSNumber numberWithInt:[result intForColumn:@"system_log_id"]];
        rtn.log_level = [result stringForColumn:@"log_level"];
        rtn.log_user_name = [result stringForColumn:@"log_user_name"];
        rtn.log_module = [result stringForColumn:@"log_module"];
        rtn.log_operation = [result stringForColumn:@"log_operation"];
        rtn.log_time = [result dateForColumn:@"log_time"];
        rtn.log_message = [result stringForColumn:@"log_message"];
        rtn.log_error = [result stringForColumn:@"log_error"];
        rtn.log_upload = [NSNumber numberWithInt:[result intForColumn:@"log_upload"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_system_log WHERE %@ ORDER BY %@ LIMIT 0,%d", where, order, top];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_system_log *rtn = [[client_system_log alloc] init];
        rtn.system_log_id = [NSNumber numberWithInt:[result intForColumn:@"system_log_id"]];
        rtn.log_level = [result stringForColumn:@"log_level"];
        rtn.log_user_name = [result stringForColumn:@"log_user_name"];
        rtn.log_module = [result stringForColumn:@"log_module"];
        rtn.log_operation = [result stringForColumn:@"log_operation"];
        rtn.log_time = [result dateForColumn:@"log_time"];
        rtn.log_message = [result stringForColumn:@"log_message"];
        rtn.log_error = [result stringForColumn:@"log_error"];
        rtn.log_upload = [NSNumber numberWithInt:[result intForColumn:@"log_upload"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_system_log WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_system_log *rtn = [[client_system_log alloc] init];
        rtn.system_log_id = [NSNumber numberWithInt:[result intForColumn:@"system_log_id"]];
        rtn.log_level = [result stringForColumn:@"log_level"];
        rtn.log_user_name = [result stringForColumn:@"log_user_name"];
        rtn.log_module = [result stringForColumn:@"log_module"];
        rtn.log_operation = [result stringForColumn:@"log_operation"];
        rtn.log_time = [result dateForColumn:@"log_time"];
        rtn.log_message = [result stringForColumn:@"log_message"];
        rtn.log_error = [result stringForColumn:@"log_error"];
        rtn.log_upload = [NSNumber numberWithInt:[result intForColumn:@"log_upload"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_system_log WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_system_log *rtn = [[client_system_log alloc] init];
        rtn.system_log_id = [NSNumber numberWithInt:[result intForColumn:@"system_log_id"]];
        rtn.log_level = [result stringForColumn:@"log_level"];
        rtn.log_user_name = [result stringForColumn:@"log_user_name"];
        rtn.log_module = [result stringForColumn:@"log_module"];
        rtn.log_operation = [result stringForColumn:@"log_operation"];
        rtn.log_time = [result dateForColumn:@"log_time"];
        rtn.log_message = [result stringForColumn:@"log_message"];
        rtn.log_error = [result stringForColumn:@"log_error"];
        rtn.log_upload = [NSNumber numberWithInt:[result intForColumn:@"log_upload"]];
        [array addObject:rtn];
    }
    [db close];
    return array;
}

+ (client_system_log *)convertJsonToModel:(NSDictionary *)json
{
    client_system_log *model = [[client_system_log alloc] init];
    model.system_log_id = [json objectForKey:@"system_log_id"];
    model.log_level = [json objectForKey:@"log_level"];
    model.log_user_name = [json objectForKey:@"log_user_name"];
    model.log_module = [json objectForKey:@"log_module"];
    model.log_operation = [json objectForKey:@"log_operation"];
    model.log_time =[BaseInfo getDateFromMSDateString:[json objectForKey:@"log_time"]];
    model.log_message = [json objectForKey:@"log_message"];
    model.log_error = [json objectForKey:@"log_error"];
    model.log_upload = [json objectForKey:@"log_upload"];
    return model;
}

+ (NSArray *)convertJsonToList:(NSArray *)jsons
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSDictionary *json in jsons) {
        client_system_log *model = [[client_system_log alloc] init];
        model.system_log_id = [json objectForKey:@"system_log_id"];
        model.log_level = [json objectForKey:@"log_level"];
        model.log_user_name = [json objectForKey:@"log_user_name"];
        model.log_module = [json objectForKey:@"log_module"];
        model.log_operation = [json objectForKey:@"log_operation"];
        model.log_time =[BaseInfo getDateFromMSDateString:[json objectForKey:@"log_time"]];
        model.log_message = [json objectForKey:@"log_message"];
        model.log_error = [json objectForKey:@"log_error"];
        model.log_upload = [json objectForKey:@"log_upload"];
        [array addObject:model];
    }
    return array;
}

@end