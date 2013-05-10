#import "client_dealer_dal.h"

@implementation client_dealer_dal

+ (BOOL)exists:(NSString *)dealer_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    FMResultSet *result = [db executeQuery:@"SELECT COUNT(dealer_id) FROM client_dealer WHERE dealer_id = ?", dealer_id];
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

+ (BOOL)add:(client_dealer *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"INSERT INTO client_dealer (dealer_id, dealer_code, dealer_name, dealer_name_brief, declare_class_id, dealer_address, global_region_code, nation_region_code, city_region_code, dealer_trade_code, dealer_status, data_version) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", model.dealer_id, model.dealer_code, model.dealer_name, model.dealer_name_brief, model.declare_class_id, model.dealer_address, model.global_region_code, model.nation_region_code, model.city_region_code, model.dealer_trade_code, model.dealer_status, model.data_version];
    [db close];
    return rtn;
}

+ (BOOL)update:(client_dealer *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"UPDATE client_dealer SET dealer_code = ?, dealer_name = ?, dealer_name_brief = ?, declare_class_id = ?, dealer_address = ?, global_region_code = ?, nation_region_code = ?, city_region_code = ?, dealer_trade_code = ?, dealer_status = ?, data_version = ? WHERE dealer_id = ?", model.dealer_code, model.dealer_name, model.dealer_name_brief, model.declare_class_id, model.dealer_address, model.global_region_code, model.nation_region_code, model.city_region_code, model.dealer_trade_code, model.dealer_status, model.data_version, model.dealer_id];
    [db close];
    return rtn;
}

+ (BOOL)delete:(NSString *)dealer_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"DELETE FROM client_dealer WHERE dealer_id = ?", dealer_id];
    [db close];
    return rtn;
}

+ (BOOL)deleteList:(NSString *)where
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    NSString *strSql = [NSString stringWithFormat:@"DELETE FROM client_dealer WHERE %@", where];
    rtn = [db executeUpdate:strSql];
    [db close];
    return rtn;
}

