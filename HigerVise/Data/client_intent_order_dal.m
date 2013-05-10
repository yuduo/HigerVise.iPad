#import "client_intent_order_dal.h"

@implementation client_intent_order_dal

+ (BOOL)exists:(NSString *)intent_order_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    FMResultSet *result = [db executeQuery:@"SELECT COUNT(intent_order_id) FROM client_intent_order WHERE intent_order_id = ?", intent_order_id];
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

+ (BOOL)add:(client_intent_order *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"INSERT INTO client_intent_order (intent_order_id, customer_id, dealer_id, intent_order_code, customer_code, dealer_code, vehicle_configurator_id, vehicle_code, vehicle_item_code, vehicle_item_model, vehicle_series, vehicle_pca_version, vehicle_edition_id, vehicle_edition_editionid, vehicle_edition_type, big_region_code, market_code, area_region_code, city_region_code, city_region_name, sale_empid, sale_empname, region_sale_empid, region_sale_empname, intent_from, intent_use, intent_qty, intent_mode, intent_delivery_date, intent_last_date, intent_publish_date, intent_buy_channel, intent_class, intent_is_sign, intent_remark, intent_status, is_send, is_used, create_time, create_userid, update_time, update_userid, data_version, data_status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", model.intent_order_id, model.customer_id, model.dealer_id, model.intent_order_code, model.customer_code, model.dealer_code, model.vehicle_configurator_id, model.vehicle_code, model.vehicle_item_code, model.vehicle_item_model, model.vehicle_series, model.vehicle_pca_version, model.vehicle_edition_id, model.vehicle_edition_editionid, model.vehicle_edition_type, model.big_region_code, model.market_code, model.area_region_code, model.city_region_code, model.city_region_name, model.sale_empid, model.sale_empname, model.region_sale_empid, model.region_sale_empname, model.intent_from, model.intent_use, model.intent_qty, model.intent_mode, model.intent_delivery_date, model.intent_last_date, model.intent_publish_date, model.intent_buy_channel, model.intent_class, model.intent_is_sign, model.intent_remark, model.intent_status, model.is_send, model.is_used, model.create_time, model.create_userid, model.update_time, model.update_userid, model.data_version, model.data_status];
    [db close];
    return rtn;
}

+ (BOOL)update:(client_intent_order *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"UPDATE client_intent_order SET customer_id = ?, dealer_id = ?, intent_order_code = ?, customer_code = ?, dealer_code = ?, vehicle_configurator_id = ?, vehicle_code = ?, vehicle_item_code = ?, vehicle_item_model = ?, vehicle_series = ?, vehicle_pca_version = ?, vehicle_edition_id = ?, vehicle_edition_editionid = ?, vehicle_edition_type = ?, big_region_code = ?, market_code = ?, area_region_code = ?, city_region_code = ?, city_region_name = ?, sale_empid = ?, sale_empname = ?, region_sale_empid = ?, region_sale_empname = ?, intent_from = ?, intent_use = ?, intent_qty = ?, intent_mode = ?, intent_delivery_date = ?, intent_last_date = ?, intent_publish_date = ?, intent_buy_channel = ?, intent_class = ?, intent_is_sign = ?, intent_remark = ?, intent_status = ?, is_send = ?, is_used = ?, create_time = ?, create_userid = ?, update_time = ?, update_userid = ?, data_version = ?, data_status = ? WHERE intent_order_id = ?", model.customer_id, model.dealer_id, model.intent_order_code, model.customer_code, model.dealer_code, model.vehicle_configurator_id, model.vehicle_code, model.vehicle_item_code, model.vehicle_item_model, model.vehicle_series, model.vehicle_pca_version, model.vehicle_edition_id, model.vehicle_edition_editionid, model.vehicle_edition_type, model.big_region_code, model.market_code, model.area_region_code, model.city_region_code, model.city_region_name, model.sale_empid, model.sale_empname, model.region_sale_empid, model.region_sale_empname, model.intent_from, model.intent_use, model.intent_qty, model.intent_mode, model.intent_delivery_date, model.intent_last_date, model.intent_publish_date, model.intent_buy_channel, model.intent_class, model.intent_is_sign, model.intent_remark, model.intent_status, model.is_send, model.is_used, model.create_time, model.create_userid, model.update_time, model.update_userid, model.data_version, model.data_status, model.intent_order_id];
    [db close];
    return rtn;
}

