#import "client_user_login_dal.h"

@implementation client_user_login_dal

+ (NSNumber *)getMaxId
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    NSNumber *rtn;
    FMResultSet *result = [db executeQuery:@"SELECT MAX(user_login_id) FROM client_user_login"];
    if ([result next]) {
        int maxId = [result intForColumnIndex:0] + 1;
        rtn = [NSNumber numberWithInt:maxId];
    }
    [db close];
    return rtn;
}

+ (BOOL)exists:(NSNumber *)user_login_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    FMResultSet *result = [db executeQuery:@"SELECT COUNT(user_login_id) FROM client_user_login WHERE user_login_id = ?", user_login_id];
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

+ (BOOL)add:(client_user_login *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"INSERT INTO client_user_login (user_login_id, user_name, user_real_name, user_level, user_area, user_password, ipad_mac_address, user_ipad_key, login_time, login_result) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", model.user_login_id, model.user_name, model.user_real_name, model.user_level, model.user_area, model.user_password, model.ipad_mac_address, model.user_ipad_key, model.login_time, model.login_result];
    [db close];
    return rtn;
}

+ (BOOL)update:(client_user_login *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"UPDATE client_user_login SET user_name = ?, user_real_name = ?, user_level = ?, user_area = ?, user_password = ?, ipad_mac_address = ?, user_ipad_key = ?, login_time = ?, login_result = ? WHERE user_login_id = ?", model.user_name, model.user_real_name, model.user_level, model.user_area, model.user_password, model.ipad_mac_address, model.user_ipad_key, model.login_time, model.login_result, model.user_login_id];
    [db close];
    return rtn;
}

+ (BOOL)delete:(NSNumber *)user_login_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"DELETE FROM client_user_login WHERE user_login_id = ?", user_login_id];
    [db close];
    return rtn;
}

+ (BOOL)deleteList:(NSString *)where
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    NSString *strSql = [NSString stringWithFormat:@"DELETE FROM client_user_login WHERE %@", where];
    rtn = [db executeUpdate:strSql];
    [db close];
    return rtn;
}

