#import "client_vehicle_setting_relation_dal.h"

@implementation client_vehicle_setting_relation_dal

+ (NSNumber *)getMaxId
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    NSNumber *rtn;
    FMResultSet *result = [db executeQuery:@"SELECT MAX(vehicle_setting_relation_id) FROM client_vehicle_setting_relation"];
    if ([result next]) {
        int maxId = [result intForColumnIndex:0] + 1;
        rtn = [NSNumber numberWithInt:maxId];
    }
    [db close];
    return rtn;
}

+ (BOOL)exists:(NSNumber *)vehicle_setting_relation_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    FMResultSet *result = [db executeQuery:@"SELECT COUNT(vehicle_setting_relation_id) FROM client_vehicle_setting_relation WHERE vehicle_setting_relation_id = ?", vehicle_setting_relation_id];
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

+ (BOOL)add:(client_vehicle_setting_relation *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"INSERT INTO client_vehicle_setting_relation (vehicle_setting_relation_id, vehicle_configurator_id, master_op_code, master_op_value_code, slave_op_code, slave_op_value_code, relation_type, tech_sale_relation, data_version) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)", model.vehicle_setting_relation_id, model.vehicle_configurator_id, model.master_op_code, model.master_op_value_code, model.slave_op_code, model.slave_op_value_code, model.relation_type, model.tech_sale_relation, model.data_version];
    [db close];
    return rtn;
}

+ (BOOL)update:(client_vehicle_setting_relation *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"UPDATE client_vehicle_setting_relation SET vehicle_configurator_id = ?, master_op_code = ?, master_op_value_code = ?, slave_op_code = ?, slave_op_value_code = ?, relation_type = ?, tech_sale_relation = ?, data_version = ? WHERE vehicle_setting_relation_id = ?", model.vehicle_configurator_id, model.master_op_code, model.master_op_value_code, model.slave_op_code, model.slave_op_value_code, model.relation_type, model.tech_sale_relation, model.data_version, model.vehicle_setting_relation_id];
    [db close];
    return rtn;
}

+ (BOOL)delete:(NSNumber *)vehicle_setting_relation_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"DELETE FROM client_vehicle_setting_relation WHERE vehicle_setting_relation_id = ?", vehicle_setting_relation_id];
    [db close];
    return rtn;
}

+ (BOOL)deleteList:(NSString *)where
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    NSString *strSql = [NSString stringWithFormat:@"DELETE FROM client_vehicle_setting_relation WHERE %@", where];
    rtn = [db executeUpdate:strSql];
    [db close];
    return rtn;
}