+ (client_dealer *)get:(NSString *)dealer_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    client_dealer *rtn;
    FMResultSet *result = [db executeQuery:@"SELECT * FROM client_dealer WHERE dealer_id = ?", dealer_id];
    while ([result next]) {
        rtn = [[client_dealer alloc] init];
        rtn.dealer_id = [result stringForColumn:@"dealer_id"];
        rtn.dealer_code = [result stringForColumn:@"dealer_code"];
        rtn.dealer_name = [result stringForColumn:@"dealer_name"];
        rtn.dealer_name_brief = [result stringForColumn:@"dealer_name_brief"];
        rtn.declare_class_id = [result stringForColumn:@"declare_class_id"];
        rtn.dealer_address = [result stringForColumn:@"dealer_address"];
        rtn.global_region_code = [result stringForColumn:@"global_region_code"];
        rtn.nation_region_code = [result stringForColumn:@"nation_region_code"];
        rtn.city_region_code = [result stringForColumn:@"city_region_code"];
        rtn.dealer_trade_code = [result stringForColumn:@"dealer_trade_code"];
        rtn.dealer_status = [result stringForColumn:@"dealer_status"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_dealer WHERE %@", where];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_dealer *rtn = [[client_dealer alloc] init];
        rtn.dealer_id = [result stringForColumn:@"dealer_id"];
        rtn.dealer_code = [result stringForColumn:@"dealer_code"];
        rtn.dealer_name = [result stringForColumn:@"dealer_name"];
        rtn.dealer_name_brief = [result stringForColumn:@"dealer_name_brief"];
        rtn.declare_class_id = [result stringForColumn:@"declare_class_id"];
        rtn.dealer_address = [result stringForColumn:@"dealer_address"];
        rtn.global_region_code = [result stringForColumn:@"global_region_code"];
        rtn.nation_region_code = [result stringForColumn:@"nation_region_code"];
        rtn.city_region_code = [result stringForColumn:@"city_region_code"];
        rtn.dealer_trade_code = [result stringForColumn:@"dealer_trade_code"];
        rtn.dealer_status = [result stringForColumn:@"dealer_status"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_dealer WHERE %@ ORDER BY %@", where, order];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_dealer *rtn = [[client_dealer alloc] init];
        rtn.dealer_id = [result stringForColumn:@"dealer_id"];
        rtn.dealer_code = [result stringForColumn:@"dealer_code"];
        rtn.dealer_name = [result stringForColumn:@"dealer_name"];
        rtn.dealer_name_brief = [result stringForColumn:@"dealer_name_brief"];
        rtn.declare_class_id = [result stringForColumn:@"declare_class_id"];
        rtn.dealer_address = [result stringForColumn:@"dealer_address"];
        rtn.global_region_code = [result stringForColumn:@"global_region_code"];
        rtn.nation_region_code = [result stringForColumn:@"nation_region_code"];
        rtn.city_region_code = [result stringForColumn:@"city_region_code"];
        rtn.dealer_trade_code = [result stringForColumn:@"dealer_trade_code"];
        rtn.dealer_status = [result stringForColumn:@"dealer_status"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_dealer WHERE %@ ORDER BY %@ LIMIT 0,%d", where, order, top];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_dealer *rtn = [[client_dealer alloc] init];
        rtn.dealer_id = [result stringForColumn:@"dealer_id"];
        rtn.dealer_code = [result stringForColumn:@"dealer_code"];
        rtn.dealer_name = [result stringForColumn:@"dealer_name"];
        rtn.dealer_name_brief = [result stringForColumn:@"dealer_name_brief"];
        rtn.declare_class_id = [result stringForColumn:@"declare_class_id"];
        rtn.dealer_address = [result stringForColumn:@"dealer_address"];
        rtn.global_region_code = [result stringForColumn:@"global_region_code"];
        rtn.nation_region_code = [result stringForColumn:@"nation_region_code"];
        rtn.city_region_code = [result stringForColumn:@"city_region_code"];
        rtn.dealer_trade_code = [result stringForColumn:@"dealer_trade_code"];
        rtn.dealer_status = [result stringForColumn:@"dealer_status"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_dealer WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_dealer *rtn = [[client_dealer alloc] init];
        rtn.dealer_id = [result stringForColumn:@"dealer_id"];
        rtn.dealer_code = [result stringForColumn:@"dealer_code"];
        rtn.dealer_name = [result stringForColumn:@"dealer_name"];
        rtn.dealer_name_brief = [result stringForColumn:@"dealer_name_brief"];
        rtn.declare_class_id = [result stringForColumn:@"declare_class_id"];
        rtn.dealer_address = [result stringForColumn:@"dealer_address"];
        rtn.global_region_code = [result stringForColumn:@"global_region_code"];
        rtn.nation_region_code = [result stringForColumn:@"nation_region_code"];
        rtn.city_region_code = [result stringForColumn:@"city_region_code"];
        rtn.dealer_trade_code = [result stringForColumn:@"dealer_trade_code"];
        rtn.dealer_status = [result stringForColumn:@"dealer_status"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_dealer WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_dealer *rtn = [[client_dealer alloc] init];
        rtn.dealer_id = [result stringForColumn:@"dealer_id"];
        rtn.dealer_code = [result stringForColumn:@"dealer_code"];
        rtn.dealer_name = [result stringForColumn:@"dealer_name"];
        rtn.dealer_name_brief = [result stringForColumn:@"dealer_name_brief"];
        rtn.declare_class_id = [result stringForColumn:@"declare_class_id"];
        rtn.dealer_address = [result stringForColumn:@"dealer_address"];
        rtn.global_region_code = [result stringForColumn:@"global_region_code"];
        rtn.nation_region_code = [result stringForColumn:@"nation_region_code"];
        rtn.city_region_code = [result stringForColumn:@"city_region_code"];
        rtn.dealer_trade_code = [result stringForColumn:@"dealer_trade_code"];
        rtn.dealer_status = [result stringForColumn:@"dealer_status"];
        rtn.data_version = [NSNumber numberWithInt:[result intForColumn:@"data_version"]];
        [array addObject:rtn];
    }
    [db close];
    return array;
}

+ (client_dealer *)convertJsonToModel:(NSDictionary *)json
{
    client_dealer *model = [[client_dealer alloc] init];
    model.dealer_id = [json objectForKey:@"dealer_id"];
    model.dealer_code = [json objectForKey:@"dealer_code"];
    model.dealer_name = [json objectForKey:@"dealer_name"];
    model.dealer_name_brief = [json objectForKey:@"dealer_name_brief"];
    model.declare_class_id = [json objectForKey:@"declare_class_id"];
    model.dealer_address = [json objectForKey:@"dealer_address"];
    model.global_region_code = [json objectForKey:@"global_region_code"];
    model.nation_region_code = [json objectForKey:@"nation_region_code"];
    model.city_region_code = [json objectForKey:@"city_region_code"];
    model.dealer_trade_code = [json objectForKey:@"dealer_trade_code"];
    model.dealer_status = [json objectForKey:@"dealer_status"];
    model.data_version = [json objectForKey:@"data_version"];
    return model;
}

+ (NSArray *)convertJsonToList:(NSArray *)jsons
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSDictionary *json in jsons) {
        client_dealer *model = [[client_dealer alloc] init];
        model.dealer_id = [json objectForKey:@"dealer_id"];
        model.dealer_code = [json objectForKey:@"dealer_code"];
        model.dealer_name = [json objectForKey:@"dealer_name"];
        model.dealer_name_brief = [json objectForKey:@"dealer_name_brief"];
        model.declare_class_id = [json objectForKey:@"declare_class_id"];
        model.dealer_address = [json objectForKey:@"dealer_address"];
        model.global_region_code = [json objectForKey:@"global_region_code"];
        model.nation_region_code = [json objectForKey:@"nation_region_code"];
        model.city_region_code = [json objectForKey:@"city_region_code"];
        model.dealer_trade_code = [json objectForKey:@"dealer_trade_code"];
        model.dealer_status = [json objectForKey:@"dealer_status"];
        model.data_version = [json objectForKey:@"data_version"];
        [array addObject:model];
    }
    return array;
}

@end