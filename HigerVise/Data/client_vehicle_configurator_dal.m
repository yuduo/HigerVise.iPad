#import "client_vehicle_configurator_dal.h"

@implementation client_vehicle_configurator_dal

+ (NSNumber *)getMaxId
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    NSNumber *rtn;
    FMResultSet *result = [db executeQuery:@"SELECT MAX(vehicle_configurator_id) FROM client_vehicle_configurator"];
    if ([result next]) {
        int maxId = [result intForColumnIndex:0] + 1;
        rtn = [NSNumber numberWithInt:maxId];
    }
    [db close];
    return rtn;
}

+ (BOOL)exists:(NSNumber *)vehicle_configurator_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    FMResultSet *result = [db executeQuery:@"SELECT COUNT(vehicle_configurator_id) FROM client_vehicle_configurator WHERE vehicle_configurator_id = ?", vehicle_configurator_id];
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

+ (BOOL)add:(client_vehicle_configurator *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"INSERT INTO client_vehicle_configurator (vehicle_configurator_id, vehicle_class_id, vehicle_code, item_code, item_model, vehicle_pca_version, display_name, engine_model, vehicle_series, vehicle_asses_type_rank, is_air_suspension, vehicle_suspension_type, rank_seat, vehicle_fuel, vehicle_passenger_door, vehicle_body_struct, vehicle_desc, vehicle_remark, vehicle_tech_desc, search_text, click_count, data_version) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", model.vehicle_configurator_id, model.vehicle_class_id, model.vehicle_code, model.item_code, model.item_model, model.vehicle_pca_version, model.display_name, model.engine_model, model.vehicle_series, model.vehicle_asses_type_rank, model.is_air_suspension, model.vehicle_suspension_type, model.rank_seat, model.vehicle_fuel, model.vehicle_passenger_door, model.vehicle_body_struct, model.vehicle_desc, model.vehicle_remark, model.vehicle_tech_desc, model.search_text, model.click_count, model.data_version];
    [db close];
    return rtn;
}

+ (BOOL)update:(client_vehicle_configurator *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"UPDATE client_vehicle_configurator SET vehicle_class_id = ?, vehicle_code = ?, item_code = ?, item_model = ?, vehicle_pca_version = ?, display_name = ?, engine_model = ?, vehicle_series = ?, vehicle_asses_type_rank = ?, is_air_suspension = ?, vehicle_suspension_type = ?, rank_seat = ?, vehicle_fuel = ?, vehicle_passenger_door = ?, vehicle_body_struct = ?, vehicle_desc = ?, vehicle_remark = ?, vehicle_tech_desc = ?, search_text = ?, click_count = ?, data_version = ? WHERE vehicle_configurator_id = ?", model.vehicle_class_id, model.vehicle_code, model.item_code, model.item_model, model.vehicle_pca_version, model.display_name, model.engine_model, model.vehicle_series, model.vehicle_asses_type_rank, model.is_air_suspension, model.vehicle_suspension_type, model.rank_seat, model.vehicle_fuel, model.vehicle_passenger_door, model.vehicle_body_struct, model.vehicle_desc, model.vehicle_remark, model.vehicle_tech_desc, model.search_text, model.click_count, model.data_version, model.vehicle_configurator_id];
    [db close];
    return rtn;
}

+ (BOOL)delete:(NSNumber *)vehicle_configurator_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"DELETE FROM client_vehicle_configurator WHERE vehicle_configurator_id = ?", vehicle_configurator_id];
    [db close];
    return rtn;
}

+ (BOOL)deleteList:(NSString *)where
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    NSString *strSql = [NSString stringWithFormat:@"DELETE FROM client_vehicle_configurator WHERE %@", where];
    rtn = [db executeUpdate:strSql];
    [db close];
    return rtn;
}

