#import "client_customer_dal.h"

@implementation client_customer_dal

+ (BOOL)exists:(NSString *)customer_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    FMResultSet *result = [db executeQuery:@"SELECT COUNT(customer_id) FROM client_customer WHERE customer_id = ?", customer_id];
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

+ (BOOL)add:(client_customer *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"INSERT INTO client_customer (customer_id, customer_code, customer_picture_url, customer_name, customer_name_brief, global_region_code, nation_region_code, city_region_code, county_region_code, customer_address, customer_phone, customer_mobile, customer_fax, customer_zip_code, customer_mail, customer_trade_code, customer_owner, customer_kind_id, customer_class_id, customer_desc, customer_remark, customer_status, is_send, is_used, create_userid, create_time, update_userid, update_time, data_version, data_status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", model.customer_id, model.customer_code, model.customer_picture_url, model.customer_name, model.customer_name_brief, model.global_region_code, model.nation_region_code, model.city_region_code, model.county_region_code, model.customer_address, model.customer_phone, model.customer_mobile, model.customer_fax, model.customer_zip_code, model.customer_mail, model.customer_trade_code, model.customer_owner, model.customer_kind_id, model.customer_class_id, model.customer_desc, model.customer_remark, model.customer_status, model.is_send, model.is_used, model.create_userid, model.create_time, model.update_userid, model.update_time, model.data_version, model.data_status];
    [db close];
    return rtn;
}

+ (BOOL)update:(client_customer *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"UPDATE client_customer SET customer_code = ?, customer_picture_url = ?, customer_name = ?, customer_name_brief = ?, global_region_code = ?, nation_region_code = ?, city_region_code = ?, county_region_code = ?, customer_address = ?, customer_phone = ?, customer_mobile = ?, customer_fax = ?, customer_zip_code = ?, customer_mail = ?, customer_trade_code = ?, customer_owner = ?, customer_kind_id = ?, customer_class_id = ?, customer_desc = ?, customer_remark = ?, customer_status = ?, is_send = ?, is_used = ?, create_userid = ?, create_time = ?, update_userid = ?, update_time = ?, data_version = ?, data_status = ? WHERE customer_id = ?", model.customer_code, model.customer_picture_url, model.customer_name, model.customer_name_brief, model.global_region_code, model.nation_region_code, model.city_region_code, model.county_region_code, model.customer_address, model.customer_phone, model.customer_mobile, model.customer_fax, model.customer_zip_code, model.customer_mail, model.customer_trade_code, model.customer_owner, model.customer_kind_id, model.customer_class_id, model.customer_desc, model.customer_remark, model.customer_status, model.is_send, model.is_used, model.create_userid, model.create_time, model.update_userid, model.update_time, model.data_version, model.data_status, model.customer_id];
    [db close];
    return rtn;
}

+ (BOOL)delete:(NSString *)customer_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"DELETE FROM client_customer WHERE customer_id = ?", customer_id];
    [db close];
    return rtn;
}

+ (BOOL)deleteList:(NSString *)where
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    NSString *strSql = [NSString stringWithFormat:@"DELETE FROM client_customer WHERE %@", where];
    rtn = [db executeUpdate:strSql];
    [db close];
    return rtn;
}

