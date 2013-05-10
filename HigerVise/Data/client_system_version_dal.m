#import "client_system_version_dal.h"

@implementation client_system_version_dal

+ (NSNumber *)getMaxId
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    NSNumber *rtn;
    FMResultSet *result = [db executeQuery:@"SELECT MAX(system_version_id) FROM client_system_version"];
    if ([result next]) {
        int maxId = [result intForColumnIndex:0] + 1;
        rtn = [NSNumber numberWithInt:maxId];
    }
    [db close];
    return rtn;
}

+ (BOOL)exists:(NSNumber *)system_version_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    FMResultSet *result = [db executeQuery:@"SELECT COUNT(system_version_id) FROM client_system_version WHERE system_version_id = ?", system_version_id];
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

+ (BOOL)add:(client_system_version *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"INSERT INTO client_system_version (system_version_id, vehicle_configurator_id, vehicle_code, system_version, version_desc, create_userid, create_time, update_userid, update_time, data_version) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", model.system_version_id, model.vehicle_configurator_id, model.vehicle_code, model.system_version, model.version_desc, model.create_userid, model.create_time, model.update_userid, model.update_time, model.data_version];
    [db close];
    return rtn;
}

+ (BOOL)update:(client_system_version *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"UPDATE client_system_version SET vehicle_configurator_id = ?, vehicle_code = ?, system_version = ?, version_desc = ?, create_userid = ?, create_time = ?, update_userid = ?, update_time = ?, data_version = ? WHERE system_version_id = ?", model.vehicle_configurator_id, model.vehicle_code, model.system_version, model.version_desc, model.create_userid, model.create_time, model.update_userid, model.update_time, model.data_version, model.system_version_id];
    [db close];
    return rtn;
}

+ (BOOL)delete:(NSNumber *)system_version_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"DELETE FROM client_system_version WHERE system_version_id = ?", system_version_id];
    [db close];
    return rtn;
}

+ (BOOL)deleteList:(NSString *)where
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    NSString *strSql = [NSString stringWithFormat:@"DELETE FROM client_system_version WHERE %@", where];
    rtn = [db executeUpdate:strSql];
    [db close];
    return rtn;
}