+ (client_vehicle_configurator *)get:(NSNumber *)vehicle_configurator_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    client_vehicle_configurator *rtn;
    FMResultSet *result = [db executeQuery:@"SELECT * FROM client_vehicle_configurator WHERE vehicle_configurator_id = ?", vehicle_configurator_id];
    while ([result next]) {
        rtn = [[client_vehicle_configurator alloc] init];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_class_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_class_id"]];
        rtn.vehicle_code = [result stringForColumn:@"vehicle_code"];
        rtn.item_code = [result stringForColumn:@"item_code"];
        rtn.item_model = [result stringForColumn:@"item_model"];
        rtn.vehicle_pca_version = [NSNumber numberWithInt:[result intForColumn:@"vehicle_pca_version"]];
        rtn.display_name = [result stringForColumn:@"display_name"];
        rtn.engine_model = [result stringForColumn:@"engine_model"];
        rtn.vehicle_series = [result stringForColumn:@"vehicle_series"];
        rtn.vehicle_asses_type_rank = [result stringForColumn:@"vehicle_asses_type_rank"];
        rtn.is_air_suspension = [result stringForColumn:@"is_air_suspension"];
        rtn.vehicle_suspension_type = [result stringForColumn:@"vehicle_suspension_type"];
        rtn.rank_seat = [result stringForColumn:@"rank_seat"];
        rtn.vehicle_fuel = [result stringForColumn:@"vehicle_fuel"];
        rtn.vehicle_passenger_door = [result stringForColumn:@"vehicle_passenger_door"];
        rtn.vehicle_body_struct = [NSNumber numberWithInt:[result intForColumn:@"vehicle_body_struct"]];
        rtn.vehicle_desc = [result stringForColumn:@"vehicle_desc"];
        rtn.vehicle_remark = [result stringForColumn:@"vehicle_remark"];
        rtn.vehicle_tech_desc = [result stringForColumn:@"vehicle_tech_desc"];
        rtn.search_text = [result stringForColumn:@"search_text"];
        rtn.click_count = [NSNumber numberWithInt:[result intForColumn:@"click_count"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_vehicle_configurator WHERE %@", where];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_vehicle_configurator *rtn = [[client_vehicle_configurator alloc] init];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_class_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_class_id"]];
        rtn.vehicle_code = [result stringForColumn:@"vehicle_code"];
        rtn.item_code = [result stringForColumn:@"item_code"];
        rtn.item_model = [result stringForColumn:@"item_model"];
        rtn.vehicle_pca_version = [NSNumber numberWithInt:[result intForColumn:@"vehicle_pca_version"]];
        rtn.display_name = [result stringForColumn:@"display_name"];
        rtn.engine_model = [result stringForColumn:@"engine_model"];
        rtn.vehicle_series = [result stringForColumn:@"vehicle_series"];
        rtn.vehicle_asses_type_rank = [result stringForColumn:@"vehicle_asses_type_rank"];
        rtn.is_air_suspension = [result stringForColumn:@"is_air_suspension"];
        rtn.vehicle_suspension_type = [result stringForColumn:@"vehicle_suspension_type"];
        rtn.rank_seat = [result stringForColumn:@"rank_seat"];
        rtn.vehicle_fuel = [result stringForColumn:@"vehicle_fuel"];
        rtn.vehicle_passenger_door = [result stringForColumn:@"vehicle_passenger_door"];
        rtn.vehicle_body_struct = [NSNumber numberWithInt:[result intForColumn:@"vehicle_body_struct"]];
        rtn.vehicle_desc = [result stringForColumn:@"vehicle_desc"];
        rtn.vehicle_remark = [result stringForColumn:@"vehicle_remark"];
        rtn.vehicle_tech_desc = [result stringForColumn:@"vehicle_tech_desc"];
        rtn.search_text = [result stringForColumn:@"search_text"];
        rtn.click_count = [NSNumber numberWithInt:[result intForColumn:@"click_count"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_vehicle_configurator WHERE %@ ORDER BY %@", where, order];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_vehicle_configurator *rtn = [[client_vehicle_configurator alloc] init];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_class_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_class_id"]];
        rtn.vehicle_code = [result stringForColumn:@"vehicle_code"];
        rtn.item_code = [result stringForColumn:@"item_code"];
        rtn.item_model = [result stringForColumn:@"item_model"];
        rtn.vehicle_pca_version = [NSNumber numberWithInt:[result intForColumn:@"vehicle_pca_version"]];
        rtn.display_name = [result stringForColumn:@"display_name"];
        rtn.engine_model = [result stringForColumn:@"engine_model"];
        rtn.vehicle_series = [result stringForColumn:@"vehicle_series"];
        rtn.vehicle_asses_type_rank = [result stringForColumn:@"vehicle_asses_type_rank"];
        rtn.is_air_suspension = [result stringForColumn:@"is_air_suspension"];
        rtn.vehicle_suspension_type = [result stringForColumn:@"vehicle_suspension_type"];
        rtn.rank_seat = [result stringForColumn:@"rank_seat"];
        rtn.vehicle_fuel = [result stringForColumn:@"vehicle_fuel"];
        rtn.vehicle_passenger_door = [result stringForColumn:@"vehicle_passenger_door"];
        rtn.vehicle_body_struct = [NSNumber numberWithInt:[result intForColumn:@"vehicle_body_struct"]];
        rtn.vehicle_desc = [result stringForColumn:@"vehicle_desc"];
        rtn.vehicle_remark = [result stringForColumn:@"vehicle_remark"];
        rtn.vehicle_tech_desc = [result stringForColumn:@"vehicle_tech_desc"];
        rtn.search_text = [result stringForColumn:@"search_text"];
        rtn.click_count = [NSNumber numberWithInt:[result intForColumn:@"click_count"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_vehicle_configurator WHERE %@ ORDER BY %@ LIMIT 0,%d", where, order, top];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_vehicle_configurator *rtn = [[client_vehicle_configurator alloc] init];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_class_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_class_id"]];
        rtn.vehicle_code = [result stringForColumn:@"vehicle_code"];
        rtn.item_code = [result stringForColumn:@"item_code"];
        rtn.item_model = [result stringForColumn:@"item_model"];
        rtn.vehicle_pca_version = [NSNumber numberWithInt:[result intForColumn:@"vehicle_pca_version"]];
        rtn.display_name = [result stringForColumn:@"display_name"];
        rtn.engine_model = [result stringForColumn:@"engine_model"];
        rtn.vehicle_series = [result stringForColumn:@"vehicle_series"];
        rtn.vehicle_asses_type_rank = [result stringForColumn:@"vehicle_asses_type_rank"];
        rtn.is_air_suspension = [result stringForColumn:@"is_air_suspension"];
        rtn.vehicle_suspension_type = [result stringForColumn:@"vehicle_suspension_type"];
        rtn.rank_seat = [result stringForColumn:@"rank_seat"];
        rtn.vehicle_fuel = [result stringForColumn:@"vehicle_fuel"];
        rtn.vehicle_passenger_door = [result stringForColumn:@"vehicle_passenger_door"];
        rtn.vehicle_body_struct = [NSNumber numberWithInt:[result intForColumn:@"vehicle_body_struct"]];
        rtn.vehicle_desc = [result stringForColumn:@"vehicle_desc"];
        rtn.vehicle_remark = [result stringForColumn:@"vehicle_remark"];
        rtn.vehicle_tech_desc = [result stringForColumn:@"vehicle_tech_desc"];
        rtn.search_text = [result stringForColumn:@"search_text"];
        rtn.click_count = [NSNumber numberWithInt:[result intForColumn:@"click_count"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_vehicle_configurator WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_vehicle_configurator *rtn = [[client_vehicle_configurator alloc] init];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_class_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_class_id"]];
        rtn.vehicle_code = [result stringForColumn:@"vehicle_code"];
        rtn.item_code = [result stringForColumn:@"item_code"];
        rtn.item_model = [result stringForColumn:@"item_model"];
        rtn.vehicle_pca_version = [NSNumber numberWithInt:[result intForColumn:@"vehicle_pca_version"]];
        rtn.display_name = [result stringForColumn:@"display_name"];
        rtn.engine_model = [result stringForColumn:@"engine_model"];
        rtn.vehicle_series = [result stringForColumn:@"vehicle_series"];
        rtn.vehicle_asses_type_rank = [result stringForColumn:@"vehicle_asses_type_rank"];
        rtn.is_air_suspension = [result stringForColumn:@"is_air_suspension"];
        rtn.vehicle_suspension_type = [result stringForColumn:@"vehicle_suspension_type"];
        rtn.rank_seat = [result stringForColumn:@"rank_seat"];
        rtn.vehicle_fuel = [result stringForColumn:@"vehicle_fuel"];
        rtn.vehicle_passenger_door = [result stringForColumn:@"vehicle_passenger_door"];
        rtn.vehicle_body_struct = [NSNumber numberWithInt:[result intForColumn:@"vehicle_body_struct"]];
        rtn.vehicle_desc = [result stringForColumn:@"vehicle_desc"];
        rtn.vehicle_remark = [result stringForColumn:@"vehicle_remark"];
        rtn.vehicle_tech_desc = [result stringForColumn:@"vehicle_tech_desc"];
        rtn.search_text = [result stringForColumn:@"search_text"];
        rtn.click_count = [NSNumber numberWithInt:[result intForColumn:@"click_count"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_vehicle_configurator WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_vehicle_configurator *rtn = [[client_vehicle_configurator alloc] init];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_class_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_class_id"]];
        rtn.vehicle_code = [result stringForColumn:@"vehicle_code"];
        rtn.item_code = [result stringForColumn:@"item_code"];
        rtn.item_model = [result stringForColumn:@"item_model"];
        rtn.vehicle_pca_version = [NSNumber numberWithInt:[result intForColumn:@"vehicle_pca_version"]];
        rtn.display_name = [result stringForColumn:@"display_name"];
        rtn.engine_model = [result stringForColumn:@"engine_model"];
        rtn.vehicle_series = [result stringForColumn:@"vehicle_series"];
        rtn.vehicle_asses_type_rank = [result stringForColumn:@"vehicle_asses_type_rank"];
        rtn.is_air_suspension = [result stringForColumn:@"is_air_suspension"];
        rtn.vehicle_suspension_type = [result stringForColumn:@"vehicle_suspension_type"];
        rtn.rank_seat = [result stringForColumn:@"rank_seat"];
        rtn.vehicle_fuel = [result stringForColumn:@"vehicle_fuel"];
        rtn.vehicle_passenger_door = [result stringForColumn:@"vehicle_passenger_door"];
        rtn.vehicle_body_struct = [NSNumber numberWithInt:[result intForColumn:@"vehicle_body_struct"]];
        rtn.vehicle_desc = [result stringForColumn:@"vehicle_desc"];
        rtn.vehicle_remark = [result stringForColumn:@"vehicle_remark"];
        rtn.vehicle_tech_desc = [result stringForColumn:@"vehicle_tech_desc"];
        rtn.search_text = [result stringForColumn:@"search_text"];
        rtn.click_count = [NSNumber numberWithInt:[result intForColumn:@"click_count"]];
        rtn.data_version = [NSNumber numberWithInt:[result intForColumn:@"data_version"]];
        [array addObject:rtn];
    }
    [db close];
    return array;
}

+ (client_vehicle_configurator *)convertJsonToModel:(NSDictionary *)json
{
    client_vehicle_configurator *model = [[client_vehicle_configurator alloc] init];
    model.vehicle_configurator_id = [json objectForKey:@"vehicle_configurator_id"];
    model.vehicle_class_id = [json objectForKey:@"vehicle_class_id"];
    model.vehicle_code = [json objectForKey:@"vehicle_code"];
    model.item_code = [json objectForKey:@"item_code"];
    model.item_model = [json objectForKey:@"item_model"];
    model.vehicle_pca_version = [json objectForKey:@"vehicle_pca_version"];
    model.display_name = [json objectForKey:@"display_name"];
    model.engine_model = [json objectForKey:@"engine_model"];
    model.vehicle_series = [json objectForKey:@"vehicle_series"];
    model.vehicle_asses_type_rank = [json objectForKey:@"vehicle_asses_type_rank"];
    model.is_air_suspension = [json objectForKey:@"is_air_suspension"];
    model.vehicle_suspension_type = [json objectForKey:@"vehicle_suspension_type"];
    model.rank_seat = [json objectForKey:@"rank_seat"];
    model.vehicle_fuel = [json objectForKey:@"vehicle_fuel"];
    model.vehicle_passenger_door = [json objectForKey:@"vehicle_passenger_door"];
    model.vehicle_body_struct = [json objectForKey:@"vehicle_body_struct"];
    model.vehicle_desc = [json objectForKey:@"vehicle_desc"];
    model.vehicle_remark = [json objectForKey:@"vehicle_remark"];
    model.vehicle_tech_desc = [json objectForKey:@"vehicle_tech_desc"];
    model.search_text = [json objectForKey:@"search_text"];
    model.click_count = [json objectForKey:@"click_count"];
    model.data_version = [json objectForKey:@"data_version"];
    return model;
}

+ (NSArray *)convertJsonToList:(NSArray *)jsons
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSDictionary *json in jsons) {
        client_vehicle_configurator *model = [[client_vehicle_configurator alloc] init];
        model.vehicle_configurator_id = [json objectForKey:@"vehicle_configurator_id"];
        model.vehicle_class_id = [json objectForKey:@"vehicle_class_id"];
        model.vehicle_code = [json objectForKey:@"vehicle_code"];
        model.item_code = [json objectForKey:@"item_code"];
        model.item_model = [json objectForKey:@"item_model"];
        model.vehicle_pca_version = [json objectForKey:@"vehicle_pca_version"];
        model.display_name = [json objectForKey:@"display_name"];
        model.engine_model = [json objectForKey:@"engine_model"];
        model.vehicle_series = [json objectForKey:@"vehicle_series"];
        model.vehicle_asses_type_rank = [json objectForKey:@"vehicle_asses_type_rank"];
        model.is_air_suspension = [json objectForKey:@"is_air_suspension"];
        model.vehicle_suspension_type = [json objectForKey:@"vehicle_suspension_type"];
        model.rank_seat = [json objectForKey:@"rank_seat"];
        model.vehicle_fuel = [json objectForKey:@"vehicle_fuel"];
        model.vehicle_passenger_door = [json objectForKey:@"vehicle_passenger_door"];
        model.vehicle_body_struct = [json objectForKey:@"vehicle_body_struct"];
        model.vehicle_desc = [json objectForKey:@"vehicle_desc"];
        model.vehicle_remark = [json objectForKey:@"vehicle_remark"];
        model.vehicle_tech_desc = [json objectForKey:@"vehicle_tech_desc"];
        model.search_text = [json objectForKey:@"search_text"];
        model.click_count = [json objectForKey:@"click_count"];
        model.data_version = [json objectForKey:@"data_version"];
        [array addObject:model];
    }
    return array;
}

+ (NSArray *)getListForPrompt:(NSString *)where
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSString *strSql = [NSString stringWithFormat:@"SELECT vehicle_configurator_id,vehicle_code FROM client_vehicle_configurator WHERE 1=1 %@ ORDER BY vehicle_series,item_model ASC", where];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_vehicle_configurator *rtn = [[client_vehicle_configurator alloc] init];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_code = [result stringForColumn:@"vehicle_code"];
        [array addObject:rtn];
    }
    [db close];
    return array;
}

