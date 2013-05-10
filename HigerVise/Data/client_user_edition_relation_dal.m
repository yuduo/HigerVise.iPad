#import "client_user_edition_relation_dal.h"

@implementation client_user_edition_relation_dal

+ (NSNumber *)getMaxId
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    NSNumber *rtn;
    FMResultSet *result = [db executeQuery:@"SELECT MAX(user_edition_relation_id) FROM client_user_edition_relation"];
    if ([result next]) {
        int maxId = [result intForColumnIndex:0] + 1;
        rtn = [NSNumber numberWithInt:maxId];
    }
    [db close];
    return rtn;
}

+ (BOOL)exists:(NSNumber *)user_edition_relation_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    FMResultSet *result = [db executeQuery:@"SELECT COUNT(user_edition_relation_id) FROM client_user_edition_relation WHERE user_edition_relation_id = ?", user_edition_relation_id];
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

+ (BOOL)add:(client_user_edition_relation *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"INSERT INTO client_user_edition_relation (user_edition_relation_id, user_id, user_name, vehicle_configurator_id, vehicle_code, vehicle_edition_id, data_version) VALUES (?, ?, ?, ?, ?, ?, ?)", model.user_edition_relation_id, model.user_id, model.user_name, model.vehicle_configurator_id, model.vehicle_code, model.vehicle_edition_id, model.data_version];
    [db close];
    return rtn;
}

+ (BOOL)update:(client_user_edition_relation *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"UPDATE client_user_edition_relation SET user_id = ?, user_name = ?, vehicle_configurator_id = ?, vehicle_code = ?, vehicle_edition_id = ?, data_version = ? WHERE user_edition_relation_id = ?", model.user_id, model.user_name, model.vehicle_configurator_id, model.vehicle_code, model.vehicle_edition_id, model.data_version, model.user_edition_relation_id];
    [db close];
    return rtn;
}

+ (BOOL)delete:(NSNumber *)user_edition_relation_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"DELETE FROM client_user_edition_relation WHERE user_edition_relation_id = ?", user_edition_relation_id];
    [db close];
    return rtn;
}

+ (BOOL)deleteList:(NSString *)where
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    NSString *strSql = [NSString stringWithFormat:@"DELETE FROM client_user_edition_relation WHERE %@", where];
    rtn = [db executeUpdate:strSql];
    [db close];
    return rtn;
}

+ (client_user_edition_relation *)get:(NSNumber *)user_edition_relation_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    client_user_edition_relation *rtn;
    FMResultSet *result = [db executeQuery:@"SELECT * FROM client_user_edition_relation WHERE user_edition_relation_id = ?", user_edition_relation_id];
    while ([result next]) {
        rtn = [[client_user_edition_relation alloc] init];
        rtn.user_edition_relation_id = [NSNumber numberWithInt:[result intForColumn:@"user_edition_relation_id"]];
        rtn.user_id = [NSNumber numberWithInt:[result intForColumn:@"user_id"]];
        rtn.user_name = [result stringForColumn:@"user_name"];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_code = [result stringForColumn:@"vehicle_code"];
        rtn.vehicle_edition_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_edition_id"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_user_edition_relation WHERE %@", where];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_user_edition_relation *rtn = [[client_user_edition_relation alloc] init];
        rtn.user_edition_relation_id = [NSNumber numberWithInt:[result intForColumn:@"user_edition_relation_id"]];
        rtn.user_id = [NSNumber numberWithInt:[result intForColumn:@"user_id"]];
        rtn.user_name = [result stringForColumn:@"user_name"];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_code = [result stringForColumn:@"vehicle_code"];
        rtn.vehicle_edition_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_edition_id"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_user_edition_relation WHERE %@ ORDER BY %@", where, order];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_user_edition_relation *rtn = [[client_user_edition_relation alloc] init];
        rtn.user_edition_relation_id = [NSNumber numberWithInt:[result intForColumn:@"user_edition_relation_id"]];
        rtn.user_id = [NSNumber numberWithInt:[result intForColumn:@"user_id"]];
        rtn.user_name = [result stringForColumn:@"user_name"];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_code = [result stringForColumn:@"vehicle_code"];
        rtn.vehicle_edition_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_edition_id"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_user_edition_relation WHERE %@ ORDER BY %@ LIMIT 0,%d", where, order, top];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_user_edition_relation *rtn = [[client_user_edition_relation alloc] init];
        rtn.user_edition_relation_id = [NSNumber numberWithInt:[result intForColumn:@"user_edition_relation_id"]];
        rtn.user_id = [NSNumber numberWithInt:[result intForColumn:@"user_id"]];
        rtn.user_name = [result stringForColumn:@"user_name"];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_code = [result stringForColumn:@"vehicle_code"];
        rtn.vehicle_edition_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_edition_id"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_user_edition_relation WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_user_edition_relation *rtn = [[client_user_edition_relation alloc] init];
        rtn.user_edition_relation_id = [NSNumber numberWithInt:[result intForColumn:@"user_edition_relation_id"]];
        rtn.user_id = [NSNumber numberWithInt:[result intForColumn:@"user_id"]];
        rtn.user_name = [result stringForColumn:@"user_name"];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_code = [result stringForColumn:@"vehicle_code"];
        rtn.vehicle_edition_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_edition_id"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_user_edition_relation WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_user_edition_relation *rtn = [[client_user_edition_relation alloc] init];
        rtn.user_edition_relation_id = [NSNumber numberWithInt:[result intForColumn:@"user_edition_relation_id"]];
        rtn.user_id = [NSNumber numberWithInt:[result intForColumn:@"user_id"]];
        rtn.user_name = [result stringForColumn:@"user_name"];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_code = [result stringForColumn:@"vehicle_code"];
        rtn.vehicle_edition_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_edition_id"]];
        rtn.data_version = [NSNumber numberWithInt:[result intForColumn:@"data_version"]];
        [array addObject:rtn];
    }
    [db close];
    return array;
}

+ (client_user_edition_relation *)convertJsonToModel:(NSDictionary *)json
{
    client_user_edition_relation *model = [[client_user_edition_relation alloc] init];
    model.user_edition_relation_id = [json objectForKey:@"user_edition_relation_id"];
    model.user_id = [json objectForKey:@"user_id"];
    model.user_name = [json objectForKey:@"user_name"];
    model.vehicle_configurator_id = [json objectForKey:@"vehicle_configurator_id"];
    model.vehicle_code = [json objectForKey:@"vehicle_code"];
    model.vehicle_edition_id = [json objectForKey:@"vehicle_edition_id"];
    model.data_version = [json objectForKey:@"data_version"];
    return model;
}

+ (NSArray *)convertJsonToList:(NSArray *)jsons
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSDictionary *json in jsons) {
        client_user_edition_relation *model = [[client_user_edition_relation alloc] init];
        model.user_edition_relation_id = [json objectForKey:@"user_edition_relation_id"];
        model.user_id = [json objectForKey:@"user_id"];
        model.user_name = [json objectForKey:@"user_name"];
        model.vehicle_configurator_id = [json objectForKey:@"vehicle_configurator_id"];
        model.vehicle_code = [json objectForKey:@"vehicle_code"];
        model.vehicle_edition_id = [json objectForKey:@"vehicle_edition_id"];
        model.data_version = [json objectForKey:@"data_version"];
        [array addObject:model];
    }
    return array;
}

@end