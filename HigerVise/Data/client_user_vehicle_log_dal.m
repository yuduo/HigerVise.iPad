#import "client_user_vehicle_log_dal.h"

@implementation client_user_vehicle_log_dal

+ (NSNumber *)getMaxId
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    NSNumber *rtn;
    FMResultSet *result = [db executeQuery:@"SELECT MAX(user_vehicle_log_id) FROM client_user_vehicle_log"];
    if ([result next]) {
        int maxId = [result intForColumnIndex:0] + 1;
        rtn = [NSNumber numberWithInt:maxId];
    }
    [db close];
    return rtn;
}

+ (BOOL)exists:(NSNumber *)user_vehicle_log_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    FMResultSet *result = [db executeQuery:@"SELECT COUNT(user_vehicle_log_id) FROM client_user_vehicle_log WHERE user_vehicle_log_id = ?", user_vehicle_log_id];
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

+ (BOOL)add:(client_user_vehicle_log *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"INSERT INTO client_user_vehicle_log (user_vehicle_log_id, user_name, ipad_mac_address, vehicle_configurator_id, vehicle_code, click_count, click_last_time) VALUES (?, ?, ?, ?, ?, ?, ?)", model.user_vehicle_log_id, model.user_name, model.ipad_mac_address, model.vehicle_configurator_id, model.vehicle_code, model.click_count, model.click_last_time];
    [db close];
    return rtn;
}

+ (BOOL)update:(client_user_vehicle_log *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"UPDATE client_user_vehicle_log SET user_name = ?, ipad_mac_address = ?, vehicle_configurator_id = ?, vehicle_code = ?, click_count = ?, click_last_time = ? WHERE user_vehicle_log_id = ?", model.user_name, model.ipad_mac_address, model.vehicle_configurator_id, model.vehicle_code, model.click_count, model.click_last_time, model.user_vehicle_log_id];
    [db close];
    return rtn;
}

+ (BOOL)delete:(NSNumber *)user_vehicle_log_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"DELETE FROM client_user_vehicle_log WHERE user_vehicle_log_id = ?", user_vehicle_log_id];
    [db close];
    return rtn;
}

+ (BOOL)deleteList:(NSString *)where
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    NSString *strSql = [NSString stringWithFormat:@"DELETE FROM client_user_vehicle_log WHERE %@", where];
    rtn = [db executeUpdate:strSql];
    [db close];
    return rtn;
}

