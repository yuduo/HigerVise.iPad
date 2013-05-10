#import "client_intent_order_setting_dal.h"

@implementation client_intent_order_setting_dal

+ (BOOL)exists:(NSString *)intent_order_setting_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    FMResultSet *result = [db executeQuery:@"SELECT COUNT(intent_order_setting_id) FROM client_intent_order_setting WHERE intent_order_setting_id = ?", intent_order_setting_id];
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

+ (BOOL)add:(client_intent_order_setting *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"INSERT INTO client_intent_order_setting (intent_order_setting_id, intent_order_id, intent_order_code, vehicle_edition_setting_id, op_code, op_group_code, op_value_code, op_value_qty, op_value_price_diff, op_value_original_price_diff, data_version) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", model.intent_order_setting_id, model.intent_order_id, model.intent_order_code, model.vehicle_edition_setting_id, model.op_code, model.op_group_code, model.op_value_code, model.op_value_qty, model.op_value_price_diff, model.op_value_original_price_diff, model.data_version];
    [db close];
    return rtn;
}

+ (BOOL)update:(client_intent_order_setting *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"UPDATE client_intent_order_setting SET intent_order_id = ?, intent_order_code = ?, vehicle_edition_setting_id = ?, op_code = ?, op_group_code = ?, op_value_code = ?, op_value_qty = ?, op_value_price_diff = ?, op_value_original_price_diff = ?, data_version = ? WHERE intent_order_setting_id = ?", model.intent_order_id, model.intent_order_code, model.vehicle_edition_setting_id, model.op_code, model.op_group_code, model.op_value_code, model.op_value_qty, model.op_value_price_diff, model.op_value_original_price_diff, model.data_version, model.intent_order_setting_id];
    [db close];
    return rtn;
}

+ (BOOL)delete:(NSString *)intent_order_setting_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"DELETE FROM client_intent_order_setting WHERE intent_order_setting_id = ?", intent_order_setting_id];
    [db close];
    return rtn;
}

+ (BOOL)deleteList:(NSString *)where
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    NSString *strSql = [NSString stringWithFormat:@"DELETE FROM client_intent_order_setting WHERE %@", where];
    rtn = [db executeUpdate:strSql];
    [db close];
    return rtn;
}

