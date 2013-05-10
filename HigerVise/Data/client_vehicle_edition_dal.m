#import "client_vehicle_edition_dal.h"

@implementation client_vehicle_edition_dal

+ (NSNumber *)getMaxId
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    NSNumber *rtn;
    FMResultSet *result = [db executeQuery:@"SELECT MAX(vehicle_edition_id) FROM client_vehicle_edition"];
    if ([result next]) {
        int maxId = [result intForColumnIndex:0] + 1;
        rtn = [NSNumber numberWithInt:maxId];
    }
    [db close];
    return rtn;
}

+ (BOOL)exists:(NSNumber *)vehicle_edition_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    FMResultSet *result = [db executeQuery:@"SELECT COUNT(vehicle_edition_id) FROM client_vehicle_edition WHERE vehicle_edition_id = ?", vehicle_edition_id];
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

+ (BOOL)add:(client_vehicle_edition *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"INSERT INTO client_vehicle_edition (vehicle_edition_id, vehicle_configurator_id, vehicle_code, edition_id, edition_type, display_name, edition_title, std_price, sale_price, del_price, customer_price, base_price, edition_desc, edition_remark, edition_tech_desc, data_version) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", model.vehicle_edition_id, model.vehicle_configurator_id, model.vehicle_code, model.edition_id, model.edition_type, model.display_name, model.edition_title, model.std_price, model.sale_price, model.del_price, model.customer_price, model.base_price, model.edition_desc, model.edition_remark, model.edition_tech_desc, model.data_version];
    [db close];
    return rtn;
}

+ (BOOL)update:(client_vehicle_edition *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"UPDATE client_vehicle_edition SET vehicle_configurator_id = ?, vehicle_code = ?, edition_id = ?, edition_type = ?, display_name = ?, edition_title = ?, std_price = ?, sale_price = ?, del_price = ?, customer_price = ?, base_price = ?, edition_desc = ?, edition_remark = ?, edition_tech_desc = ?, data_version = ? WHERE vehicle_edition_id = ?", model.vehicle_configurator_id, model.vehicle_code, model.edition_id, model.edition_type, model.display_name, model.edition_title, model.std_price, model.sale_price, model.del_price, model.customer_price, model.base_price, model.edition_desc, model.edition_remark, model.edition_tech_desc, model.data_version, model.vehicle_edition_id];
    [db close];
    return rtn;
}

+ (BOOL)delete:(NSNumber *)vehicle_edition_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"DELETE FROM client_vehicle_edition WHERE vehicle_edition_id = ?", vehicle_edition_id];
    [db close];
    return rtn;
}

+ (BOOL)deleteList:(NSString *)where
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    NSString *strSql = [NSString stringWithFormat:@"DELETE FROM client_vehicle_edition WHERE %@", where];
    rtn = [db executeUpdate:strSql];
    [db close];
    return rtn;
}