+ (NSArray *)getListForResult:(NSString *)where
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSString *strSql = [NSString stringWithFormat:@"SELECT vehicle_configurator_id,vehicle_code,display_name,engine_model,vehicle_desc,vehicle_remark FROM client_vehicle_configurator WHERE 1=1 %@ ORDER BY click_count DESC", where];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_vehicle_configurator *rtn = [[client_vehicle_configurator alloc] init];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_code = [result stringForColumn:@"vehicle_code"];
        rtn.display_name = [result stringForColumn:@"display_name"];
        rtn.engine_model = [result stringForColumn:@"engine_model"];
        rtn.vehicle_desc = [result stringForColumn:@"vehicle_desc"];
        rtn.vehicle_remark = [result stringForColumn:@"vehicle_remark"];
        [array addObject:rtn];
    }
    [db close];
    return array;
}

+ (NSArray *)getListForIndex:(NSString *)where
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSString *strSql = [NSString stringWithFormat:@"SELECT vehicle_configurator_id,vehicle_code,display_name,engine_model,vehicle_desc,vehicle_remark FROM client_vehicle_configurator WHERE %@ ORDER BY vehicle_series,item_model ASC", where];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_vehicle_configurator *rtn = [[client_vehicle_configurator alloc] init];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_code = [result stringForColumn:@"vehicle_code"];
        rtn.display_name = [result stringForColumn:@"display_name"];
        rtn.engine_model = [result stringForColumn:@"engine_model"];
        rtn.vehicle_desc = [result stringForColumn:@"vehicle_desc"];
        rtn.vehicle_remark = [result stringForColumn:@"vehicle_remark"];
        [array addObject:rtn];
    }
    [db close];
    return array;
}