+ (client_user_login *)get:(NSNumber *)user_login_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    client_user_login *rtn;
    FMResultSet *result = [db executeQuery:@"SELECT * FROM client_user_login WHERE user_login_id = ?", user_login_id];
    while ([result next]) {
        rtn = [[client_user_login alloc] init];
        rtn.user_login_id = [NSNumber numberWithInt:[result intForColumn:@"user_login_id"]];
        rtn.user_name = [result stringForColumn:@"user_name"];
        rtn.user_real_name = [result stringForColumn:@"user_real_name"];
        rtn.user_level = [result stringForColumn:@"user_level"];
        rtn.user_area = [result stringForColumn:@"user_area"];
        rtn.user_password = [result stringForColumn:@"user_password"];
        rtn.ipad_mac_address = [result stringForColumn:@"ipad_mac_address"];
        rtn.user_ipad_key = [result stringForColumn:@"user_ipad_key"];
        rtn.login_time = [result dateForColumn:@"login_time"];
        rtn.login_result = [NSNumber numberWithInt:[result intForColumn:@"login_result"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_user_login WHERE %@", where];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_user_login *rtn = [[client_user_login alloc] init];
        rtn.user_login_id = [NSNumber numberWithInt:[result intForColumn:@"user_login_id"]];
        rtn.user_name = [result stringForColumn:@"user_name"];
        rtn.user_real_name = [result stringForColumn:@"user_real_name"];
        rtn.user_level = [result stringForColumn:@"user_level"];
        rtn.user_area = [result stringForColumn:@"user_area"];
        rtn.user_password = [result stringForColumn:@"user_password"];
        rtn.ipad_mac_address = [result stringForColumn:@"ipad_mac_address"];
        rtn.user_ipad_key = [result stringForColumn:@"user_ipad_key"];
        rtn.login_time = [result dateForColumn:@"login_time"];
        rtn.login_result = [NSNumber numberWithInt:[result intForColumn:@"login_result"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_user_login WHERE %@ ORDER BY %@", where, order];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_user_login *rtn = [[client_user_login alloc] init];
        rtn.user_login_id = [NSNumber numberWithInt:[result intForColumn:@"user_login_id"]];
        rtn.user_name = [result stringForColumn:@"user_name"];
        rtn.user_real_name = [result stringForColumn:@"user_real_name"];
        rtn.user_level = [result stringForColumn:@"user_level"];
        rtn.user_area = [result stringForColumn:@"user_area"];
        rtn.user_password = [result stringForColumn:@"user_password"];
        rtn.ipad_mac_address = [result stringForColumn:@"ipad_mac_address"];
        rtn.user_ipad_key = [result stringForColumn:@"user_ipad_key"];
        rtn.login_time = [result dateForColumn:@"login_time"];
        rtn.login_result = [NSNumber numberWithInt:[result intForColumn:@"login_result"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_user_login WHERE %@ ORDER BY %@ LIMIT 0,%d", where, order, top];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_user_login *rtn = [[client_user_login alloc] init];
        rtn.user_login_id = [NSNumber numberWithInt:[result intForColumn:@"user_login_id"]];
        rtn.user_name = [result stringForColumn:@"user_name"];
        rtn.user_real_name = [result stringForColumn:@"user_real_name"];
        rtn.user_level = [result stringForColumn:@"user_level"];
        rtn.user_area = [result stringForColumn:@"user_area"];
        rtn.user_password = [result stringForColumn:@"user_password"];
        rtn.ipad_mac_address = [result stringForColumn:@"ipad_mac_address"];
        rtn.user_ipad_key = [result stringForColumn:@"user_ipad_key"];
        rtn.login_time = [result dateForColumn:@"login_time"];
        rtn.login_result = [NSNumber numberWithInt:[result intForColumn:@"login_result"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_user_login WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_user_login *rtn = [[client_user_login alloc] init];
        rtn.user_login_id = [NSNumber numberWithInt:[result intForColumn:@"user_login_id"]];
        rtn.user_name = [result stringForColumn:@"user_name"];
        rtn.user_real_name = [result stringForColumn:@"user_real_name"];
        rtn.user_level = [result stringForColumn:@"user_level"];
        rtn.user_area = [result stringForColumn:@"user_area"];
        rtn.user_password = [result stringForColumn:@"user_password"];
        rtn.ipad_mac_address = [result stringForColumn:@"ipad_mac_address"];
        rtn.user_ipad_key = [result stringForColumn:@"user_ipad_key"];
        rtn.login_time = [result dateForColumn:@"login_time"];
        rtn.login_result = [NSNumber numberWithInt:[result intForColumn:@"login_result"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_user_login WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_user_login *rtn = [[client_user_login alloc] init];
        rtn.user_login_id = [NSNumber numberWithInt:[result intForColumn:@"user_login_id"]];
        rtn.user_name = [result stringForColumn:@"user_name"];
        rtn.user_real_name = [result stringForColumn:@"user_real_name"];
        rtn.user_level = [result stringForColumn:@"user_level"];
        rtn.user_area = [result stringForColumn:@"user_area"];
        rtn.user_password = [result stringForColumn:@"user_password"];
        rtn.ipad_mac_address = [result stringForColumn:@"ipad_mac_address"];
        rtn.user_ipad_key = [result stringForColumn:@"user_ipad_key"];
        rtn.login_time = [result dateForColumn:@"login_time"];
        rtn.login_result = [NSNumber numberWithInt:[result intForColumn:@"login_result"]];
        [array addObject:rtn];
    }
    [db close];
    return array;
}

+ (client_user_login *)convertJsonToModel:(NSDictionary *)json
{
    client_user_login *model = [[client_user_login alloc] init];
    model.user_login_id = [json objectForKey:@"user_login_id"];
    model.user_name = [json objectForKey:@"user_name"];
    model.user_real_name = [json objectForKey:@"user_real_name"];
    model.user_level = [json objectForKey:@"user_level"];
    model.user_area = [json objectForKey:@"user_area"];
    model.user_password = [json objectForKey:@"user_password"];
    model.ipad_mac_address = [json objectForKey:@"ipad_mac_address"];
    model.user_ipad_key = [json objectForKey:@"user_ipad_key"];
    model.login_time =[BaseInfo getDateFromMSDateString:[json objectForKey:@"login_time"]];
    model.login_result = [json objectForKey:@"login_result"];
    return model;
}

+ (NSArray *)convertJsonToList:(NSArray *)jsons
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSDictionary *json in jsons) {
        client_user_login *model = [[client_user_login alloc] init];
        model.user_login_id = [json objectForKey:@"user_login_id"];
        model.user_name = [json objectForKey:@"user_name"];
        model.user_real_name = [json objectForKey:@"user_real_name"];
        model.user_level = [json objectForKey:@"user_level"];
        model.user_area = [json objectForKey:@"user_area"];
        model.user_password = [json objectForKey:@"user_password"];
        model.ipad_mac_address = [json objectForKey:@"ipad_mac_address"];
        model.user_ipad_key = [json objectForKey:@"user_ipad_key"];
        model.login_time =[BaseInfo getDateFromMSDateString:[json objectForKey:@"login_time"]];
        model.login_result = [json objectForKey:@"login_result"];
        [array addObject:model];
    }
    return array;
}

@end