+ (client_vehicle_edition *)get:(NSNumber *)vehicle_edition_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    client_vehicle_edition *rtn;
    FMResultSet *result = [db executeQuery:@"SELECT * FROM client_vehicle_edition WHERE vehicle_edition_id = ?", vehicle_edition_id];
    while ([result next]) {
        rtn = [[client_vehicle_edition alloc] init];
        rtn.vehicle_edition_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_edition_id"]];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_code = [result stringForColumn:@"vehicle_code"];
        rtn.edition_id = [NSNumber numberWithInt:[result intForColumn:@"edition_id"]];
        rtn.edition_type = [NSNumber numberWithInt:[result intForColumn:@"edition_type"]];
        rtn.display_name = [result stringForColumn:@"display_name"];
        rtn.edition_title = [result stringForColumn:@"edition_title"];
        rtn.std_price = [NSNumber numberWithDouble:[result doubleForColumn:@"std_price"]];
        rtn.sale_price = [NSNumber numberWithDouble:[result doubleForColumn:@"sale_price"]];
        rtn.del_price = [NSNumber numberWithDouble:[result doubleForColumn:@"del_price"]];
        rtn.customer_price = [NSNumber numberWithDouble:[result doubleForColumn:@"customer_price"]];
        rtn.base_price = [NSNumber numberWithDouble:[result doubleForColumn:@"base_price"]];
        rtn.edition_desc = [result stringForColumn:@"edition_desc"];
        rtn.edition_remark = [result stringForColumn:@"edition_remark"];
        rtn.edition_tech_desc = [result stringForColumn:@"edition_tech_desc"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_vehicle_edition WHERE %@", where];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_vehicle_edition *rtn = [[client_vehicle_edition alloc] init];
        rtn.vehicle_edition_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_edition_id"]];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_code = [result stringForColumn:@"vehicle_code"];
        rtn.edition_id = [NSNumber numberWithInt:[result intForColumn:@"edition_id"]];
        rtn.edition_type = [NSNumber numberWithInt:[result intForColumn:@"edition_type"]];
        rtn.display_name = [result stringForColumn:@"display_name"];
        rtn.edition_title = [result stringForColumn:@"edition_title"];
        rtn.std_price = [NSNumber numberWithDouble:[result doubleForColumn:@"std_price"]];
        rtn.sale_price = [NSNumber numberWithDouble:[result doubleForColumn:@"sale_price"]];
        rtn.del_price = [NSNumber numberWithDouble:[result doubleForColumn:@"del_price"]];
        rtn.customer_price = [NSNumber numberWithDouble:[result doubleForColumn:@"customer_price"]];
        rtn.base_price = [NSNumber numberWithDouble:[result doubleForColumn:@"base_price"]];
        rtn.edition_desc = [result stringForColumn:@"edition_desc"];
        rtn.edition_remark = [result stringForColumn:@"edition_remark"];
        rtn.edition_tech_desc = [result stringForColumn:@"edition_tech_desc"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_vehicle_edition WHERE %@ ORDER BY %@", where, order];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_vehicle_edition *rtn = [[client_vehicle_edition alloc] init];
        rtn.vehicle_edition_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_edition_id"]];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_code = [result stringForColumn:@"vehicle_code"];
        rtn.edition_id = [NSNumber numberWithInt:[result intForColumn:@"edition_id"]];
        rtn.edition_type = [NSNumber numberWithInt:[result intForColumn:@"edition_type"]];
        rtn.display_name = [result stringForColumn:@"display_name"];
        rtn.edition_title = [result stringForColumn:@"edition_title"];
        rtn.std_price = [NSNumber numberWithDouble:[result doubleForColumn:@"std_price"]];
        rtn.sale_price = [NSNumber numberWithDouble:[result doubleForColumn:@"sale_price"]];
        rtn.del_price = [NSNumber numberWithDouble:[result doubleForColumn:@"del_price"]];
        rtn.customer_price = [NSNumber numberWithDouble:[result doubleForColumn:@"customer_price"]];
        rtn.base_price = [NSNumber numberWithDouble:[result doubleForColumn:@"base_price"]];
        rtn.edition_desc = [result stringForColumn:@"edition_desc"];
        rtn.edition_remark = [result stringForColumn:@"edition_remark"];
        rtn.edition_tech_desc = [result stringForColumn:@"edition_tech_desc"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_vehicle_edition WHERE %@ ORDER BY %@ LIMIT 0,%d", where, order, top];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_vehicle_edition *rtn = [[client_vehicle_edition alloc] init];
        rtn.vehicle_edition_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_edition_id"]];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_code = [result stringForColumn:@"vehicle_code"];
        rtn.edition_id = [NSNumber numberWithInt:[result intForColumn:@"edition_id"]];
        rtn.edition_type = [NSNumber numberWithInt:[result intForColumn:@"edition_type"]];
        rtn.display_name = [result stringForColumn:@"display_name"];
        rtn.edition_title = [result stringForColumn:@"edition_title"];
        rtn.std_price = [NSNumber numberWithDouble:[result doubleForColumn:@"std_price"]];
        rtn.sale_price = [NSNumber numberWithDouble:[result doubleForColumn:@"sale_price"]];
        rtn.del_price = [NSNumber numberWithDouble:[result doubleForColumn:@"del_price"]];
        rtn.customer_price = [NSNumber numberWithDouble:[result doubleForColumn:@"customer_price"]];
        rtn.base_price = [NSNumber numberWithDouble:[result doubleForColumn:@"base_price"]];
        rtn.edition_desc = [result stringForColumn:@"edition_desc"];
        rtn.edition_remark = [result stringForColumn:@"edition_remark"];
        rtn.edition_tech_desc = [result stringForColumn:@"edition_tech_desc"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_vehicle_edition WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_vehicle_edition *rtn = [[client_vehicle_edition alloc] init];
        rtn.vehicle_edition_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_edition_id"]];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_code = [result stringForColumn:@"vehicle_code"];
        rtn.edition_id = [NSNumber numberWithInt:[result intForColumn:@"edition_id"]];
        rtn.edition_type = [NSNumber numberWithInt:[result intForColumn:@"edition_type"]];
        rtn.display_name = [result stringForColumn:@"display_name"];
        rtn.edition_title = [result stringForColumn:@"edition_title"];
        rtn.std_price = [NSNumber numberWithDouble:[result doubleForColumn:@"std_price"]];
        rtn.sale_price = [NSNumber numberWithDouble:[result doubleForColumn:@"sale_price"]];
        rtn.del_price = [NSNumber numberWithDouble:[result doubleForColumn:@"del_price"]];
        rtn.customer_price = [NSNumber numberWithDouble:[result doubleForColumn:@"customer_price"]];
        rtn.base_price = [NSNumber numberWithDouble:[result doubleForColumn:@"base_price"]];
        rtn.edition_desc = [result stringForColumn:@"edition_desc"];
        rtn.edition_remark = [result stringForColumn:@"edition_remark"];
        rtn.edition_tech_desc = [result stringForColumn:@"edition_tech_desc"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_vehicle_edition WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_vehicle_edition *rtn = [[client_vehicle_edition alloc] init];
        rtn.vehicle_edition_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_edition_id"]];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_code = [result stringForColumn:@"vehicle_code"];
        rtn.edition_id = [NSNumber numberWithInt:[result intForColumn:@"edition_id"]];
        rtn.edition_type = [NSNumber numberWithInt:[result intForColumn:@"edition_type"]];
        rtn.display_name = [result stringForColumn:@"display_name"];
        rtn.edition_title = [result stringForColumn:@"edition_title"];
        rtn.std_price = [NSNumber numberWithDouble:[result doubleForColumn:@"std_price"]];
        rtn.sale_price = [NSNumber numberWithDouble:[result doubleForColumn:@"sale_price"]];
        rtn.del_price = [NSNumber numberWithDouble:[result doubleForColumn:@"del_price"]];
        rtn.customer_price = [NSNumber numberWithDouble:[result doubleForColumn:@"customer_price"]];
        rtn.base_price = [NSNumber numberWithDouble:[result doubleForColumn:@"base_price"]];
        rtn.edition_desc = [result stringForColumn:@"edition_desc"];
        rtn.edition_remark = [result stringForColumn:@"edition_remark"];
        rtn.edition_tech_desc = [result stringForColumn:@"edition_tech_desc"];
        rtn.data_version = [NSNumber numberWithInt:[result intForColumn:@"data_version"]];
        [array addObject:rtn];
    }
    [db close];
    return array;
}

+ (client_vehicle_edition *)convertJsonToModel:(NSDictionary *)json
{
    client_vehicle_edition *model = [[client_vehicle_edition alloc] init];
    model.vehicle_edition_id = [json objectForKey:@"vehicle_edition_id"];
    model.vehicle_configurator_id = [json objectForKey:@"vehicle_configurator_id"];
    model.vehicle_code = [json objectForKey:@"vehicle_code"];
    model.edition_id = [json objectForKey:@"edition_id"];
    model.edition_type = [json objectForKey:@"edition_type"];
    model.display_name = [json objectForKey:@"display_name"];
    model.edition_title = [json objectForKey:@"edition_title"];
    model.std_price = [json objectForKey:@"std_price"];
    model.sale_price = [json objectForKey:@"sale_price"];
    model.del_price = [json objectForKey:@"del_price"];
    model.customer_price = [json objectForKey:@"customer_price"];
    model.base_price = [json objectForKey:@"base_price"];
    model.edition_desc = [json objectForKey:@"edition_desc"];
    model.edition_remark = [json objectForKey:@"edition_remark"];
    model.edition_tech_desc = [json objectForKey:@"edition_tech_desc"];
    model.data_version = [json objectForKey:@"data_version"];
    return model;
}

+ (NSArray *)convertJsonToList:(NSArray *)jsons
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSDictionary *json in jsons) {
        client_vehicle_edition *model = [[client_vehicle_edition alloc] init];
        model.vehicle_edition_id = [json objectForKey:@"vehicle_edition_id"];
        model.vehicle_configurator_id = [json objectForKey:@"vehicle_configurator_id"];
        model.vehicle_code = [json objectForKey:@"vehicle_code"];
        model.edition_id = [json objectForKey:@"edition_id"];
        model.edition_type = [json objectForKey:@"edition_type"];
        model.display_name = [json objectForKey:@"display_name"];
        model.edition_title = [json objectForKey:@"edition_title"];
        model.std_price = [json objectForKey:@"std_price"];
        model.sale_price = [json objectForKey:@"sale_price"];
        model.del_price = [json objectForKey:@"del_price"];
        model.customer_price = [json objectForKey:@"customer_price"];
        model.base_price = [json objectForKey:@"base_price"];
        model.edition_desc = [json objectForKey:@"edition_desc"];
        model.edition_remark = [json objectForKey:@"edition_remark"];
        model.edition_tech_desc = [json objectForKey:@"edition_tech_desc"];
        model.data_version = [json objectForKey:@"data_version"];
        [array addObject:model];
    }
    return array;
}

+ (NSArray *)getListForPriceTable:(NSString *)where order:(NSString *)order
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_vehicle_edition WHERE %@ ORDER BY %@", where, order];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_vehicle_edition_his *rtn = [[client_vehicle_edition_his alloc] init];
        rtn.vehicle_edition_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_edition_id"]];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_code = [result stringForColumn:@"vehicle_code"];
        rtn.edition_id = [NSNumber numberWithInt:[result intForColumn:@"edition_id"]];
        rtn.edition_type = [NSNumber numberWithInt:[result intForColumn:@"edition_type"]];
        rtn.display_name = [result stringForColumn:@"display_name"];
        rtn.edition_title = [result stringForColumn:@"edition_title"];
        rtn.std_price = [NSNumber numberWithDouble:[result doubleForColumn:@"std_price"]];
        rtn.sale_price = [NSNumber numberWithDouble:[result doubleForColumn:@"sale_price"]];
        rtn.del_price = [NSNumber numberWithDouble:[result doubleForColumn:@"del_price"]];
        rtn.customer_price = [NSNumber numberWithDouble:[result doubleForColumn:@"customer_price"]];
        rtn.base_price = [NSNumber numberWithDouble:[result doubleForColumn:@"base_price"]];
        rtn.edition_desc = [result stringForColumn:@"edition_desc"];
        rtn.edition_remark = [result stringForColumn:@"edition_remark"];
        rtn.edition_tech_desc = [result stringForColumn:@"edition_tech_desc"];
        //rtn.edition_cancel = [NSNumber numberWithInt:0];
        //rtn.create_userid = [result stringForColumn:@"create_userid"];
        //rtn.create_time = [result dateForColumn:@"create_time"];
        //rtn.update_userid = [result stringForColumn:@"update_userid"];
        //rtn.update_time = [result dateForColumn:@"update_time"];
        rtn.data_version = [NSNumber numberWithInt:[result intForColumn:@"data_version"]];
        [array addObject:rtn];
    }
    [db close];
    return array;
}

@end