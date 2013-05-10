#import "client_customer_contacter_dal.h"

@implementation client_customer_contacter_dal

+ (BOOL)exists:(NSString *)contacter_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    FMResultSet *result = [db executeQuery:@"SELECT COUNT(contacter_id) FROM client_customer_contacter WHERE contacter_id = ?", contacter_id];
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

+ (BOOL)add:(client_customer_contacter *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"INSERT INTO client_customer_contacter (contacter_id, customer_id, customer_code, contacter_code, contacter_name, contacter_sex, contacter_role, contacter_position, contacter_office_phone, contacter_mobile, is_used, create_userid, create_time, update_userid, update_time, data_version) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", model.contacter_id, model.customer_id, model.customer_code, model.contacter_code, model.contacter_name, model.contacter_sex, model.contacter_role, model.contacter_position, model.contacter_office_phone, model.contacter_mobile, model.is_used, model.create_userid, model.create_time, model.update_userid, model.update_time, model.data_version];
    [db close];
    return rtn;
}

+ (BOOL)update:(client_customer_contacter *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"UPDATE client_customer_contacter SET customer_id = ?, customer_code = ?, contacter_code = ?, contacter_name = ?, contacter_sex = ?, contacter_role = ?, contacter_position = ?, contacter_office_phone = ?, contacter_mobile = ?, is_used = ?, create_userid = ?, create_time = ?, update_userid = ?, update_time = ?, data_version = ? WHERE contacter_id = ?", model.customer_id, model.customer_code, model.contacter_code, model.contacter_name, model.contacter_sex, model.contacter_role, model.contacter_position, model.contacter_office_phone, model.contacter_mobile, model.is_used, model.create_userid, model.create_time, model.update_userid, model.update_time, model.data_version, model.contacter_id];
    [db close];
    return rtn;
}

+ (BOOL)delete:(NSString *)contacter_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"DELETE FROM client_customer_contacter WHERE contacter_id = ?", contacter_id];
    [db close];
    return rtn;
}

+ (BOOL)deleteList:(NSString *)where
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    NSString *strSql = [NSString stringWithFormat:@"DELETE FROM client_customer_contacter WHERE %@", where];
    rtn = [db executeUpdate:strSql];
    [db close];
    return rtn;
}