+ (client_system_version *)get:(NSNumber *)system_version_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    client_system_version *rtn;
    FMResultSet *result = [db executeQuery:@"SELECT * FROM client_system_version WHERE system_version_id = ?", system_version_id];
    while ([result next]) {
        rtn = [[client_system_version alloc] init];
        rtn.system_version_id = [NSNumber numberWithInt:[result intForColumn:@"system_version_id"]];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_code = [result stringForColumn:@"vehicle_code"];
        rtn.system_version = [NSNumber numberWithInt:[result intForColumn:@"system_version"]];
        rtn.version_desc = [result stringForColumn:@"version_desc"];
        rtn.create_userid = [result stringForColumn:@"create_userid"];
        rtn.create_time = [result dateForColumn:@"create_time"];
        rtn.update_userid = [result stringForColumn:@"update_userid"];
        rtn.update_time = [result dateForColumn:@"update_time"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_system_version WHERE %@", where];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_system_version *rtn = [[client_system_version alloc] init];
        rtn.system_version_id = [NSNumber numberWithInt:[result intForColumn:@"system_version_id"]];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_code = [result stringForColumn:@"vehicle_code"];
        rtn.system_version = [NSNumber numberWithInt:[result intForColumn:@"system_version"]];
        rtn.version_desc = [result stringForColumn:@"version_desc"];
        rtn.create_userid = [result stringForColumn:@"create_userid"];
        rtn.create_time = [result dateForColumn:@"create_time"];
        rtn.update_userid = [result stringForColumn:@"update_userid"];
        rtn.update_time = [result dateForColumn:@"update_time"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_system_version WHERE %@ ORDER BY %@", where, order];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_system_version *rtn = [[client_system_version alloc] init];
        rtn.system_version_id = [NSNumber numberWithInt:[result intForColumn:@"system_version_id"]];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_code = [result stringForColumn:@"vehicle_code"];
        rtn.system_version = [NSNumber numberWithInt:[result intForColumn:@"system_version"]];
        rtn.version_desc = [result stringForColumn:@"version_desc"];
        rtn.create_userid = [result stringForColumn:@"create_userid"];
        rtn.create_time = [result dateForColumn:@"create_time"];
        rtn.update_userid = [result stringForColumn:@"update_userid"];
        rtn.update_time = [result dateForColumn:@"update_time"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_system_version WHERE %@ ORDER BY %@ LIMIT 0,%d", where, order, top];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_system_version *rtn = [[client_system_version alloc] init];
        rtn.system_version_id = [NSNumber numberWithInt:[result intForColumn:@"system_version_id"]];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_code = [result stringForColumn:@"vehicle_code"];
        rtn.system_version = [NSNumber numberWithInt:[result intForColumn:@"system_version"]];
        rtn.version_desc = [result stringForColumn:@"version_desc"];
        rtn.create_userid = [result stringForColumn:@"create_userid"];
        rtn.create_time = [result dateForColumn:@"create_time"];
        rtn.update_userid = [result stringForColumn:@"update_userid"];
        rtn.update_time = [result dateForColumn:@"update_time"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_system_version WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_system_version *rtn = [[client_system_version alloc] init];
        rtn.system_version_id = [NSNumber numberWithInt:[result intForColumn:@"system_version_id"]];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_code = [result stringForColumn:@"vehicle_code"];
        rtn.system_version = [NSNumber numberWithInt:[result intForColumn:@"system_version"]];
        rtn.version_desc = [result stringForColumn:@"version_desc"];
        rtn.create_userid = [result stringForColumn:@"create_userid"];
        rtn.create_time = [result dateForColumn:@"create_time"];
        rtn.update_userid = [result stringForColumn:@"update_userid"];
        rtn.update_time = [result dateForColumn:@"update_time"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_system_version WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_system_version *rtn = [[client_system_version alloc] init];
        rtn.system_version_id = [NSNumber numberWithInt:[result intForColumn:@"system_version_id"]];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_code = [result stringForColumn:@"vehicle_code"];
        rtn.system_version = [NSNumber numberWithInt:[result intForColumn:@"system_version"]];
        rtn.version_desc = [result stringForColumn:@"version_desc"];
        rtn.create_userid = [result stringForColumn:@"create_userid"];
        rtn.create_time = [result dateForColumn:@"create_time"];
        rtn.update_userid = [result stringForColumn:@"update_userid"];
        rtn.update_time = [result dateForColumn:@"update_time"];
        rtn.data_version = [NSNumber numberWithInt:[result intForColumn:@"data_version"]];
        [array addObject:rtn];
    }
    [db close];
    return array;
}

+ (client_system_version *)convertJsonToModel:(NSDictionary *)json
{
    client_system_version *model = [[client_system_version alloc] init];
    model.system_version_id = [json objectForKey:@"system_version_id"];
    model.vehicle_configurator_id = [json objectForKey:@"vehicle_configurator_id"];
    model.vehicle_code = [json objectForKey:@"vehicle_code"];
    model.system_version = [json objectForKey:@"system_version"];
    model.version_desc = [json objectForKey:@"version_desc"];
    model.create_userid = [json objectForKey:@"create_userid"];
    model.create_time =[BaseInfo getDateFromMSDateString:[json objectForKey:@"create_time"]];
    model.update_userid = [json objectForKey:@"update_userid"];
    model.update_time =[BaseInfo getDateFromMSDateString:[json objectForKey:@"update_time"]];
    model.data_version = [json objectForKey:@"data_version"];
    return model;
}

+ (NSArray *)convertJsonToList:(NSArray *)jsons
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSDictionary *json in jsons) {
        client_system_version *model = [[client_system_version alloc] init];
        model.system_version_id = [json objectForKey:@"system_version_id"];
        model.vehicle_configurator_id = [json objectForKey:@"vehicle_configurator_id"];
        model.vehicle_code = [json objectForKey:@"vehicle_code"];
        model.system_version = [json objectForKey:@"system_version"];
        model.version_desc = [json objectForKey:@"version_desc"];
        model.create_userid = [json objectForKey:@"create_userid"];
        model.create_time =[BaseInfo getDateFromMSDateString:[json objectForKey:@"create_time"]];
        model.update_userid = [json objectForKey:@"update_userid"];
        model.update_time =[BaseInfo getDateFromMSDateString:[json objectForKey:@"update_time"]];
        model.data_version = [json objectForKey:@"data_version"];
        [array addObject:model];
    }
    return array;
}

+ (NSArray *)getListForIndex:(NSString *)where
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSString *strSql = [NSString stringWithFormat:@"SELECT system_version_id, vehicle_configurator_id, vehicle_code, system_version, version_desc FROM client_system_version WHERE %@ ORDER BY data_version DESC", where];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_system_version *rtn = [[client_system_version alloc] init];
        rtn.system_version_id = [NSNumber numberWithInt:[result intForColumn:@"system_version_id"]];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_code = [result stringForColumn:@"vehicle_code"];
        rtn.system_version = [NSNumber numberWithInt:[result intForColumn:@"system_version"]];
        rtn.version_desc = [result stringForColumn:@"version_desc"];
        //rtn.create_userid = [result stringForColumn:@"create_userid"];
        //rtn.create_time = [result dateForColumn:@"create_time"];
        //rtn.update_userid = [result stringForColumn:@"update_userid"];
        //rtn.update_time = [result dateForColumn:@"update_time"];
        //rtn.data_version = [NSNumber numberWithInt:[result intForColumn:@"data_version"]];
        [array addObject:rtn];
    }
    [db close];
    return array;
}

@end