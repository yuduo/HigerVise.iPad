#import "client_vehicle_hot_dal.h"

@implementation client_vehicle_hot_dal

+ (NSNumber *)getMaxId
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    NSNumber *rtn;
    FMResultSet *result = [db executeQuery:@"SELECT MAX(vehicle_hot_id) FROM client_vehicle_hot"];
    if ([result next]) {
        int maxId = [result intForColumnIndex:0] + 1;
        rtn = [NSNumber numberWithInt:maxId];
    }
    [db close];
    return rtn;
}

+ (BOOL)exists:(NSNumber *)vehicle_hot_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    FMResultSet *result = [db executeQuery:@"SELECT COUNT(vehicle_hot_id) FROM client_vehicle_hot WHERE vehicle_hot_id = ?", vehicle_hot_id];
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

+ (BOOL)add:(client_vehicle_hot *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"INSERT INTO client_vehicle_hot (vehicle_hot_id, vehicle_configurator_id, vehicle_code, data_version) VALUES (?, ?, ?, ?)", model.vehicle_hot_id, model.vehicle_configurator_id, model.vehicle_code, model.data_version];
    [db close];
    return rtn;
}

+ (BOOL)update:(client_vehicle_hot *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"UPDATE client_vehicle_hot SET vehicle_configurator_id = ?, vehicle_code = ?, data_version = ? WHERE vehicle_hot_id = ?", model.vehicle_configurator_id, model.vehicle_code, model.data_version, model.vehicle_hot_id];
    [db close];
    return rtn;
}

+ (BOOL)delete:(NSNumber *)vehicle_hot_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"DELETE FROM client_vehicle_hot WHERE vehicle_hot_id = ?", vehicle_hot_id];
    [db close];
    return rtn;
}

+ (BOOL)deleteList:(NSString *)where
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    NSString *strSql = [NSString stringWithFormat:@"DELETE FROM client_vehicle_hot WHERE %@", where];
    rtn = [db executeUpdate:strSql];
    [db close];
    return rtn;
}

+ (client_vehicle_hot *)get:(NSNumber *)vehicle_hot_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    client_vehicle_hot *rtn;
    FMResultSet *result = [db executeQuery:@"SELECT * FROM client_vehicle_hot WHERE vehicle_hot_id = ?", vehicle_hot_id];
    while ([result next]) {
        rtn = [[client_vehicle_hot alloc] init];
        rtn.vehicle_hot_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_hot_id"]];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_code = [result stringForColumn:@"vehicle_code"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_vehicle_hot WHERE %@", where];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_vehicle_hot *rtn = [[client_vehicle_hot alloc] init];
        rtn.vehicle_hot_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_hot_id"]];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_code = [result stringForColumn:@"vehicle_code"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_vehicle_hot WHERE %@ ORDER BY %@", where, order];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_vehicle_hot *rtn = [[client_vehicle_hot alloc] init];
        rtn.vehicle_hot_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_hot_id"]];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_code = [result stringForColumn:@"vehicle_code"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_vehicle_hot WHERE %@ ORDER BY %@ LIMIT 0,%d", where, order, top];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_vehicle_hot *rtn = [[client_vehicle_hot alloc] init];
        rtn.vehicle_hot_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_hot_id"]];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_code = [result stringForColumn:@"vehicle_code"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_vehicle_hot WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_vehicle_hot *rtn = [[client_vehicle_hot alloc] init];
        rtn.vehicle_hot_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_hot_id"]];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_code = [result stringForColumn:@"vehicle_code"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_vehicle_hot WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_vehicle_hot *rtn = [[client_vehicle_hot alloc] init];
        rtn.vehicle_hot_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_hot_id"]];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_code = [result stringForColumn:@"vehicle_code"];
        rtn.data_version = [NSNumber numberWithInt:[result intForColumn:@"data_version"]];
        [array addObject:rtn];
    }
    [db close];
    return array;
}

+ (client_vehicle_hot *)convertJsonToModel:(NSDictionary *)json
{
    client_vehicle_hot *model = [[client_vehicle_hot alloc] init];
    model.vehicle_hot_id = [json objectForKey:@"vehicle_hot_id"];
    model.vehicle_configurator_id = [json objectForKey:@"vehicle_configurator_id"];
    model.vehicle_code = [json objectForKey:@"vehicle_code"];
    model.data_version = [json objectForKey:@"data_version"];
    return model;
}

+ (NSArray *)convertJsonToList:(NSArray *)jsons
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSDictionary *json in jsons) {
        client_vehicle_hot *model = [[client_vehicle_hot alloc] init];
        model.vehicle_hot_id = [json objectForKey:@"vehicle_hot_id"];
        model.vehicle_configurator_id = [json objectForKey:@"vehicle_configurator_id"];
        model.vehicle_code = [json objectForKey:@"vehicle_code"];
        model.data_version = [json objectForKey:@"data_version"];
        [array addObject:model];
    }
    return array;
}

@end