+ (client_customer_contacter *)get:(NSString *)contacter_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    client_customer_contacter *rtn;
    FMResultSet *result = [db executeQuery:@"SELECT * FROM client_customer_contacter WHERE contacter_id = ?", contacter_id];
    while ([result next]) {
        rtn = [[client_customer_contacter alloc] init];
        rtn.contacter_id = [result stringForColumn:@"contacter_id"];
        rtn.customer_id = [result stringForColumn:@"customer_id"];
        rtn.customer_code = [result stringForColumn:@"customer_code"];
        rtn.contacter_code = [result stringForColumn:@"contacter_code"];
        rtn.contacter_name = [result stringForColumn:@"contacter_name"];
        rtn.contacter_sex = [result stringForColumn:@"contacter_sex"];
        rtn.contacter_role = [result stringForColumn:@"contacter_role"];
        rtn.contacter_position = [result stringForColumn:@"contacter_position"];
        rtn.contacter_office_phone = [result stringForColumn:@"contacter_office_phone"];
        rtn.contacter_mobile = [result stringForColumn:@"contacter_mobile"];
        rtn.is_used = [NSNumber numberWithInt:[result intForColumn:@"is_used"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_customer_contacter WHERE %@", where];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_customer_contacter *rtn = [[client_customer_contacter alloc] init];
        rtn.contacter_id = [result stringForColumn:@"contacter_id"];
        rtn.customer_id = [result stringForColumn:@"customer_id"];
        rtn.customer_code = [result stringForColumn:@"customer_code"];
        rtn.contacter_code = [result stringForColumn:@"contacter_code"];
        rtn.contacter_name = [result stringForColumn:@"contacter_name"];
        rtn.contacter_sex = [result stringForColumn:@"contacter_sex"];
        rtn.contacter_role = [result stringForColumn:@"contacter_role"];
        rtn.contacter_position = [result stringForColumn:@"contacter_position"];
        rtn.contacter_office_phone = [result stringForColumn:@"contacter_office_phone"];
        rtn.contacter_mobile = [result stringForColumn:@"contacter_mobile"];
        rtn.is_used = [NSNumber numberWithInt:[result intForColumn:@"is_used"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_customer_contacter WHERE %@ ORDER BY %@", where, order];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_customer_contacter *rtn = [[client_customer_contacter alloc] init];
        rtn.contacter_id = [result stringForColumn:@"contacter_id"];
        rtn.customer_id = [result stringForColumn:@"customer_id"];
        rtn.customer_code = [result stringForColumn:@"customer_code"];
        rtn.contacter_code = [result stringForColumn:@"contacter_code"];
        rtn.contacter_name = [result stringForColumn:@"contacter_name"];
        rtn.contacter_sex = [result stringForColumn:@"contacter_sex"];
        rtn.contacter_role = [result stringForColumn:@"contacter_role"];
        rtn.contacter_position = [result stringForColumn:@"contacter_position"];
        rtn.contacter_office_phone = [result stringForColumn:@"contacter_office_phone"];
        rtn.contacter_mobile = [result stringForColumn:@"contacter_mobile"];
        rtn.is_used = [NSNumber numberWithInt:[result intForColumn:@"is_used"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_customer_contacter WHERE %@ ORDER BY %@ LIMIT 0,%d", where, order, top];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_customer_contacter *rtn = [[client_customer_contacter alloc] init];
        rtn.contacter_id = [result stringForColumn:@"contacter_id"];
        rtn.customer_id = [result stringForColumn:@"customer_id"];
        rtn.customer_code = [result stringForColumn:@"customer_code"];
        rtn.contacter_code = [result stringForColumn:@"contacter_code"];
        rtn.contacter_name = [result stringForColumn:@"contacter_name"];
        rtn.contacter_sex = [result stringForColumn:@"contacter_sex"];
        rtn.contacter_role = [result stringForColumn:@"contacter_role"];
        rtn.contacter_position = [result stringForColumn:@"contacter_position"];
        rtn.contacter_office_phone = [result stringForColumn:@"contacter_office_phone"];
        rtn.contacter_mobile = [result stringForColumn:@"contacter_mobile"];
        rtn.is_used = [NSNumber numberWithInt:[result intForColumn:@"is_used"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_customer_contacter WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_customer_contacter *rtn = [[client_customer_contacter alloc] init];
        rtn.contacter_id = [result stringForColumn:@"contacter_id"];
        rtn.customer_id = [result stringForColumn:@"customer_id"];
        rtn.customer_code = [result stringForColumn:@"customer_code"];
        rtn.contacter_code = [result stringForColumn:@"contacter_code"];
        rtn.contacter_name = [result stringForColumn:@"contacter_name"];
        rtn.contacter_sex = [result stringForColumn:@"contacter_sex"];
        rtn.contacter_role = [result stringForColumn:@"contacter_role"];
        rtn.contacter_position = [result stringForColumn:@"contacter_position"];
        rtn.contacter_office_phone = [result stringForColumn:@"contacter_office_phone"];
        rtn.contacter_mobile = [result stringForColumn:@"contacter_mobile"];
        rtn.is_used = [NSNumber numberWithInt:[result intForColumn:@"is_used"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_customer_contacter WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_customer_contacter *rtn = [[client_customer_contacter alloc] init];
        rtn.contacter_id = [result stringForColumn:@"contacter_id"];
        rtn.customer_id = [result stringForColumn:@"customer_id"];
        rtn.customer_code = [result stringForColumn:@"customer_code"];
        rtn.contacter_code = [result stringForColumn:@"contacter_code"];
        rtn.contacter_name = [result stringForColumn:@"contacter_name"];
        rtn.contacter_sex = [result stringForColumn:@"contacter_sex"];
        rtn.contacter_role = [result stringForColumn:@"contacter_role"];
        rtn.contacter_position = [result stringForColumn:@"contacter_position"];
        rtn.contacter_office_phone = [result stringForColumn:@"contacter_office_phone"];
        rtn.contacter_mobile = [result stringForColumn:@"contacter_mobile"];
        rtn.is_used = [NSNumber numberWithInt:[result intForColumn:@"is_used"]];
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

+ (client_customer_contacter *)convertJsonToModel:(NSDictionary *)json
{
    client_customer_contacter *model = [[client_customer_contacter alloc] init];
    model.contacter_id = [json objectForKey:@"contacter_id"];
    model.customer_id = [json objectForKey:@"customer_id"];
    model.customer_code = [json objectForKey:@"customer_code"];
    model.contacter_code = [json objectForKey:@"contacter_code"];
    model.contacter_name = [json objectForKey:@"contacter_name"];
    model.contacter_sex = [json objectForKey:@"contacter_sex"];
    model.contacter_role = [json objectForKey:@"contacter_role"];
    model.contacter_position = [json objectForKey:@"contacter_position"];
    model.contacter_office_phone = [json objectForKey:@"contacter_office_phone"];
    model.contacter_mobile = [json objectForKey:@"contacter_mobile"];
    model.is_used = [json objectForKey:@"is_used"];
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
        client_customer_contacter *model = [[client_customer_contacter alloc] init];
        model.contacter_id = [json objectForKey:@"contacter_id"];
        model.customer_id = [json objectForKey:@"customer_id"];
        model.customer_code = [json objectForKey:@"customer_code"];
        model.contacter_code = [json objectForKey:@"contacter_code"];
        model.contacter_name = [json objectForKey:@"contacter_name"];
        model.contacter_sex = [json objectForKey:@"contacter_sex"];
        model.contacter_role = [json objectForKey:@"contacter_role"];
        model.contacter_position = [json objectForKey:@"contacter_position"];
        model.contacter_office_phone = [json objectForKey:@"contacter_office_phone"];
        model.contacter_mobile = [json objectForKey:@"contacter_mobile"];
        model.is_used = [json objectForKey:@"is_used"];
        model.create_userid = [json objectForKey:@"create_userid"];
        model.create_time =[BaseInfo getDateFromMSDateString:[json objectForKey:@"create_time"]];
        model.update_userid = [json objectForKey:@"update_userid"];
        model.update_time =[BaseInfo getDateFromMSDateString:[json objectForKey:@"update_time"]];
        model.data_version = [json objectForKey:@"data_version"];
        [array addObject:model];
    }
    return array;
}

@end