+ (client_customer *)get:(NSString *)customer_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    client_customer *rtn;
    FMResultSet *result = [db executeQuery:@"SELECT * FROM client_customer WHERE customer_id = ?", customer_id];
    while ([result next]) {
        rtn = [[client_customer alloc] init];
        rtn.customer_id = [result stringForColumn:@"customer_id"];
        rtn.customer_code = [result stringForColumn:@"customer_code"];
        rtn.customer_picture_url = [result stringForColumn:@"customer_picture_url"];
        rtn.customer_name = [result stringForColumn:@"customer_name"];
        rtn.customer_name_brief = [result stringForColumn:@"customer_name_brief"];
        rtn.global_region_code = [result stringForColumn:@"global_region_code"];
        rtn.nation_region_code = [result stringForColumn:@"nation_region_code"];
        rtn.city_region_code = [result stringForColumn:@"city_region_code"];
        rtn.county_region_code = [result stringForColumn:@"county_region_code"];
        rtn.customer_address = [result stringForColumn:@"customer_address"];
        rtn.customer_phone = [result stringForColumn:@"customer_phone"];
        rtn.customer_mobile = [result stringForColumn:@"customer_mobile"];
        rtn.customer_fax = [result stringForColumn:@"customer_fax"];
        rtn.customer_zip_code = [result stringForColumn:@"customer_zip_code"];
        rtn.customer_mail = [result stringForColumn:@"customer_mail"];
        rtn.customer_trade_code = [result stringForColumn:@"customer_trade_code"];
        rtn.customer_owner = [result stringForColumn:@"customer_owner"];
        rtn.customer_kind_id = [result stringForColumn:@"customer_kind_id"];
        rtn.customer_class_id = [result stringForColumn:@"customer_class_id"];
        rtn.customer_desc = [result stringForColumn:@"customer_desc"];
        rtn.customer_remark = [result stringForColumn:@"customer_remark"];
        rtn.customer_status = [result stringForColumn:@"customer_status"];
        rtn.is_send = [NSNumber numberWithInt:[result intForColumn:@"is_send"]];
        rtn.is_used = [NSNumber numberWithInt:[result intForColumn:@"is_used"]];
        rtn.create_userid = [result stringForColumn:@"create_userid"];
        rtn.create_time = [result dateForColumn:@"create_time"];
        rtn.update_userid = [result stringForColumn:@"update_userid"];
        rtn.update_time = [result dateForColumn:@"update_time"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_customer WHERE %@", where];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_customer *rtn = [[client_customer alloc] init];
        rtn.customer_id = [result stringForColumn:@"customer_id"];
        rtn.customer_code = [result stringForColumn:@"customer_code"];
        rtn.customer_picture_url = [result stringForColumn:@"customer_picture_url"];
        rtn.customer_name = [result stringForColumn:@"customer_name"];
        rtn.customer_name_brief = [result stringForColumn:@"customer_name_brief"];
        rtn.global_region_code = [result stringForColumn:@"global_region_code"];
        rtn.nation_region_code = [result stringForColumn:@"nation_region_code"];
        rtn.city_region_code = [result stringForColumn:@"city_region_code"];
        rtn.county_region_code = [result stringForColumn:@"county_region_code"];
        rtn.customer_address = [result stringForColumn:@"customer_address"];
        rtn.customer_phone = [result stringForColumn:@"customer_phone"];
        rtn.customer_mobile = [result stringForColumn:@"customer_mobile"];
        rtn.customer_fax = [result stringForColumn:@"customer_fax"];
        rtn.customer_zip_code = [result stringForColumn:@"customer_zip_code"];
        rtn.customer_mail = [result stringForColumn:@"customer_mail"];
        rtn.customer_trade_code = [result stringForColumn:@"customer_trade_code"];
        rtn.customer_owner = [result stringForColumn:@"customer_owner"];
        rtn.customer_kind_id = [result stringForColumn:@"customer_kind_id"];
        rtn.customer_class_id = [result stringForColumn:@"customer_class_id"];
        rtn.customer_desc = [result stringForColumn:@"customer_desc"];
        rtn.customer_remark = [result stringForColumn:@"customer_remark"];
        rtn.customer_status = [result stringForColumn:@"customer_status"];
        rtn.is_send = [NSNumber numberWithInt:[result intForColumn:@"is_send"]];
        rtn.is_used = [NSNumber numberWithInt:[result intForColumn:@"is_used"]];
        rtn.create_userid = [result stringForColumn:@"create_userid"];
        rtn.create_time = [result dateForColumn:@"create_time"];
        rtn.update_userid = [result stringForColumn:@"update_userid"];
        rtn.update_time = [result dateForColumn:@"update_time"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_customer WHERE %@ ORDER BY %@", where, order];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_customer *rtn = [[client_customer alloc] init];
        rtn.customer_id = [result stringForColumn:@"customer_id"];
        rtn.customer_code = [result stringForColumn:@"customer_code"];
        rtn.customer_picture_url = [result stringForColumn:@"customer_picture_url"];
        rtn.customer_name = [result stringForColumn:@"customer_name"];
        rtn.customer_name_brief = [result stringForColumn:@"customer_name_brief"];
        rtn.global_region_code = [result stringForColumn:@"global_region_code"];
        rtn.nation_region_code = [result stringForColumn:@"nation_region_code"];
        rtn.city_region_code = [result stringForColumn:@"city_region_code"];
        rtn.county_region_code = [result stringForColumn:@"county_region_code"];
        rtn.customer_address = [result stringForColumn:@"customer_address"];
        rtn.customer_phone = [result stringForColumn:@"customer_phone"];
        rtn.customer_mobile = [result stringForColumn:@"customer_mobile"];
        rtn.customer_fax = [result stringForColumn:@"customer_fax"];
        rtn.customer_zip_code = [result stringForColumn:@"customer_zip_code"];
        rtn.customer_mail = [result stringForColumn:@"customer_mail"];
        rtn.customer_trade_code = [result stringForColumn:@"customer_trade_code"];
        rtn.customer_owner = [result stringForColumn:@"customer_owner"];
        rtn.customer_kind_id = [result stringForColumn:@"customer_kind_id"];
        rtn.customer_class_id = [result stringForColumn:@"customer_class_id"];
        rtn.customer_desc = [result stringForColumn:@"customer_desc"];
        rtn.customer_remark = [result stringForColumn:@"customer_remark"];
        rtn.customer_status = [result stringForColumn:@"customer_status"];
        rtn.is_send = [NSNumber numberWithInt:[result intForColumn:@"is_send"]];
        rtn.is_used = [NSNumber numberWithInt:[result intForColumn:@"is_used"]];
        rtn.create_userid = [result stringForColumn:@"create_userid"];
        rtn.create_time = [result dateForColumn:@"create_time"];
        rtn.update_userid = [result stringForColumn:@"update_userid"];
        rtn.update_time = [result dateForColumn:@"update_time"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_customer WHERE %@ ORDER BY %@ LIMIT 0,%d", where, order, top];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_customer *rtn = [[client_customer alloc] init];
        rtn.customer_id = [result stringForColumn:@"customer_id"];
        rtn.customer_code = [result stringForColumn:@"customer_code"];
        rtn.customer_picture_url = [result stringForColumn:@"customer_picture_url"];
        rtn.customer_name = [result stringForColumn:@"customer_name"];
        rtn.customer_name_brief = [result stringForColumn:@"customer_name_brief"];
        rtn.global_region_code = [result stringForColumn:@"global_region_code"];
        rtn.nation_region_code = [result stringForColumn:@"nation_region_code"];
        rtn.city_region_code = [result stringForColumn:@"city_region_code"];
        rtn.county_region_code = [result stringForColumn:@"county_region_code"];
        rtn.customer_address = [result stringForColumn:@"customer_address"];
        rtn.customer_phone = [result stringForColumn:@"customer_phone"];
        rtn.customer_mobile = [result stringForColumn:@"customer_mobile"];
        rtn.customer_fax = [result stringForColumn:@"customer_fax"];
        rtn.customer_zip_code = [result stringForColumn:@"customer_zip_code"];
        rtn.customer_mail = [result stringForColumn:@"customer_mail"];
        rtn.customer_trade_code = [result stringForColumn:@"customer_trade_code"];
        rtn.customer_owner = [result stringForColumn:@"customer_owner"];
        rtn.customer_kind_id = [result stringForColumn:@"customer_kind_id"];
        rtn.customer_class_id = [result stringForColumn:@"customer_class_id"];
        rtn.customer_desc = [result stringForColumn:@"customer_desc"];
        rtn.customer_remark = [result stringForColumn:@"customer_remark"];
        rtn.customer_status = [result stringForColumn:@"customer_status"];
        rtn.is_send = [NSNumber numberWithInt:[result intForColumn:@"is_send"]];
        rtn.is_used = [NSNumber numberWithInt:[result intForColumn:@"is_used"]];
        rtn.create_userid = [result stringForColumn:@"create_userid"];
        rtn.create_time = [result dateForColumn:@"create_time"];
        rtn.update_userid = [result stringForColumn:@"update_userid"];
        rtn.update_time = [result dateForColumn:@"update_time"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_customer WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_customer *rtn = [[client_customer alloc] init];
        rtn.customer_id = [result stringForColumn:@"customer_id"];
        rtn.customer_code = [result stringForColumn:@"customer_code"];
        rtn.customer_picture_url = [result stringForColumn:@"customer_picture_url"];
        rtn.customer_name = [result stringForColumn:@"customer_name"];
        rtn.customer_name_brief = [result stringForColumn:@"customer_name_brief"];
        rtn.global_region_code = [result stringForColumn:@"global_region_code"];
        rtn.nation_region_code = [result stringForColumn:@"nation_region_code"];
        rtn.city_region_code = [result stringForColumn:@"city_region_code"];
        rtn.county_region_code = [result stringForColumn:@"county_region_code"];
        rtn.customer_address = [result stringForColumn:@"customer_address"];
        rtn.customer_phone = [result stringForColumn:@"customer_phone"];
        rtn.customer_mobile = [result stringForColumn:@"customer_mobile"];
        rtn.customer_fax = [result stringForColumn:@"customer_fax"];
        rtn.customer_zip_code = [result stringForColumn:@"customer_zip_code"];
        rtn.customer_mail = [result stringForColumn:@"customer_mail"];
        rtn.customer_trade_code = [result stringForColumn:@"customer_trade_code"];
        rtn.customer_owner = [result stringForColumn:@"customer_owner"];
        rtn.customer_kind_id = [result stringForColumn:@"customer_kind_id"];
        rtn.customer_class_id = [result stringForColumn:@"customer_class_id"];
        rtn.customer_desc = [result stringForColumn:@"customer_desc"];
        rtn.customer_remark = [result stringForColumn:@"customer_remark"];
        rtn.customer_status = [result stringForColumn:@"customer_status"];
        rtn.is_send = [NSNumber numberWithInt:[result intForColumn:@"is_send"]];
        rtn.is_used = [NSNumber numberWithInt:[result intForColumn:@"is_used"]];
        rtn.create_userid = [result stringForColumn:@"create_userid"];
        rtn.create_time = [result dateForColumn:@"create_time"];
        rtn.update_userid = [result stringForColumn:@"update_userid"];
        rtn.update_time = [result dateForColumn:@"update_time"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_customer WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_customer *rtn = [[client_customer alloc] init];
        rtn.customer_id = [result stringForColumn:@"customer_id"];
        rtn.customer_code = [result stringForColumn:@"customer_code"];
        rtn.customer_picture_url = [result stringForColumn:@"customer_picture_url"];
        rtn.customer_name = [result stringForColumn:@"customer_name"];
        rtn.customer_name_brief = [result stringForColumn:@"customer_name_brief"];
        rtn.global_region_code = [result stringForColumn:@"global_region_code"];
        rtn.nation_region_code = [result stringForColumn:@"nation_region_code"];
        rtn.city_region_code = [result stringForColumn:@"city_region_code"];
        rtn.county_region_code = [result stringForColumn:@"county_region_code"];
        rtn.customer_address = [result stringForColumn:@"customer_address"];
        rtn.customer_phone = [result stringForColumn:@"customer_phone"];
        rtn.customer_mobile = [result stringForColumn:@"customer_mobile"];
        rtn.customer_fax = [result stringForColumn:@"customer_fax"];
        rtn.customer_zip_code = [result stringForColumn:@"customer_zip_code"];
        rtn.customer_mail = [result stringForColumn:@"customer_mail"];
        rtn.customer_trade_code = [result stringForColumn:@"customer_trade_code"];
        rtn.customer_owner = [result stringForColumn:@"customer_owner"];
        rtn.customer_kind_id = [result stringForColumn:@"customer_kind_id"];
        rtn.customer_class_id = [result stringForColumn:@"customer_class_id"];
        rtn.customer_desc = [result stringForColumn:@"customer_desc"];
        rtn.customer_remark = [result stringForColumn:@"customer_remark"];
        rtn.customer_status = [result stringForColumn:@"customer_status"];
        rtn.is_send = [NSNumber numberWithInt:[result intForColumn:@"is_send"]];
        rtn.is_used = [NSNumber numberWithInt:[result intForColumn:@"is_used"]];
        rtn.create_userid = [result stringForColumn:@"create_userid"];
        rtn.create_time = [result dateForColumn:@"create_time"];
        rtn.update_userid = [result stringForColumn:@"update_userid"];
        rtn.update_time = [result dateForColumn:@"update_time"];
        rtn.data_version = [NSNumber numberWithInt:[result intForColumn:@"data_version"]];
        rtn.data_status = [NSNumber numberWithInt:[result intForColumn:@"data_status"]];
        [array addObject:rtn];
    }
    [db close];
    return array;
}

+ (client_customer *)convertJsonToModel:(NSDictionary *)json
{
    client_customer *model = [[client_customer alloc] init];
    model.customer_id = [json objectForKey:@"customer_id"];
    model.customer_code = [json objectForKey:@"customer_code"];
    model.customer_picture_url = [json objectForKey:@"customer_picture_url"];
    model.customer_name = [json objectForKey:@"customer_name"];
    model.customer_name_brief = [json objectForKey:@"customer_name_brief"];
    model.global_region_code = [json objectForKey:@"global_region_code"];
    model.nation_region_code = [json objectForKey:@"nation_region_code"];
    model.city_region_code = [json objectForKey:@"city_region_code"];
    model.county_region_code = [json objectForKey:@"county_region_code"];
    model.customer_address = [json objectForKey:@"customer_address"];
    model.customer_phone = [json objectForKey:@"customer_phone"];
    model.customer_mobile = [json objectForKey:@"customer_mobile"];
    model.customer_fax = [json objectForKey:@"customer_fax"];
    model.customer_zip_code = [json objectForKey:@"customer_zip_code"];
    model.customer_mail = [json objectForKey:@"customer_mail"];
    model.customer_trade_code = [json objectForKey:@"customer_trade_code"];
    model.customer_owner = [json objectForKey:@"customer_owner"];
    model.customer_kind_id = [json objectForKey:@"customer_kind_id"];
    model.customer_class_id = [json objectForKey:@"customer_class_id"];
    model.customer_desc = [json objectForKey:@"customer_desc"];
    model.customer_remark = [json objectForKey:@"customer_remark"];
    model.customer_status = [json objectForKey:@"customer_status"];
    model.is_send = [json objectForKey:@"is_send"];
    model.is_used = [json objectForKey:@"is_used"];
    model.create_userid = [json objectForKey:@"create_userid"];
    model.create_time =[BaseInfo getDateFromMSDateString:[json objectForKey:@"create_time"]];
    model.update_userid = [json objectForKey:@"update_userid"];
    model.update_time =[BaseInfo getDateFromMSDateString:[json objectForKey:@"update_time"]];
    model.data_version = [json objectForKey:@"data_version"];
    model.data_status = [json objectForKey:@"data_status"];
    return model;
}

+ (NSArray *)convertJsonToList:(NSArray *)jsons
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSDictionary *json in jsons) {
        client_customer *model = [[client_customer alloc] init];
        model.customer_id = [json objectForKey:@"customer_id"];
        model.customer_code = [json objectForKey:@"customer_code"];
        model.customer_picture_url = [json objectForKey:@"customer_picture_url"];
        model.customer_name = [json objectForKey:@"customer_name"];
        model.customer_name_brief = [json objectForKey:@"customer_name_brief"];
        model.global_region_code = [json objectForKey:@"global_region_code"];
        model.nation_region_code = [json objectForKey:@"nation_region_code"];
        model.city_region_code = [json objectForKey:@"city_region_code"];
        model.county_region_code = [json objectForKey:@"county_region_code"];
        model.customer_address = [json objectForKey:@"customer_address"];
        model.customer_phone = [json objectForKey:@"customer_phone"];
        model.customer_mobile = [json objectForKey:@"customer_mobile"];
        model.customer_fax = [json objectForKey:@"customer_fax"];
        model.customer_zip_code = [json objectForKey:@"customer_zip_code"];
        model.customer_mail = [json objectForKey:@"customer_mail"];
        model.customer_trade_code = [json objectForKey:@"customer_trade_code"];
        model.customer_owner = [json objectForKey:@"customer_owner"];
        model.customer_kind_id = [json objectForKey:@"customer_kind_id"];
        model.customer_class_id = [json objectForKey:@"customer_class_id"];
        model.customer_desc = [json objectForKey:@"customer_desc"];
        model.customer_remark = [json objectForKey:@"customer_remark"];
        model.customer_status = [json objectForKey:@"customer_status"];
        model.is_send = [json objectForKey:@"is_send"];
        model.is_used = [json objectForKey:@"is_used"];
        model.create_userid = [json objectForKey:@"create_userid"];
        model.create_time =[BaseInfo getDateFromMSDateString:[json objectForKey:@"create_time"]];
        model.update_userid = [json objectForKey:@"update_userid"];
        model.update_time =[BaseInfo getDateFromMSDateString:[json objectForKey:@"update_time"]];
        model.data_version = [json objectForKey:@"data_version"];
        model.data_status = [json objectForKey:@"data_status"];
        [array addObject:model];
    }
    return array;
}

@end