+ (NSArray *)getListForResult:(NSString *)where order:(NSString *)order page:(NSInteger)page pageSize:(NSInteger)pageSize
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSInteger beginIndex = (page - 1) * pageSize;
    NSInteger length = pageSize;
    NSString *strSql = [NSString stringWithFormat:@"SELECT vehicle_configurator_id,vehicle_code,display_name,engine_model,vehicle_desc,vehicle_remark FROM client_vehicle_configurator WHERE 1=1 %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_vehicle_configurator *rtn = [[client_vehicle_configurator alloc] init];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_code = [result stringForColumn:@"vehicle_code"];
        rtn.display_name = [result stringForColumn:@"display_name"];
        rtn.engine_model = [result stringForColumn:@"engine_model"];
        rtn.vehicle_desc = [result stringForColumn:@"vehicle_desc"];
        rtn.vehicle_remark = [result stringForColumn:@"vehicle_remark"];
        [array addObject:rtn];
    }
    [db close];
    return array;
}

+ (NSArray *)getListForPriceTableSearchResult:(NSString *)where
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSString *strSql = [NSString stringWithFormat:@"SELECT vehicle_configurator_id,vehicle_code,display_name FROM client_vehicle_configurator WHERE %@ ORDER BY vehicle_series,item_model ASC", where];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_vehicle_configurator *rtn = [[client_vehicle_configurator alloc] init];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_code = [result stringForColumn:@"vehicle_code"];
        rtn.display_name = [result stringForColumn:@"display_name"];
        [array addObject:rtn];
    }
    [db close];
    return array;
}