+ (client_intent_order_setting *)get:(NSString *)intent_order_setting_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    client_intent_order_setting *rtn;
    FMResultSet *result = [db executeQuery:@"SELECT * FROM client_intent_order_setting WHERE intent_order_setting_id = ?", intent_order_setting_id];
    while ([result next]) {
        rtn = [[client_intent_order_setting alloc] init];
        rtn.intent_order_setting_id = [result stringForColumn:@"intent_order_setting_id"];
        rtn.intent_order_id = [result stringForColumn:@"intent_order_id"];
        rtn.intent_order_code = [result stringForColumn:@"intent_order_code"];
        rtn.vehicle_edition_setting_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_edition_setting_id"]];
        rtn.op_code = [result stringForColumn:@"op_code"];
        rtn.op_group_code = [result stringForColumn:@"op_group_code"];
        rtn.op_value_code = [result stringForColumn:@"op_value_code"];
        rtn.op_value_qty = [NSNumber numberWithInt:[result intForColumn:@"op_value_qty"]];
        rtn.op_value_price_diff = [NSNumber numberWithDouble:[result doubleForColumn:@"op_value_price_diff"]];
        rtn.op_value_original_price_diff = [NSNumber numberWithDouble:[result doubleForColumn:@"op_value_original_price_diff"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_intent_order_setting WHERE %@", where];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_intent_order_setting *rtn = [[client_intent_order_setting alloc] init];
        rtn.intent_order_setting_id = [result stringForColumn:@"intent_order_setting_id"];
        rtn.intent_order_id = [result stringForColumn:@"intent_order_id"];
        rtn.intent_order_code = [result stringForColumn:@"intent_order_code"];
        rtn.vehicle_edition_setting_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_edition_setting_id"]];
        rtn.op_code = [result stringForColumn:@"op_code"];
        rtn.op_group_code = [result stringForColumn:@"op_group_code"];
        rtn.op_value_code = [result stringForColumn:@"op_value_code"];
        rtn.op_value_qty = [NSNumber numberWithInt:[result intForColumn:@"op_value_qty"]];
        rtn.op_value_price_diff = [NSNumber numberWithDouble:[result doubleForColumn:@"op_value_price_diff"]];
        rtn.op_value_original_price_diff = [NSNumber numberWithDouble:[result doubleForColumn:@"op_value_original_price_diff"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_intent_order_setting WHERE %@ ORDER BY %@", where, order];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_intent_order_setting *rtn = [[client_intent_order_setting alloc] init];
        rtn.intent_order_setting_id = [result stringForColumn:@"intent_order_setting_id"];
        rtn.intent_order_id = [result stringForColumn:@"intent_order_id"];
        rtn.intent_order_code = [result stringForColumn:@"intent_order_code"];
        rtn.vehicle_edition_setting_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_edition_setting_id"]];
        rtn.op_code = [result stringForColumn:@"op_code"];
        rtn.op_group_code = [result stringForColumn:@"op_group_code"];
        rtn.op_value_code = [result stringForColumn:@"op_value_code"];
        rtn.op_value_qty = [NSNumber numberWithInt:[result intForColumn:@"op_value_qty"]];
        rtn.op_value_price_diff = [NSNumber numberWithDouble:[result doubleForColumn:@"op_value_price_diff"]];
        rtn.op_value_original_price_diff = [NSNumber numberWithDouble:[result doubleForColumn:@"op_value_original_price_diff"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_intent_order_setting WHERE %@ ORDER BY %@ LIMIT 0,%d", where, order, top];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_intent_order_setting *rtn = [[client_intent_order_setting alloc] init];
        rtn.intent_order_setting_id = [result stringForColumn:@"intent_order_setting_id"];
        rtn.intent_order_id = [result stringForColumn:@"intent_order_id"];
        rtn.intent_order_code = [result stringForColumn:@"intent_order_code"];
        rtn.vehicle_edition_setting_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_edition_setting_id"]];
        rtn.op_code = [result stringForColumn:@"op_code"];
        rtn.op_group_code = [result stringForColumn:@"op_group_code"];
        rtn.op_value_code = [result stringForColumn:@"op_value_code"];
        rtn.op_value_qty = [NSNumber numberWithInt:[result intForColumn:@"op_value_qty"]];
        rtn.op_value_price_diff = [NSNumber numberWithDouble:[result doubleForColumn:@"op_value_price_diff"]];
        rtn.op_value_original_price_diff = [NSNumber numberWithDouble:[result doubleForColumn:@"op_value_original_price_diff"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_intent_order_setting WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_intent_order_setting *rtn = [[client_intent_order_setting alloc] init];
        rtn.intent_order_setting_id = [result stringForColumn:@"intent_order_setting_id"];
        rtn.intent_order_id = [result stringForColumn:@"intent_order_id"];
        rtn.intent_order_code = [result stringForColumn:@"intent_order_code"];
        rtn.vehicle_edition_setting_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_edition_setting_id"]];
        rtn.op_code = [result stringForColumn:@"op_code"];
        rtn.op_group_code = [result stringForColumn:@"op_group_code"];
        rtn.op_value_code = [result stringForColumn:@"op_value_code"];
        rtn.op_value_qty = [NSNumber numberWithInt:[result intForColumn:@"op_value_qty"]];
        rtn.op_value_price_diff = [NSNumber numberWithDouble:[result doubleForColumn:@"op_value_price_diff"]];
        rtn.op_value_original_price_diff = [NSNumber numberWithDouble:[result doubleForColumn:@"op_value_original_price_diff"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_intent_order_setting WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_intent_order_setting *rtn = [[client_intent_order_setting alloc] init];
        rtn.intent_order_setting_id = [result stringForColumn:@"intent_order_setting_id"];
        rtn.intent_order_id = [result stringForColumn:@"intent_order_id"];
        rtn.intent_order_code = [result stringForColumn:@"intent_order_code"];
        rtn.vehicle_edition_setting_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_edition_setting_id"]];
        rtn.op_code = [result stringForColumn:@"op_code"];
        rtn.op_group_code = [result stringForColumn:@"op_group_code"];
        rtn.op_value_code = [result stringForColumn:@"op_value_code"];
        rtn.op_value_qty = [NSNumber numberWithInt:[result intForColumn:@"op_value_qty"]];
        rtn.op_value_price_diff = [NSNumber numberWithDouble:[result doubleForColumn:@"op_value_price_diff"]];
        rtn.op_value_original_price_diff = [NSNumber numberWithDouble:[result doubleForColumn:@"op_value_original_price_diff"]];
        rtn.data_version = [NSNumber numberWithInt:[result intForColumn:@"data_version"]];
        [array addObject:rtn];
    }
    [db close];
    return array;
}

+ (client_intent_order_setting *)convertJsonToModel:(NSDictionary *)json
{
    client_intent_order_setting *model = [[client_intent_order_setting alloc] init];
    model.intent_order_setting_id = [json objectForKey:@"intent_order_setting_id"];
    model.intent_order_id = [json objectForKey:@"intent_order_id"];
    model.intent_order_code = [json objectForKey:@"intent_order_code"];
    model.vehicle_edition_setting_id = [json objectForKey:@"vehicle_edition_setting_id"];
    model.op_code = [json objectForKey:@"op_code"];
    model.op_group_code = [json objectForKey:@"op_group_code"];
    model.op_value_code = [json objectForKey:@"op_value_code"];
    model.op_value_qty = [json objectForKey:@"op_value_qty"];
    model.op_value_price_diff = [json objectForKey:@"op_value_price_diff"];
    model.op_value_original_price_diff = [json objectForKey:@"op_value_original_price_diff"];
    model.data_version = [json objectForKey:@"data_version"];
    return model;
}

+ (NSArray *)convertJsonToList:(NSArray *)jsons
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSDictionary *json in jsons) {
        client_intent_order_setting *model = [[client_intent_order_setting alloc] init];
        model.intent_order_setting_id = [json objectForKey:@"intent_order_setting_id"];
        model.intent_order_id = [json objectForKey:@"intent_order_id"];
        model.intent_order_code = [json objectForKey:@"intent_order_code"];
        model.vehicle_edition_setting_id = [json objectForKey:@"vehicle_edition_setting_id"];
        model.op_code = [json objectForKey:@"op_code"];
        model.op_group_code = [json objectForKey:@"op_group_code"];
        model.op_value_code = [json objectForKey:@"op_value_code"];
        model.op_value_qty = [json objectForKey:@"op_value_qty"];
        model.op_value_price_diff = [json objectForKey:@"op_value_price_diff"];
        model.op_value_original_price_diff = [json objectForKey:@"op_value_original_price_diff"];
        model.data_version = [json objectForKey:@"data_version"];
        [array addObject:model];
    }
    return array;
}

@end