+ (BOOL)delete:(NSString *)intent_order_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"DELETE FROM client_intent_order WHERE intent_order_id = ?", intent_order_id];
    [db close];
    return rtn;
}

+ (BOOL)deleteList:(NSString *)where
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    NSString *strSql = [NSString stringWithFormat:@"DELETE FROM client_intent_order WHERE %@", where];
    rtn = [db executeUpdate:strSql];
    [db close];
    return rtn;
}

+ (client_intent_order *)get:(NSString *)intent_order_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    client_intent_order *rtn;
    FMResultSet *result = [db executeQuery:@"SELECT * FROM client_intent_order WHERE intent_order_id = ?", intent_order_id];
    while ([result next]) {
        rtn = [[client_intent_order alloc] init];
        rtn.intent_order_id = [result stringForColumn:@"intent_order_id"];
        rtn.customer_id = [result stringForColumn:@"customer_id"];
        rtn.dealer_id = [result stringForColumn:@"dealer_id"];
        rtn.intent_order_code = [result stringForColumn:@"intent_order_code"];
        rtn.customer_code = [result stringForColumn:@"customer_code"];
        rtn.dealer_code = [result stringForColumn:@"dealer_code"];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_code = [result stringForColumn:@"vehicle_code"];
        rtn.vehicle_item_code = [result stringForColumn:@"vehicle_item_code"];
        rtn.vehicle_item_model = [result stringForColumn:@"vehicle_item_model"];
        rtn.vehicle_series = [result stringForColumn:@"vehicle_series"];
        rtn.vehicle_pca_version = [NSNumber numberWithInt:[result intForColumn:@"vehicle_pca_version"]];
        rtn.vehicle_edition_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_edition_id"]];
        rtn.vehicle_edition_editionid = [NSNumber numberWithInt:[result intForColumn:@"vehicle_edition_editionid"]];
        rtn.vehicle_edition_type = [NSNumber numberWithInt:[result intForColumn:@"vehicle_edition_type"]];
        rtn.big_region_code = [result stringForColumn:@"big_region_code"];
        rtn.market_code = [result stringForColumn:@"market_code"];
        rtn.area_region_code = [result stringForColumn:@"area_region_code"];
        rtn.city_region_code = [result stringForColumn:@"city_region_code"];
        rtn.city_region_name = [result stringForColumn:@"city_region_name"];
        rtn.sale_empid = [result stringForColumn:@"sale_empid"];
        rtn.sale_empname = [result stringForColumn:@"sale_empname"];
        rtn.region_sale_empid = [result stringForColumn:@"region_sale_empid"];
        rtn.region_sale_empname = [result stringForColumn:@"region_sale_empname"];
        rtn.intent_from = [result stringForColumn:@"intent_from"];
        rtn.intent_use = [result stringForColumn:@"intent_use"];
        rtn.intent_qty = [NSNumber numberWithInt:[result intForColumn:@"intent_qty"]];
        rtn.intent_mode = [result stringForColumn:@"intent_mode"];
        rtn.intent_delivery_date = [result stringForColumn:@"intent_delivery_date"];
        rtn.intent_last_date = [result stringForColumn:@"intent_last_date"];
        rtn.intent_publish_date = [result stringForColumn:@"intent_publish_date"];
        rtn.intent_buy_channel = [result stringForColumn:@"intent_buy_channel"];
        rtn.intent_class = [result stringForColumn:@"intent_class"];
        rtn.intent_is_sign = [NSNumber numberWithInt:[result intForColumn:@"intent_is_sign"]];
        rtn.intent_remark = [result stringForColumn:@"intent_remark"];
        rtn.intent_status = [result stringForColumn:@"intent_status"];
        rtn.is_send = [NSNumber numberWithInt:[result intForColumn:@"is_send"]];
        rtn.is_used = [NSNumber numberWithInt:[result intForColumn:@"is_used"]];
        rtn.create_time = [result dateForColumn:@"create_time"];
        rtn.create_userid = [result stringForColumn:@"create_userid"];
        rtn.update_time = [result dateForColumn:@"update_time"];
        rtn.update_userid = [result stringForColumn:@"update_userid"];
        rtn.data_version = [NSNumber numberWithInt:[result intForColumn:@"data_version"]];
        rtn.data_status = [NSNumber numberWithInt:[result intForColumn:@"data_status"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_intent_order WHERE %@", where];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_intent_order *rtn = [[client_intent_order alloc] init];
        rtn.intent_order_id = [result stringForColumn:@"intent_order_id"];
        rtn.customer_id = [result stringForColumn:@"customer_id"];
        rtn.dealer_id = [result stringForColumn:@"dealer_id"];
        rtn.intent_order_code = [result stringForColumn:@"intent_order_code"];
        rtn.customer_code = [result stringForColumn:@"customer_code"];
        rtn.dealer_code = [result stringForColumn:@"dealer_code"];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_code = [result stringForColumn:@"vehicle_code"];
        rtn.vehicle_item_code = [result stringForColumn:@"vehicle_item_code"];
        rtn.vehicle_item_model = [result stringForColumn:@"vehicle_item_model"];
        rtn.vehicle_series = [result stringForColumn:@"vehicle_series"];
        rtn.vehicle_pca_version = [NSNumber numberWithInt:[result intForColumn:@"vehicle_pca_version"]];
        rtn.vehicle_edition_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_edition_id"]];
        rtn.vehicle_edition_editionid = [NSNumber numberWithInt:[result intForColumn:@"vehicle_edition_editionid"]];
        rtn.vehicle_edition_type = [NSNumber numberWithInt:[result intForColumn:@"vehicle_edition_type"]];
        rtn.big_region_code = [result stringForColumn:@"big_region_code"];
        rtn.market_code = [result stringForColumn:@"market_code"];
        rtn.area_region_code = [result stringForColumn:@"area_region_code"];
        rtn.city_region_code = [result stringForColumn:@"city_region_code"];
        rtn.city_region_name = [result stringForColumn:@"city_region_name"];
        rtn.sale_empid = [result stringForColumn:@"sale_empid"];
        rtn.sale_empname = [result stringForColumn:@"sale_empname"];
        rtn.region_sale_empid = [result stringForColumn:@"region_sale_empid"];
        rtn.region_sale_empname = [result stringForColumn:@"region_sale_empname"];
        rtn.intent_from = [result stringForColumn:@"intent_from"];
        rtn.intent_use = [result stringForColumn:@"intent_use"];
        rtn.intent_qty = [NSNumber numberWithInt:[result intForColumn:@"intent_qty"]];
        rtn.intent_mode = [result stringForColumn:@"intent_mode"];
        rtn.intent_delivery_date = [result stringForColumn:@"intent_delivery_date"];
        rtn.intent_last_date = [result stringForColumn:@"intent_last_date"];
        rtn.intent_publish_date = [result stringForColumn:@"intent_publish_date"];
        rtn.intent_buy_channel = [result stringForColumn:@"intent_buy_channel"];
        rtn.intent_class = [result stringForColumn:@"intent_class"];
        rtn.intent_is_sign = [NSNumber numberWithInt:[result intForColumn:@"intent_is_sign"]];
        rtn.intent_remark = [result stringForColumn:@"intent_remark"];
        rtn.intent_status = [result stringForColumn:@"intent_status"];
        rtn.is_send = [NSNumber numberWithInt:[result intForColumn:@"is_send"]];
        rtn.is_used = [NSNumber numberWithInt:[result intForColumn:@"is_used"]];
        rtn.create_time = [result dateForColumn:@"create_time"];
        rtn.create_userid = [result stringForColumn:@"create_userid"];
        rtn.update_time = [result dateForColumn:@"update_time"];
        rtn.update_userid = [result stringForColumn:@"update_userid"];
        rtn.data_version = [NSNumber numberWithInt:[result intForColumn:@"data_version"]];
        rtn.data_status = [NSNumber numberWithInt:[result intForColumn:@"data_status"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_intent_order WHERE %@ ORDER BY %@", where, order];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_intent_order *rtn = [[client_intent_order alloc] init];
        rtn.intent_order_id = [result stringForColumn:@"intent_order_id"];
        rtn.customer_id = [result stringForColumn:@"customer_id"];
        rtn.dealer_id = [result stringForColumn:@"dealer_id"];
        rtn.intent_order_code = [result stringForColumn:@"intent_order_code"];
        rtn.customer_code = [result stringForColumn:@"customer_code"];
        rtn.dealer_code = [result stringForColumn:@"dealer_code"];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_code = [result stringForColumn:@"vehicle_code"];
        rtn.vehicle_item_code = [result stringForColumn:@"vehicle_item_code"];
        rtn.vehicle_item_model = [result stringForColumn:@"vehicle_item_model"];
        rtn.vehicle_series = [result stringForColumn:@"vehicle_series"];
        rtn.vehicle_pca_version = [NSNumber numberWithInt:[result intForColumn:@"vehicle_pca_version"]];
        rtn.vehicle_edition_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_edition_id"]];
        rtn.vehicle_edition_editionid = [NSNumber numberWithInt:[result intForColumn:@"vehicle_edition_editionid"]];
        rtn.vehicle_edition_type = [NSNumber numberWithInt:[result intForColumn:@"vehicle_edition_type"]];
        rtn.big_region_code = [result stringForColumn:@"big_region_code"];
        rtn.market_code = [result stringForColumn:@"market_code"];
        rtn.area_region_code = [result stringForColumn:@"area_region_code"];
        rtn.city_region_code = [result stringForColumn:@"city_region_code"];
        rtn.city_region_name = [result stringForColumn:@"city_region_name"];
        rtn.sale_empid = [result stringForColumn:@"sale_empid"];
        rtn.sale_empname = [result stringForColumn:@"sale_empname"];
        rtn.region_sale_empid = [result stringForColumn:@"region_sale_empid"];
        rtn.region_sale_empname = [result stringForColumn:@"region_sale_empname"];
        rtn.intent_from = [result stringForColumn:@"intent_from"];
        rtn.intent_use = [result stringForColumn:@"intent_use"];
        rtn.intent_qty = [NSNumber numberWithInt:[result intForColumn:@"intent_qty"]];
        rtn.intent_mode = [result stringForColumn:@"intent_mode"];
        rtn.intent_delivery_date = [result stringForColumn:@"intent_delivery_date"];
        rtn.intent_last_date = [result stringForColumn:@"intent_last_date"];
        rtn.intent_publish_date = [result stringForColumn:@"intent_publish_date"];
        rtn.intent_buy_channel = [result stringForColumn:@"intent_buy_channel"];
        rtn.intent_class = [result stringForColumn:@"intent_class"];
        rtn.intent_is_sign = [NSNumber numberWithInt:[result intForColumn:@"intent_is_sign"]];
        rtn.intent_remark = [result stringForColumn:@"intent_remark"];
        rtn.intent_status = [result stringForColumn:@"intent_status"];
        rtn.is_send = [NSNumber numberWithInt:[result intForColumn:@"is_send"]];
        rtn.is_used = [NSNumber numberWithInt:[result intForColumn:@"is_used"]];
        rtn.create_time = [result dateForColumn:@"create_time"];
        rtn.create_userid = [result stringForColumn:@"create_userid"];
        rtn.update_time = [result dateForColumn:@"update_time"];
        rtn.update_userid = [result stringForColumn:@"update_userid"];
        rtn.data_version = [NSNumber numberWithInt:[result intForColumn:@"data_version"]];
        rtn.data_status = [NSNumber numberWithInt:[result intForColumn:@"data_status"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_intent_order WHERE %@ ORDER BY %@ LIMIT 0,%d", where, order, top];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_intent_order *rtn = [[client_intent_order alloc] init];
        rtn.intent_order_id = [result stringForColumn:@"intent_order_id"];
        rtn.customer_id = [result stringForColumn:@"customer_id"];
        rtn.dealer_id = [result stringForColumn:@"dealer_id"];
        rtn.intent_order_code = [result stringForColumn:@"intent_order_code"];
        rtn.customer_code = [result stringForColumn:@"customer_code"];
        rtn.dealer_code = [result stringForColumn:@"dealer_code"];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_code = [result stringForColumn:@"vehicle_code"];
        rtn.vehicle_item_code = [result stringForColumn:@"vehicle_item_code"];
        rtn.vehicle_item_model = [result stringForColumn:@"vehicle_item_model"];
        rtn.vehicle_series = [result stringForColumn:@"vehicle_series"];
        rtn.vehicle_pca_version = [NSNumber numberWithInt:[result intForColumn:@"vehicle_pca_version"]];
        rtn.vehicle_edition_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_edition_id"]];
        rtn.vehicle_edition_editionid = [NSNumber numberWithInt:[result intForColumn:@"vehicle_edition_editionid"]];
        rtn.vehicle_edition_type = [NSNumber numberWithInt:[result intForColumn:@"vehicle_edition_type"]];
        rtn.big_region_code = [result stringForColumn:@"big_region_code"];
        rtn.market_code = [result stringForColumn:@"market_code"];
        rtn.area_region_code = [result stringForColumn:@"area_region_code"];
        rtn.city_region_code = [result stringForColumn:@"city_region_code"];
        rtn.city_region_name = [result stringForColumn:@"city_region_name"];
        rtn.sale_empid = [result stringForColumn:@"sale_empid"];
        rtn.sale_empname = [result stringForColumn:@"sale_empname"];
        rtn.region_sale_empid = [result stringForColumn:@"region_sale_empid"];
        rtn.region_sale_empname = [result stringForColumn:@"region_sale_empname"];
        rtn.intent_from = [result stringForColumn:@"intent_from"];
        rtn.intent_use = [result stringForColumn:@"intent_use"];
        rtn.intent_qty = [NSNumber numberWithInt:[result intForColumn:@"intent_qty"]];
        rtn.intent_mode = [result stringForColumn:@"intent_mode"];
        rtn.intent_delivery_date = [result stringForColumn:@"intent_delivery_date"];
        rtn.intent_last_date = [result stringForColumn:@"intent_last_date"];
        rtn.intent_publish_date = [result stringForColumn:@"intent_publish_date"];
        rtn.intent_buy_channel = [result stringForColumn:@"intent_buy_channel"];
        rtn.intent_class = [result stringForColumn:@"intent_class"];
        rtn.intent_is_sign = [NSNumber numberWithInt:[result intForColumn:@"intent_is_sign"]];
        rtn.intent_remark = [result stringForColumn:@"intent_remark"];
        rtn.intent_status = [result stringForColumn:@"intent_status"];
        rtn.is_send = [NSNumber numberWithInt:[result intForColumn:@"is_send"]];
        rtn.is_used = [NSNumber numberWithInt:[result intForColumn:@"is_used"]];
        rtn.create_time = [result dateForColumn:@"create_time"];
        rtn.create_userid = [result stringForColumn:@"create_userid"];
        rtn.update_time = [result dateForColumn:@"update_time"];
        rtn.update_userid = [result stringForColumn:@"update_userid"];
        rtn.data_version = [NSNumber numberWithInt:[result intForColumn:@"data_version"]];
        rtn.data_status = [NSNumber numberWithInt:[result intForColumn:@"data_status"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_intent_order WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_intent_order *rtn = [[client_intent_order alloc] init];
        rtn.intent_order_id = [result stringForColumn:@"intent_order_id"];
        rtn.customer_id = [result stringForColumn:@"customer_id"];
        rtn.dealer_id = [result stringForColumn:@"dealer_id"];
        rtn.intent_order_code = [result stringForColumn:@"intent_order_code"];
        rtn.customer_code = [result stringForColumn:@"customer_code"];
        rtn.dealer_code = [result stringForColumn:@"dealer_code"];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_code = [result stringForColumn:@"vehicle_code"];
        rtn.vehicle_item_code = [result stringForColumn:@"vehicle_item_code"];
        rtn.vehicle_item_model = [result stringForColumn:@"vehicle_item_model"];
        rtn.vehicle_series = [result stringForColumn:@"vehicle_series"];
        rtn.vehicle_pca_version = [NSNumber numberWithInt:[result intForColumn:@"vehicle_pca_version"]];
        rtn.vehicle_edition_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_edition_id"]];
        rtn.vehicle_edition_editionid = [NSNumber numberWithInt:[result intForColumn:@"vehicle_edition_editionid"]];
        rtn.vehicle_edition_type = [NSNumber numberWithInt:[result intForColumn:@"vehicle_edition_type"]];
        rtn.big_region_code = [result stringForColumn:@"big_region_code"];
        rtn.market_code = [result stringForColumn:@"market_code"];
        rtn.area_region_code = [result stringForColumn:@"area_region_code"];
        rtn.city_region_code = [result stringForColumn:@"city_region_code"];
        rtn.city_region_name = [result stringForColumn:@"city_region_name"];
        rtn.sale_empid = [result stringForColumn:@"sale_empid"];
        rtn.sale_empname = [result stringForColumn:@"sale_empname"];
        rtn.region_sale_empid = [result stringForColumn:@"region_sale_empid"];
        rtn.region_sale_empname = [result stringForColumn:@"region_sale_empname"];
        rtn.intent_from = [result stringForColumn:@"intent_from"];
        rtn.intent_use = [result stringForColumn:@"intent_use"];
        rtn.intent_qty = [NSNumber numberWithInt:[result intForColumn:@"intent_qty"]];
        rtn.intent_mode = [result stringForColumn:@"intent_mode"];
        rtn.intent_delivery_date = [result stringForColumn:@"intent_delivery_date"];
        rtn.intent_last_date = [result stringForColumn:@"intent_last_date"];
        rtn.intent_publish_date = [result stringForColumn:@"intent_publish_date"];
        rtn.intent_buy_channel = [result stringForColumn:@"intent_buy_channel"];
        rtn.intent_class = [result stringForColumn:@"intent_class"];
        rtn.intent_is_sign = [NSNumber numberWithInt:[result intForColumn:@"intent_is_sign"]];
        rtn.intent_remark = [result stringForColumn:@"intent_remark"];
        rtn.intent_status = [result stringForColumn:@"intent_status"];
        rtn.is_send = [NSNumber numberWithInt:[result intForColumn:@"is_send"]];
        rtn.is_used = [NSNumber numberWithInt:[result intForColumn:@"is_used"]];
        rtn.create_time = [result dateForColumn:@"create_time"];
        rtn.create_userid = [result stringForColumn:@"create_userid"];
        rtn.update_time = [result dateForColumn:@"update_time"];
        rtn.update_userid = [result stringForColumn:@"update_userid"];
        rtn.data_version = [NSNumber numberWithInt:[result intForColumn:@"data_version"]];
        rtn.data_status = [NSNumber numberWithInt:[result intForColumn:@"data_status"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_intent_order WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_intent_order *rtn = [[client_intent_order alloc] init];
        rtn.intent_order_id = [result stringForColumn:@"intent_order_id"];
        rtn.customer_id = [result stringForColumn:@"customer_id"];
        rtn.dealer_id = [result stringForColumn:@"dealer_id"];
        rtn.intent_order_code = [result stringForColumn:@"intent_order_code"];
        rtn.customer_code = [result stringForColumn:@"customer_code"];
        rtn.dealer_code = [result stringForColumn:@"dealer_code"];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_code = [result stringForColumn:@"vehicle_code"];
        rtn.vehicle_item_code = [result stringForColumn:@"vehicle_item_code"];
        rtn.vehicle_item_model = [result stringForColumn:@"vehicle_item_model"];
        rtn.vehicle_series = [result stringForColumn:@"vehicle_series"];
        rtn.vehicle_pca_version = [NSNumber numberWithInt:[result intForColumn:@"vehicle_pca_version"]];
        rtn.vehicle_edition_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_edition_id"]];
        rtn.vehicle_edition_editionid = [NSNumber numberWithInt:[result intForColumn:@"vehicle_edition_editionid"]];
        rtn.vehicle_edition_type = [NSNumber numberWithInt:[result intForColumn:@"vehicle_edition_type"]];
        rtn.big_region_code = [result stringForColumn:@"big_region_code"];
        rtn.market_code = [result stringForColumn:@"market_code"];
        rtn.area_region_code = [result stringForColumn:@"area_region_code"];
        rtn.city_region_code = [result stringForColumn:@"city_region_code"];
        rtn.city_region_name = [result stringForColumn:@"city_region_name"];
        rtn.sale_empid = [result stringForColumn:@"sale_empid"];
        rtn.sale_empname = [result stringForColumn:@"sale_empname"];
        rtn.region_sale_empid = [result stringForColumn:@"region_sale_empid"];
        rtn.region_sale_empname = [result stringForColumn:@"region_sale_empname"];
        rtn.intent_from = [result stringForColumn:@"intent_from"];
        rtn.intent_use = [result stringForColumn:@"intent_use"];
        rtn.intent_qty = [NSNumber numberWithInt:[result intForColumn:@"intent_qty"]];
        rtn.intent_mode = [result stringForColumn:@"intent_mode"];
        rtn.intent_delivery_date = [result stringForColumn:@"intent_delivery_date"];
        rtn.intent_last_date = [result stringForColumn:@"intent_last_date"];
        rtn.intent_publish_date = [result stringForColumn:@"intent_publish_date"];
        rtn.intent_buy_channel = [result stringForColumn:@"intent_buy_channel"];
        rtn.intent_class = [result stringForColumn:@"intent_class"];
        rtn.intent_is_sign = [NSNumber numberWithInt:[result intForColumn:@"intent_is_sign"]];
        rtn.intent_remark = [result stringForColumn:@"intent_remark"];
        rtn.intent_status = [result stringForColumn:@"intent_status"];
        rtn.is_send = [NSNumber numberWithInt:[result intForColumn:@"is_send"]];
        rtn.is_used = [NSNumber numberWithInt:[result intForColumn:@"is_used"]];
        rtn.create_time = [result dateForColumn:@"create_time"];
        rtn.create_userid = [result stringForColumn:@"create_userid"];
        rtn.update_time = [result dateForColumn:@"update_time"];
        rtn.update_userid = [result stringForColumn:@"update_userid"];
        rtn.data_version = [NSNumber numberWithInt:[result intForColumn:@"data_version"]];
        rtn.data_status = [NSNumber numberWithInt:[result intForColumn:@"data_status"]];
        [array addObject:rtn];
    }
    [db close];
    return array;
}

+ (client_intent_order *)convertJsonToModel:(NSDictionary *)json
{
    client_intent_order *model = [[client_intent_order alloc] init];
    model.intent_order_id = [json objectForKey:@"intent_order_id"];
    model.customer_id = [json objectForKey:@"customer_id"];
    model.dealer_id = [json objectForKey:@"dealer_id"];
    model.intent_order_code = [json objectForKey:@"intent_order_code"];
    model.customer_code = [json objectForKey:@"customer_code"];
    model.dealer_code = [json objectForKey:@"dealer_code"];
    model.vehicle_configurator_id = [json objectForKey:@"vehicle_configurator_id"];
    model.vehicle_code = [json objectForKey:@"vehicle_code"];
    model.vehicle_item_code = [json objectForKey:@"vehicle_item_code"];
    model.vehicle_item_model = [json objectForKey:@"vehicle_item_model"];
    model.vehicle_series = [json objectForKey:@"vehicle_series"];
    model.vehicle_pca_version = [json objectForKey:@"vehicle_pca_version"];
    model.vehicle_edition_id = [json objectForKey:@"vehicle_edition_id"];
    model.vehicle_edition_editionid = [json objectForKey:@"vehicle_edition_editionid"];
    model.vehicle_edition_type = [json objectForKey:@"vehicle_edition_type"];
    model.big_region_code = [json objectForKey:@"big_region_code"];
    model.market_code = [json objectForKey:@"market_code"];
    model.area_region_code = [json objectForKey:@"area_region_code"];
    model.city_region_code = [json objectForKey:@"city_region_code"];
    model.city_region_name = [json objectForKey:@"city_region_name"];
    model.sale_empid = [json objectForKey:@"sale_empid"];
    model.sale_empname = [json objectForKey:@"sale_empname"];
    model.region_sale_empid = [json objectForKey:@"region_sale_empid"];
    model.region_sale_empname = [json objectForKey:@"region_sale_empname"];
    model.intent_from = [json objectForKey:@"intent_from"];
    model.intent_use = [json objectForKey:@"intent_use"];
    model.intent_qty = [json objectForKey:@"intent_qty"];
    model.intent_mode = [json objectForKey:@"intent_mode"];
    model.intent_delivery_date = [json objectForKey:@"intent_delivery_date"];
    model.intent_last_date = [json objectForKey:@"intent_last_date"];
    model.intent_publish_date = [json objectForKey:@"intent_publish_date"];
    model.intent_buy_channel = [json objectForKey:@"intent_buy_channel"];
    model.intent_class = [json objectForKey:@"intent_class"];
    model.intent_is_sign = [json objectForKey:@"intent_is_sign"];
    model.intent_remark = [json objectForKey:@"intent_remark"];
    model.intent_status = [json objectForKey:@"intent_status"];
    model.is_send = [json objectForKey:@"is_send"];
    model.is_used = [json objectForKey:@"is_used"];
    model.create_time =[BaseInfo getDateFromMSDateString:[json objectForKey:@"create_time"]];
    model.create_userid = [json objectForKey:@"create_userid"];
    model.update_time =[BaseInfo getDateFromMSDateString:[json objectForKey:@"update_time"]];
    model.update_userid = [json objectForKey:@"update_userid"];
    model.data_version = [json objectForKey:@"data_version"];
    model.data_status = [json objectForKey:@"data_status"];
    return model;
}

+ (NSArray *)convertJsonToList:(NSArray *)jsons
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSDictionary *json in jsons) {
        client_intent_order *model = [[client_intent_order alloc] init];
        model.intent_order_id = [json objectForKey:@"intent_order_id"];
        model.customer_id = [json objectForKey:@"customer_id"];
        model.dealer_id = [json objectForKey:@"dealer_id"];
        model.intent_order_code = [json objectForKey:@"intent_order_code"];
        model.customer_code = [json objectForKey:@"customer_code"];
        model.dealer_code = [json objectForKey:@"dealer_code"];
        model.vehicle_configurator_id = [json objectForKey:@"vehicle_configurator_id"];
        model.vehicle_code = [json objectForKey:@"vehicle_code"];
        model.vehicle_item_code = [json objectForKey:@"vehicle_item_code"];
        model.vehicle_item_model = [json objectForKey:@"vehicle_item_model"];
        model.vehicle_series = [json objectForKey:@"vehicle_series"];
        model.vehicle_pca_version = [json objectForKey:@"vehicle_pca_version"];
        model.vehicle_edition_id = [json objectForKey:@"vehicle_edition_id"];
        model.vehicle_edition_editionid = [json objectForKey:@"vehicle_edition_editionid"];
        model.vehicle_edition_type = [json objectForKey:@"vehicle_edition_type"];
        model.big_region_code = [json objectForKey:@"big_region_code"];
        model.market_code = [json objectForKey:@"market_code"];
        model.area_region_code = [json objectForKey:@"area_region_code"];
        model.city_region_code = [json objectForKey:@"city_region_code"];
        model.city_region_name = [json objectForKey:@"city_region_name"];
        model.sale_empid = [json objectForKey:@"sale_empid"];
        model.sale_empname = [json objectForKey:@"sale_empname"];
        model.region_sale_empid = [json objectForKey:@"region_sale_empid"];
        model.region_sale_empname = [json objectForKey:@"region_sale_empname"];
        model.intent_from = [json objectForKey:@"intent_from"];
        model.intent_use = [json objectForKey:@"intent_use"];
        model.intent_qty = [json objectForKey:@"intent_qty"];
        model.intent_mode = [json objectForKey:@"intent_mode"];
        model.intent_delivery_date = [json objectForKey:@"intent_delivery_date"];
        model.intent_last_date = [json objectForKey:@"intent_last_date"];
        model.intent_publish_date = [json objectForKey:@"intent_publish_date"];
        model.intent_buy_channel = [json objectForKey:@"intent_buy_channel"];
        model.intent_class = [json objectForKey:@"intent_class"];
        model.intent_is_sign = [json objectForKey:@"intent_is_sign"];
        model.intent_remark = [json objectForKey:@"intent_remark"];
        model.intent_status = [json objectForKey:@"intent_status"];
        model.is_send = [json objectForKey:@"is_send"];
        model.is_used = [json objectForKey:@"is_used"];
        model.create_time =[BaseInfo getDateFromMSDateString:[json objectForKey:@"create_time"]];
        model.create_userid = [json objectForKey:@"create_userid"];
        model.update_time =[BaseInfo getDateFromMSDateString:[json objectForKey:@"update_time"]];
        model.update_userid = [json objectForKey:@"update_userid"];
        model.data_version = [json objectForKey:@"data_version"];
        model.data_status = [json objectForKey:@"data_status"];
        [array addObject:model];
    }
    return array;
}

@end