+ (NSArray *)getListForPriceTableSearchPrompt:(NSString *)where
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSString *strSql = [NSString stringWithFormat:@"SELECT vehicle_configurator_id,vehicle_code,display_name FROM client_vehicle_configurator WHERE %@ ORDER BY vehicle_series,item_model ASC", where];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_vehicle_configurator *rtn = [[client_vehicle_configurator alloc] init];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_code = [result stringForColumn:@"vehicle_code"];
        rtn.display_name = [result stringForColumn:@"display_name"];
        [array addObject:rtn];
    }
    [db close];
    return array;
}

+ (client_vehicle_configurator *)getForPirceTable:(NSNumber *)vehicle_configurator_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    client_vehicle_configurator *rtn;
    FMResultSet *result = [db executeQuery:@"SELECT vehicle_configurator_id, vehicle_class_id, vehicle_code, item_code, item_model, display_name, vehicle_desc, vehicle_remark FROM client_vehicle_configurator WHERE vehicle_configurator_id = ?", vehicle_configurator_id];
    while ([result next]) {
        rtn = [[client_vehicle_configurator alloc] init];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_class_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_class_id"]];
        rtn.vehicle_code = [result stringForColumn:@"vehicle_code"];
        rtn.item_code = [result stringForColumn:@"item_code"];
        rtn.item_model = [result stringForColumn:@"item_model"];
        rtn.display_name = [result stringForColumn:@"display_name"];
        rtn.vehicle_desc = [result stringForColumn:@"vehicle_desc"];
        rtn.vehicle_remark = [result stringForColumn:@"vehicle_remark"];
        break;
    }
    [db close];
    return rtn;
}

@end