+ (client_user_vehicle_log *)get:(NSNumber *)user_vehicle_log_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    client_user_vehicle_log *rtn;
    FMResultSet *result = [db executeQuery:@"SELECT * FROM client_user_vehicle_log WHERE user_vehicle_log_id = ?", user_vehicle_log_id];
    while ([result next]) {
        rtn = [[client_user_vehicle_log alloc] init];
        rtn.user_vehicle_log_id = [NSNumber numberWithInt:[result intForColumn:@"user_vehicle_log_id"]];
        rtn.user_name = [result stringForColumn:@"user_name"];
        rtn.ipad_mac_address = [result stringForColumn:@"ipad_mac_address"];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_code = [result stringForColumn:@"vehicle_code"];
        rtn.click_count = [NSNumber numberWithInt:[result intForColumn:@"click_count"]];
        rtn.click_last_time = [result dateForColumn:@"click_last_time"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_user_vehicle_log WHERE %@", where];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_user_vehicle_log *rtn = [[client_user_vehicle_log alloc] init];
        rtn.user_vehicle_log_id = [NSNumber numberWithInt:[result intForColumn:@"user_vehicle_log_id"]];
        rtn.user_name = [result stringForColumn:@"user_name"];
        rtn.ipad_mac_address = [result stringForColumn:@"ipad_mac_address"];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_code = [result stringForColumn:@"vehicle_code"];
        rtn.click_count = [NSNumber numberWithInt:[result intForColumn:@"click_count"]];
        rtn.click_last_time = [result dateForColumn:@"click_last_time"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_user_vehicle_log WHERE %@ ORDER BY %@", where, order];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_user_vehicle_log *rtn = [[client_user_vehicle_log alloc] init];
        rtn.user_vehicle_log_id = [NSNumber numberWithInt:[result intForColumn:@"user_vehicle_log_id"]];
        rtn.user_name = [result stringForColumn:@"user_name"];
        rtn.ipad_mac_address = [result stringForColumn:@"ipad_mac_address"];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_code = [result stringForColumn:@"vehicle_code"];
        rtn.click_count = [NSNumber numberWithInt:[result intForColumn:@"click_count"]];
        rtn.click_last_time = [result dateForColumn:@"click_last_time"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_user_vehicle_log WHERE %@ ORDER BY %@ LIMIT 0,%d", where, order, top];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_user_vehicle_log *rtn = [[client_user_vehicle_log alloc] init];
        rtn.user_vehicle_log_id = [NSNumber numberWithInt:[result intForColumn:@"user_vehicle_log_id"]];
        rtn.user_name = [result stringForColumn:@"user_name"];
        rtn.ipad_mac_address = [result stringForColumn:@"ipad_mac_address"];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_code = [result stringForColumn:@"vehicle_code"];
        rtn.click_count = [NSNumber numberWithInt:[result intForColumn:@"click_count"]];
        rtn.click_last_time = [result dateForColumn:@"click_last_time"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_user_vehicle_log WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_user_vehicle_log *rtn = [[client_user_vehicle_log alloc] init];
        rtn.user_vehicle_log_id = [NSNumber numberWithInt:[result intForColumn:@"user_vehicle_log_id"]];
        rtn.user_name = [result stringForColumn:@"user_name"];
        rtn.ipad_mac_address = [result stringForColumn:@"ipad_mac_address"];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_code = [result stringForColumn:@"vehicle_code"];
        rtn.click_count = [NSNumber numberWithInt:[result intForColumn:@"click_count"]];
        rtn.click_last_time = [result dateForColumn:@"click_last_time"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_user_vehicle_log WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_user_vehicle_log *rtn = [[client_user_vehicle_log alloc] init];
        rtn.user_vehicle_log_id = [NSNumber numberWithInt:[result intForColumn:@"user_vehicle_log_id"]];
        rtn.user_name = [result stringForColumn:@"user_name"];
        rtn.ipad_mac_address = [result stringForColumn:@"ipad_mac_address"];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_code = [result stringForColumn:@"vehicle_code"];
        rtn.click_count = [NSNumber numberWithInt:[result intForColumn:@"click_count"]];
        rtn.click_last_time = [result dateForColumn:@"click_last_time"];
        [array addObject:rtn];
    }
    [db close];
    return array;
}

+ (client_user_vehicle_log *)convertJsonToModel:(NSDictionary *)json
{
    client_user_vehicle_log *model = [[client_user_vehicle_log alloc] init];
    model.user_vehicle_log_id = [json objectForKey:@"user_vehicle_log_id"];
    model.user_name = [json objectForKey:@"user_name"];
    model.ipad_mac_address = [json objectForKey:@"ipad_mac_address"];
    model.vehicle_configurator_id = [json objectForKey:@"vehicle_configurator_id"];
    model.vehicle_code = [json objectForKey:@"vehicle_code"];
    model.click_count = [json objectForKey:@"click_count"];
    model.click_last_time =[BaseInfo getDateFromMSDateString:[json objectForKey:@"click_last_time"]];
    return model;
}

+ (NSArray *)convertJsonToList:(NSArray *)jsons
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSDictionary *json in jsons) {
        client_user_vehicle_log *model = [[client_user_vehicle_log alloc] init];
        model.user_vehicle_log_id = [json objectForKey:@"user_vehicle_log_id"];
        model.user_name = [json objectForKey:@"user_name"];
        model.ipad_mac_address = [json objectForKey:@"ipad_mac_address"];
        model.vehicle_configurator_id = [json objectForKey:@"vehicle_configurator_id"];
        model.vehicle_code = [json objectForKey:@"vehicle_code"];
        model.click_count = [json objectForKey:@"click_count"];
        model.click_last_time =[BaseInfo getDateFromMSDateString:[json objectForKey:@"click_last_time"]];
        [array addObject:model];
    }
    return array;
}

@end