+ (client_vehicle_setting_relation *)get:(NSNumber *)vehicle_setting_relation_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    client_vehicle_setting_relation *rtn;
    FMResultSet *result = [db executeQuery:@"SELECT * FROM client_vehicle_setting_relation WHERE vehicle_setting_relation_id = ?", vehicle_setting_relation_id];
    while ([result next]) {
        rtn = [[client_vehicle_setting_relation alloc] init];
        rtn.vehicle_setting_relation_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_setting_relation_id"]];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.master_op_code = [result stringForColumn:@"master_op_code"];
        rtn.master_op_value_code = [result stringForColumn:@"master_op_value_code"];
        rtn.slave_op_code = [result stringForColumn:@"slave_op_code"];
        rtn.slave_op_value_code = [result stringForColumn:@"slave_op_value_code"];
        rtn.relation_type = [NSNumber numberWithInt:[result intForColumn:@"relation_type"]];
        rtn.tech_sale_relation = [NSNumber numberWithInt:[result intForColumn:@"tech_sale_relation"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_vehicle_setting_relation WHERE %@", where];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_vehicle_setting_relation *rtn = [[client_vehicle_setting_relation alloc] init];
        rtn.vehicle_setting_relation_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_setting_relation_id"]];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.master_op_code = [result stringForColumn:@"master_op_code"];
        rtn.master_op_value_code = [result stringForColumn:@"master_op_value_code"];
        rtn.slave_op_code = [result stringForColumn:@"slave_op_code"];
        rtn.slave_op_value_code = [result stringForColumn:@"slave_op_value_code"];
        rtn.relation_type = [NSNumber numberWithInt:[result intForColumn:@"relation_type"]];
        rtn.tech_sale_relation = [NSNumber numberWithInt:[result intForColumn:@"tech_sale_relation"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_vehicle_setting_relation WHERE %@ ORDER BY %@", where, order];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_vehicle_setting_relation *rtn = [[client_vehicle_setting_relation alloc] init];
        rtn.vehicle_setting_relation_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_setting_relation_id"]];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.master_op_code = [result stringForColumn:@"master_op_code"];
        rtn.master_op_value_code = [result stringForColumn:@"master_op_value_code"];
        rtn.slave_op_code = [result stringForColumn:@"slave_op_code"];
        rtn.slave_op_value_code = [result stringForColumn:@"slave_op_value_code"];
        rtn.relation_type = [NSNumber numberWithInt:[result intForColumn:@"relation_type"]];
        rtn.tech_sale_relation = [NSNumber numberWithInt:[result intForColumn:@"tech_sale_relation"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_vehicle_setting_relation WHERE %@ ORDER BY %@ LIMIT 0,%d", where, order, top];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_vehicle_setting_relation *rtn = [[client_vehicle_setting_relation alloc] init];
        rtn.vehicle_setting_relation_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_setting_relation_id"]];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.master_op_code = [result stringForColumn:@"master_op_code"];
        rtn.master_op_value_code = [result stringForColumn:@"master_op_value_code"];
        rtn.slave_op_code = [result stringForColumn:@"slave_op_code"];
        rtn.slave_op_value_code = [result stringForColumn:@"slave_op_value_code"];
        rtn.relation_type = [NSNumber numberWithInt:[result intForColumn:@"relation_type"]];
        rtn.tech_sale_relation = [NSNumber numberWithInt:[result intForColumn:@"tech_sale_relation"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_vehicle_setting_relation WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_vehicle_setting_relation *rtn = [[client_vehicle_setting_relation alloc] init];
        rtn.vehicle_setting_relation_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_setting_relation_id"]];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.master_op_code = [result stringForColumn:@"master_op_code"];
        rtn.master_op_value_code = [result stringForColumn:@"master_op_value_code"];
        rtn.slave_op_code = [result stringForColumn:@"slave_op_code"];
        rtn.slave_op_value_code = [result stringForColumn:@"slave_op_value_code"];
        rtn.relation_type = [NSNumber numberWithInt:[result intForColumn:@"relation_type"]];
        rtn.tech_sale_relation = [NSNumber numberWithInt:[result intForColumn:@"tech_sale_relation"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_vehicle_setting_relation WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_vehicle_setting_relation *rtn = [[client_vehicle_setting_relation alloc] init];
        rtn.vehicle_setting_relation_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_setting_relation_id"]];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.master_op_code = [result stringForColumn:@"master_op_code"];
        rtn.master_op_value_code = [result stringForColumn:@"master_op_value_code"];
        rtn.slave_op_code = [result stringForColumn:@"slave_op_code"];
        rtn.slave_op_value_code = [result stringForColumn:@"slave_op_value_code"];
        rtn.relation_type = [NSNumber numberWithInt:[result intForColumn:@"relation_type"]];
        rtn.tech_sale_relation = [NSNumber numberWithInt:[result intForColumn:@"tech_sale_relation"]];
        rtn.data_version = [NSNumber numberWithInt:[result intForColumn:@"data_version"]];
        [array addObject:rtn];
    }
    [db close];
    return array;
}

+ (client_vehicle_setting_relation *)convertJsonToModel:(NSDictionary *)json
{
    client_vehicle_setting_relation *model = [[client_vehicle_setting_relation alloc] init];
    model.vehicle_setting_relation_id = [json objectForKey:@"vehicle_setting_relation_id"];
    model.vehicle_configurator_id = [json objectForKey:@"vehicle_configurator_id"];
    model.master_op_code = [json objectForKey:@"master_op_code"];
    model.master_op_value_code = [json objectForKey:@"master_op_value_code"];
    model.slave_op_code = [json objectForKey:@"slave_op_code"];
    model.slave_op_value_code = [json objectForKey:@"slave_op_value_code"];
    model.relation_type = [json objectForKey:@"relation_type"];
    model.tech_sale_relation = [json objectForKey:@"tech_sale_relation"];
    model.data_version = [json objectForKey:@"data_version"];
    return model;
}

+ (NSArray *)convertJsonToList:(NSArray *)jsons
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSDictionary *json in jsons) {
        client_vehicle_setting_relation *model = [[client_vehicle_setting_relation alloc] init];
        model.vehicle_setting_relation_id = [json objectForKey:@"vehicle_setting_relation_id"];
        model.vehicle_configurator_id = [json objectForKey:@"vehicle_configurator_id"];
        model.master_op_code = [json objectForKey:@"master_op_code"];
        model.master_op_value_code = [json objectForKey:@"master_op_value_code"];
        model.slave_op_code = [json objectForKey:@"slave_op_code"];
        model.slave_op_value_code = [json objectForKey:@"slave_op_value_code"];
        model.relation_type = [json objectForKey:@"relation_type"];
        model.tech_sale_relation = [json objectForKey:@"tech_sale_relation"];
        model.data_version = [json objectForKey:@"data_version"];
        [array addObject:model];
    }
    return array;
}

@end